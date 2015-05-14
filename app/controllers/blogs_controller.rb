class BlogsController < ApplicationController

  before_action :authenticate_user!, except: [:show]

  def index
    @blogs = Blog.where(user_id: current_user.id).paginate(page: params[:page], per_page: 5)
  end


  def show
    @blog = Blog.find(params[:id])
  end


  def edit
    @blog = Blog.find(params[:id])
  end


  def update
    @blog = Blog.find(params[:id])
    if @blog.update_attributes(user_params)
      redirect_to blogs_path
    end
  end


  def new
  	@blog = Blog.new
    @categor = Category.all
  end

  def create	
    @blog = Blog.new(blog_params)
    # current_user.blogs.new(params[:blogs])  won't work
    @blog.user_id = current_user.id


  	if @blog.save
  		flash[:success] = "Blog created!"
  		redirect_to root_path
  	else
  		flash.now[:error] = "Could not save"
  		redirect_to root_path
  	end
  end

  private
    
    def blog_params
      params.require(:blog).permit(:image, :title,:caption,:description)
    end

end
