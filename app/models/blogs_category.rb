class BlogsCategory < ActiveRecord::Base

  belongs_to :blog, :category

end
