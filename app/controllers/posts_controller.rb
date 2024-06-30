class PostsController < ApplicationController
  def new
      @post = Post.new
  end

  def create
     @post = Post.new(post_params)
     @post.user_id = current_user.id
     @post.save
     redirect_to posts_path
  end

  def index
      @posts = Post.all

  end

  def show
      @post = Post.all
      @tags = @post.tag_counts_on(:tags)
  end

  def destroy
    @posts = Post.find(params[:id])
    @posts.destroy
    redirect_to post_index_path
  end

  #def edit
     #@posts = Post.find(params[:id])
  #end

  #def update
    #@posts = Post.find(params[:id])
    #if @posts.update(post_params)

    #redirect_to post_path(post)
    #else
    #render :edit
    #end
   #end




  private

  def post_params
  params.require(:post).permit(:title, :body, :link, :tag_list, :status, :image)
  end

end
