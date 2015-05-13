class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps null: false
    end

    Category.create({ :name => "Art & Paper Goods" })
    Category.create({ :name => "Jewelry" })
    Category.create({ :name => "Food Market" })
    Category.create({ :name => "Beauty Care" })
    Category.create({ :name => "Women's Apparel" })
    Category.create({ :name => "Men's Apparel" })
    Category.create({ :name => "Kids Stuff" })
    Category.create({ :name => "Pets" })
    Category.create({ :name => "Toys" })
    Category.create({ :name => "Accessories" })
    Category.create({ :name => "Sample Category" })

  end
end
