class CreateArticals < ActiveRecord::Migration
  def change
    create_table :articals do |t|
      t.string :title
      t.string :url
      t.string :content
      t.references :reader_config, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
