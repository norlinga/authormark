class CreateSiteImages < ActiveRecord::Migration[8.0]
  def change
    create_table :site_images do |t|
      t.timestamps
    end
  end
end
