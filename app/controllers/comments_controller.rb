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
                # if @comment.parent != nil && @comment.parent.user != current_user
                #     @new_alarm = NewAlarm.create! user:  @comment.parent.user,
                #                                   # content: "#{current_user.name.truncate(15, omission: '...')} 님이 답댓글을 달았습니다.",
                #                                   # content: "",
                #                                   link: request.referrer
                                                  
                  
                # end  
        else

            format.html  { redirect_to(request.referrer, :alert => '댓글 내용을 작성해주세요.') }
        end
      end
## 수정해야할부분 내작성글에 댓글달았을 때 거기에 답글다는경우(작성글댓글로알림)/내작성글에 a유저의 댓글에 b유저가 답글다는경우(나에게는 작성글댓글, a유저에겐 답글알림)
      if @comment.parent == nil && commentable.user != current_user 
        # puts "테스트 #{NewAlarm.where(link: freeboard_path(:id=>commentable)).count}끝"
        @alarms = NewAlarm.where(link: freeboard_path(:id=>commentable))
        if @alarms.count != 0
          @alarms[0].mark_as_read! for: commentable.user
          @new_alarm = NewAlarm.create! user: commentable.user,
                                          content: "#{Comment.where(commentable: commentable).count}",
                                          link: URI(request.referer).path
        else 
          @new_alarm = NewAlarm.create! user: commentable.user,
                                        content: "#{Comment.where(commentable: commentable).count}",
                                        link: URI(request.referer).path
        end  
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

  #추천기능
  def like
    @comment = Comment.find_by(id: params[:id])
    @comment.liked_by(current_user)
    redirect_back fallback_location: root_path
  end  
      
  def unvote
    @comment = Comment.find_by(id: params[:id])
    @comment.unvote_by(current_user)
    redirect_back fallback_location: root_path           
    # respond_to do |format|
    #   format.js {
    #     render "comments/votes"
    #   }
    # end
  end

  def dislike
    @comment = Comment.find_by(id: params[:id])
    @comment.dislike_by(current_user)
    redirect_back fallback_location: root_path           
    # respond_to do |format|
    #   format.js {
    #     render "comments/votes"
    #   }
    # end
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