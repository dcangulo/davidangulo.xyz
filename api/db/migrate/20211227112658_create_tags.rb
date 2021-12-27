class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name, default: '', null: false
      t.string :slug, null: false, unique: true
      t.text :description, default: ''
      t.timestamps
    end
  end
end
