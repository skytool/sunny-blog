module Admin
  class PostsController < BaseController
    before_action :set_post, only: [ :edit, :update, :destroy ]

    def index
      @posts = Post.includes(:user, :category).order(created_at: :desc)
    end

    def new
      @post = Post.new
      @categories = Category.all
      @tags = Tag.all
    end

    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        redirect_to admin_posts_path, notice: "포스트가 생성되었습니다."
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
        redirect_to admin_posts_path, notice: "포스트가 수정되었습니다."
      else
        @categories = Category.all
        @tags = Tag.all
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @post.destroy
      redirect_to admin_posts_path, notice: "포스트가 삭제되었습니다."
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :excerpt, :published, :category_id, :cover_image, tag_ids: [], photos: [])
    end
  end
end
