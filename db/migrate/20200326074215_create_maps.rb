class CreateMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :maps do |t|
      t.string :tag_name

      t.timestamps
    end
    add_index :maps, :tag_name, unique: true
  end
end
