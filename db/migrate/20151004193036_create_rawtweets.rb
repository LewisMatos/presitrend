class CreateRawtweets < ActiveRecord::Migration
  def change
    create_table :rawtweets do |t|
      t.text :tweet
      t.timestamps null: false
    end
  end
end
