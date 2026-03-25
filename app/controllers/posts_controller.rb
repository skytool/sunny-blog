class PostsController < ApplicationController
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :authorize_user!, only: [ :edit, :update, :destroy ]

  def index
    @posts = Post.published.recent.includes(:category, :user, :tags)
    @posts = @posts.where(category_id: params[:category_id]) if params[:category_id].present?
    @posts = @posts.where("title LIKE ?", "%#{params[:q]}%") if params[:q].present?
    @categories = Category.all
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :asc)
  end

  def new
    @post = current_user.posts.build
    @categories = Category.all
    @tags = Tag.all
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "글이 작성되었습니다."
    else
      @categories = Category.all
      @tags = Tag.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @categories = Category.all
    @tags = Tag.all
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "글이 수정되었습니다."
    else
      @categories = Category.all
      @tags = Tag.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "글이 삭제되었습니다."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user!
    redirect_to posts_path, alert: "권한이 없습니다." unless @post.user == current_user
  end

  def post_params
    params.require(:post).permit(:title, :content, :excerpt, :published, :category_id, :cover_image, tag_ids: [], photos: [])
  end
end
