class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
	add_index :microposts, [:user_id, :created_at] #this adds an index to both user id and created at columns...makes it way easier to search through thousands of posts to find what we are looking for. 
  end
end
