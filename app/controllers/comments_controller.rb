class CommentsController < ApplicationController
    before_action :authenticate_user!
   
    def create
      commentable = commentable_type.constantize.find(commentable_id)
      @comment = Comment.build_from(commentable, current_user.id, body)
      @comment.user = current_user
      
      respond_to do |format|
        if @comment.save
            make_child_comment
            format.html  { redirect_to("#{request.referrer}#comment#{@comment.id}", :notice => '댓글이 작성되었습니다.') }
                # 댓글에 대댓글 작성 시 댓글 작성자에게 알림이 울림.
                if @comment.parent != nil && @comment.parent.user != current_user
                    @new_alarm = NewAlarm.create! user:  @comment.parent.user,
                                                  # content: "#{current_user.name.truncate(15, omission: '...')} 님이 답댓글을 달았습니다.",
                                                  content: "",
                                                  link: request.referrer
                  
                end  
        else
            format.html  { redirect_to(request.referrer, :alert => '댓글 내용을 작성해주세요.') }
        end
      end

      if @comment.parent == nil && commentable.user != current_user
        @new_alarm = NewAlarm.create! user: commentable.user,
                                    # content: "#{current_user.name.truncate(15, omission: '...')} 님이 댓글을 달았습니다.",
                                    link: request.referrer
      end                             
    end

    def destroy
        @comment = Comment.find_by(id: params[:id])
        @comment.delete
        respond_to do |format|
          format.html { redirect_to(request.referrer, :notice => '댓글이 삭제되었습니다.')}
          format.js
        end
    end
   
    private
   
    def comment_params
      params[:comment][:user_id] = current_user.id
      params.require(:comment).permit(:body, :commentable_id, :commentable_type, :comment_id, :user_id, :name)
    end
   
    def commentable_type
      comment_params[:commentable_type]
    end
   
    def commentable_id
      comment_params[:commentable_id]
    end
   
    def comment_id
      comment_params[:comment_id]
    end
   
    def body
      comment_params[:body]
    end
   
    def make_child_comment
      return "" if comment_id.blank?
   
      parent_comment = Comment.find comment_id
      @comment.move_to_child_of(parent_comment)
    end
  end