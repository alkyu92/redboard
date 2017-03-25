class CreateAds < ActiveRecord::Migration[5.0]
  def change
    create_table :ads do |t|
      t.string    :ad_title
      t.date      :ad_date
      t.time      :ad_time
      t.text      :ad_description
      t.string    :ad_venue
      t.references   :user, foreign_key: true

      t.timestamps
    end
    add_index :ads, [:user_id, :created_at]
  end
end
