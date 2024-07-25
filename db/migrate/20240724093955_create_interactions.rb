class CreateInteractions < ActiveRecord::Migration[7.1]
  def change
    create_table :interactions do |t|
      t.references :person, null: false, foreign_key: true
      t.datetime :date
      t.string :method
      t.string :initiated_by
      t.string :context

      t.timestamps
    end
  end
end
