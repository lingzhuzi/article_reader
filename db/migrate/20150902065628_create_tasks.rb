class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :job_id
      t.references :reader_config, index: true, foreign_key: true
      t.integer :status
      t.text :error

      t.timestamps null: false
    end
  end
end
