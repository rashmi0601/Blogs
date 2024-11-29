class BlogPostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_blog_post, only: %i[show edit update delete_blog_post approve reject]
    before_action :authorize_admin, only: %i[approve reject]

    def dashboard
        if current_user.admin?
            @approved_blogs = BlogPost.all.order(id: :desc)
            @my_blogs = current_user.blog_posts 
        else
            @approved_blogs = BlogPost.where(status: :approved)
            @my_blogs = current_user.blog_posts 
        end
        
      end
  
    def index
      if current_user.admin?
        @blog_posts = BlogPost.all
      else
        @blog_posts = BlogPost.where(status: :approved).or(BlogPost.where(user: current_user))
      end
    end
  
    def show; end
  
    def new
      @blog_post = current_user.blog_posts.new
    end
  
    def create
      @blog_post = current_user.blog_posts.new(blog_post_params)
      if @blog_post.save
        @blog_post.status
        redirect_to authenticated_root_path, notice: 'Blog post created successfully and is pending admin approval.'
      else
        render :new
      end
    end
  
    def edit; end
  
    def update
      if @blog_post.update(blog_post_params)
        redirect_to authenticated_root_path, notice: 'Blog post updated successfully.'
      else
        render :edit
      end
    end
  
    def delete_blog_post
      @blog_post = BlogPost.find(params[:id])
      @blog_post.destroy
      redirect_to authenticated_root_path, notice: 'Blog post deleted successfully.'
    end
  
    def approve
      @blog_post.update(status: :approved)
      redirect_to authenticated_root_path, notice: 'Blog post approved.'
    end
  
    def reject
      @blog_post.update(status: :rejected)
      redirect_to authenticated_root_path, notice: 'Blog post rejected.'
    end
  
    private
  
    def set_blog_post
      @blog_post = BlogPost.find(params[:id])
    end
  
    def blog_post_params
      params.require(:blog_post).permit(:title, :content, files: [])
    end
  
    def authorize_admin
      redirect_to root_path, alert: 'Access denied!' unless current_user.admin?
    end
  end
  