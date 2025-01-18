class CreateDiaries < ActiveRecord::Migration[7.2]
  def change
    create_table :diaries do |t|
      t.integer :user_id
      t.string :text
      t.integer :tension

      t.timestamps
    end
  end
end
