class AddUserRefToBlogs < ActiveRecord::Migration[6.0]
  def change
    add_reference :blogs, :user, null: true, foreign_key: true
  end
end
