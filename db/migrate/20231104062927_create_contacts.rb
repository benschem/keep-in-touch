class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.datetime :date
      t.string :type
      t.string :initiated_by
      t.string :context
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
