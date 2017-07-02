class PostsController < ApplicationController
  before_action :authenticate_user!, :only => [:create, :destroy]

  def index
    @posts = Post.order("id DESC").all     #新的贴文放在前面
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save
  end

  def destroy
    @post = current_user.posts.find(params[:id])      #只能删除自己的贴文
    @post.destroy
  end


  # 按赞功能

  def like
    @post = Post.find(params[:id])
    unless @post.find_like(current_user)    #如果已经按过，就不能再新增
      Like.create( :user => current_user, :post => @post)
    end
  end

  def unlike
    @post = Post.find(params[:id])
    like = @post.find_like(current_user)
    like.destroy

    render "like"
  end


  # 收藏功能

  def collection
    @post = Post.find(params[:id])
    unless @post.find_collection(current_user)    #如果已经按过，就不能再新增
      Collection.create( :user => current_user, :post => @post)
    end
  end

  def uncollection
    @post = Post.find(params[:id])
    collection = @post.find_collection(current_user)
    collection.destroy

    render "collection"
  end


  private

  def post_params
    params.require(:post).permit(:content)
  end

end
