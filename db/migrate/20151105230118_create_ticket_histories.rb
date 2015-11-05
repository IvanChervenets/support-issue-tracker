class CreateTicketHistories < ActiveRecord::Migration
  def change
    create_table :ticket_histories do |t|
      t.text :description
      t.references :ticket, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
