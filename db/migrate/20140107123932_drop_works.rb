class DropWorks < ActiveRecord::Migration
  def change
    drop_table :works
  end
end
