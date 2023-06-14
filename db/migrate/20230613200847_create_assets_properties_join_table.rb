class CreateAssetsPropertiesJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :assets, :properties do |t|
      t.index :asset_id
      t.index :property_id
    end
  end
end
