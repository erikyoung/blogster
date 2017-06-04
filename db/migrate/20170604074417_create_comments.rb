class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
    	t.text :message
    	t.integer :user_id
    	t.integer :article_id

      t.timestamps
    end
    add_index :comments, [:user_id, :article_id]
    add_index :comments, :article_id
  end
end
