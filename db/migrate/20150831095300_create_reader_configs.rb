class CreateReaderConfigs < ActiveRecord::Migration
  def change
    create_table :reader_configs do |t|
      t.string :name
      t.string :index_url
      t.integer :index_pages
      t.string :index_artical_link_selector
      t.string :index_artical_link_content
      t.string :index_next_page_selector
      t.string :index_next_page_content
      t.string :artical_content_selectors
      t.string :artical_img_selectors
      t.string :artical_next_page_selector
      t.string :artical_next_page_content
      t.integer :artical_pages

      t.timestamps null: false
    end
  end
end
