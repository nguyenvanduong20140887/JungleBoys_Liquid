class CommentsController < ApplicationController
    def new
        @comment = Comment.new
        @comment.rating.build
    end
    
    def create
        @comment = Comment.new(post_params)
        
        respond_to do |format|
            if @comment.save
                format.html { redirect_to @comment, notice: 'Comment được tạo thành công' }
                format.js   { }
            else
                format.html { render :new }
                format.json { render json: @comment.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def destroy
        @comment = Comment.find(params[:id])
        respond_to do |format|
            if @comment.rating.destroy && @comment.destroy
                format.html { redirect_to room_path(@comment.room_id) }
                format.js   { }
            end
        end
    end

    private
    def post_params
        params.require(:comment).permit(:room_id, :user_id, :text_content, rating_attributes: [:room_id, :comment_id, :stars])
    end
end
