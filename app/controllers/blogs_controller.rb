class BlogsController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  require 'base64'

  def index
    @blogs = Blog.where(user_id: current_user.id).paginate(page: params[:page], per_page: 5)
  end


  def show
    @blog = Blog.find(params[:id])
  end


  def edit
    @blog = Blog.find(params[:id])
    @btnsave = "Update"
  end


  def update
    image = params[:image]
    @blog = Blog.find(params[:id])
    if @blog.update_attributes(blog_params)
      if image.present?
        image64 = image.split(",").second
        io = BlogImageString.new(Base64.decode64(image64))
        io.original_filename = "foobar.png"
        io.content_type = "image/png"
        @blog.image = io
        @blog.save
      end
        flash[:success] = "Blog updates!"
        redirect_to blogs_path
    else
      flash.now[:error] = "Could not update"
      redirect_to root_path
    end
  end


  def new
  	@blog = Blog.new
    @categories = Category.all
    @btnsave = "Create"
  end

  def create	

    image = params[:image]
    @blog = Blog.new(blog_params)
    # current_user.blogs.new(params[:blogs])  won't work
    @blog.user_id = current_user.id
    puts "hello world"
    puts @blog.id

  	if @blog.save

      if image.present?
        image64 = image.split(",").second
        io = BlogImageString.new(Base64.decode64(image64))
        io.original_filename = "foobar.png"
        io.content_type = "image/png"
        @blog.image = io
        @blog.save
      end

      if params[:categories].present?
          puts "categoryispresent"
        params[:categories].each do |category|
          @blog_category = BlogsCategory.create({blog_id: @blog.id, category_id: category.to_i})
          puts "numbercategories"
        end
      end

        flash[:success] = "Blog created!"
        redirect_to root_path
  	else
  		flash.now[:error] = "Could not save"
  		redirect_to root_path
  	end
  end

  private
    
    def blog_params
      params.require(:blog).permit(:image, :title, :caption, :description, category_id:[])
    end
    
end

class BlogImageString < StringIO
  attr_accessor :original_filename, :content_type
end
