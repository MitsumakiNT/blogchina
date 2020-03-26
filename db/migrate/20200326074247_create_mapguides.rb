class CreateMapguides < ActiveRecord::Migration[6.0]
  def change
    create_table :mapguides do |t|
      t.integer :article_id
      t.integer :map_id

      t.timestamps
    end
  end
end
