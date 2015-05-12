module Ajax
  class BlogsController < ApplicationController
    before_filter :authenticate_user!

    def go_live
      
    end
    

    def archived
      @blog = Blog.find_by_id(params[:blog_id].to_i)

      if @blog.present?
        if @blog.is_archived?
          @blog.is_archived = false
        else
          @blog.is_archived = true
        end
        if @blog.save
          render :json => {success: "Successfully Archived!", is_archived: @blog.is_archived}, :status => 200
        else
          render :json => {error: "Update failed!"}, status: 300
        end
      else
        render :json => {error: "Blog not found!"}, status: 300
      end
    end
  end
end