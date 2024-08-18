class Public::PostsController < ApplicationController
  def new
      @post = Post.new
  end

  def create
     @post = Post.new(post_params)
     @post.user_id = current_user.id
     tag_list = params[:post][:tag_ids].split(',')
     @post.image.attach(params[:post][:image])
    if @post.save
      @post.save_tags(tag_list)
      redirect_to post_path(@post)
    else
      redirect_back fallback_location: root_path, alert: "コメントの作成に失敗しました。"
    end
  end



  def index
      @comments = Comment.new
      @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
      @tags = Tag.all
  end

  def show
      @post = Post.find(params[:id])
      @comment = Comment.new
  end

  def destroy
    @post = Post.find(params[:id])
     if @post.deletable_by?(current_user)
       @post.destroy
       redirect_to posts_path, notice: "投稿を削除しました"
     else
       redirect_to posts_path, alert: "削除できません"
     end
  end

  def current_user_can_delete?(post)
    post.user_id == current_user.id
  end



  def tags
    @tags = Tag.all
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

   #def create
    #byebug ←デバック使用
    # @post = current_user.posts.build(post_params)
  #   tag_list = params[:post][:tag_ids].split(',')
  #   @post.image.attach(params[:post][:image])
  #   if @post.save
  #     @post.save_tags(tag_list)
  #     flash[:success] = "Post created!"
  #     redirect_to root_url
  #   else
  #     render 'new', status: :unprocessable_entity
  #   end
  # end


  private

  def post_params
  params.require(:post).permit(:title, :body, :link, :tag, :status, :image,)
  end

  def comment_params
  params.require(:comment).permit(:body)
  end

end
