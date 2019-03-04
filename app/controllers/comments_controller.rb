class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post
  
  def create
    @comment = @post.comments.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comment was successfully created.' }
        format.json { render @post, status: :created, location: @comment }
      else
        format.html { render @post }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.user_id == current_user.id
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to @post, notice: 'Your comment was destroyed.' }
        format.json { render @post }
      end
    else
      flash[:alert] = "Not owned by user"
      redirect_to @post
    end
  end

  private

    def find_post
      @post = Post.find(params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:text, :user_id, :post_id)
    end
end
