class PagesController < ApplicationController

	def home
    @blogs = Blog.where(is_draft: false).paginate(page: params[:page], per_page: 5)
	end
end
