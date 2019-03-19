class ImageController < ApplicationController
      def new
        @image = Image.build.params(image_params)
      end
     
      def show
        @image = Image.find(params[:id])
      end
     
      private
     
      def image_params
        # params.require(:image).permit(:file, :hint, :alt, :post_id, :all_notice_id)
        params.require(:image).permit(:file, :hint, :alt, :notice_id, :freeboard_id)
      end
end
