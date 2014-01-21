class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :username
      t.text :status

      t.timestamps
    end

    add_index :tweets, :username, :unique => true
  end
end
