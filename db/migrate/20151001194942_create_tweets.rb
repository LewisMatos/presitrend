class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :username
      t.text :tweet
      t.string :location
      t.string :candidate
			t.integer :candidate_id

      t.timestamps null: false
    end
  end
end
