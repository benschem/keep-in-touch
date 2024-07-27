class CreatePeople < ActiveRecord::Migration[7.1]
  def change
    create_table :people do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :relationship

      t.timestamps
    end
  end
end
