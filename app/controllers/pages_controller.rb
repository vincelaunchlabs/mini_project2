class PagesController < ApplicationController

	def index
    @blogs = Blog.all.paginate(page: params[:page], per_page: 1)
	end
end
