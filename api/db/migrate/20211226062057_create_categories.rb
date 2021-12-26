class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, default: '', null: false
      t.string :slug, null: false, unique: true
      t.text :description, default: ''
      t.integer :parent_category_id
      t.timestamps
    end
  end
end
