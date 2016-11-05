class BlogsController < ApplicationController

    #before_action :logged_in_user,  only: [:create, :destroy, :new]
    before_action :super_user,      only: [:destroy, :edit, :update]
    before_action :set_blog,        only: [:show]
    before_action :admin_user,      only: [:destroy]

    def index
        @blogs = Blog.paginate(page: params[:page])
    end

    def new
        @blog = Blog.new
    end

    def create
        @blog = current_user.blogs.build(blog_params)
        if @blog.save
            flash[:success] = 'Blog post created!'
            redirect_to blogs_path
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @blog.update_attributes(blog_params)
            flash[:success] = 'Blog post updated!'
            render 'show'
        else
            render 'edit'
        end
    end

    def show
    end

    def destroy
        Blog.find(params[:id]).destroy
        flash[:success] = 'Blog post deleted!'
        redirect_to request.referrer || root_url
    end

    private

    def set_blog
        @blog = Blog.find(params[:id])
    end

    def blog_params
        params.require(:blog).permit(:blog_content, :blog_title, :blog_subtitle)
    end

    def super_user
        @blog = Blog.find_by(id: params[:id])
        redirect_to root_url if @blog.nil?
    end
end
