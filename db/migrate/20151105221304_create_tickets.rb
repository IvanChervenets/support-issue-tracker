class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :reference_key
      t.string :customer_name
      t.string :customer_email
      t.text :description
      t.references :department, index: true, foreign_key: true
      t.references :subject, index: true, foreign_key: true
      t.references :status, index: true, foreign_key: true
      t.references :owner, references: :users

      t.timestamps null: false
    end
  end
end
