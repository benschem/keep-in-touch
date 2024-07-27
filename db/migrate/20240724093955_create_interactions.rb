class CreateInteractions < ActiveRecord::Migration[7.1]
  def change
    create_table :interactions do |t|
      t.references :person, null: false, foreign_key: true
      t.datetime :date
      t.integer :method
      t.integer :initiated_by
      t.integer :context

      t.timestamps
    end
  end
end
