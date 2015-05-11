class BlogsController < ApplicationController

  before_action :logged_in_user, only: [:new, :edit, :index, :show, :create,]


  def index

  end


  def show

  end


  def edit
    @blog = Blog.find(params[:id])
  end


  def update
    @blog = Blog.find(params[:id])
    if @blog.update_attributes(user_params)
      render root_path
    end
  end


  def new
  	@blog = Blog.new
  end

  def create	
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
  	if @blog.save
  		flash[:success] = "Micropost created!"
  		redirect_to root_url
  	else
  		flash.now[:error] = "Could not save"
  		render '/pages/home'
  	end
  end

  private

    def blog_params
      params.require(:blog).permit(:title,:caption,:description)
    end

    # Confirms a logged-in user.
		def logged_in_user
			unless logged_in?
		      	store_location
		        flash[:danger] = "Please log in."
		        redirect_to root_path
		    end
		end

	  	# Returns true if the user is logged in, false otherwise.
  		def logged_in?
       		!current_user.nil?
      	end

      	def store_location
   		   session[:forwarding_url] = request.url if request.get?
   		end


end
