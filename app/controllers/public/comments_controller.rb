class Public::CommentsController < ApplicationController
   before_action :authenticate_user!
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post_id = @post.id
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to post_path(@post)
    else
      redirect_back fallback_location: root_path, alert: "コメントの作成に失敗しました。"
    end
  end

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments

  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy
    redirect_to post_path(@post)
  end

  def show
  if params[:comment].present? && params[:comment][:post_id].present?
    @post = Post.find(params[:comment][:post_id])
  elsif params[:post_id].present?
    @post = Post.find(params[:post_id])
  end
  end


  private

  def comment_params
  params.require(:comment).permit(:body)
  end
end
