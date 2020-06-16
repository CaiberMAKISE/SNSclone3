class BlogsController < ApplicationController
    before_action :set_blog, only: [:show, :edit, :update, :destroy]
    def index
      @blogs = Blog.all
    end
    def new
      @blog = Blog.new
    end
    def create
      @blog = current_user.blogs.build(blog_params)
      if params[:back]
        render :new
      else
        if @blog.save
          PostMailer.contact_mail(@blog).deliver
          redirect_to blogs_path, notice: "ブログを作成しました！"
        else
          render :new
        end
      end
    end
    def show
      @favorite = current_user.favorites.find_by(blog_id: @blog.id)
    end
    def edit
    end
    def update
      if @blog.update(blog_params)
        redirect_to blogs_path, notice:"ブログを更新しました！"
      else
        render :edit
      end
    end
    def destroy
      @blog.destroy
      redirect_to blogs_path, notice:"ブログを削除しました！"
    end
    def confirm
      @blog = current_user.blogs.build(blog_params)
      render :new if @blog.invalid?
    end
    private
    def blog_params
      params.require(:blog).permit(:user_id,:content, :image, :image_cache)
    end
    def set_blog
      @blog = Blog.find(params[:id])
    end
  end