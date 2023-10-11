class CreateFootStanps < ActiveRecord::Migration[6.1]
  def change
    create_table :foot_stanps do |t|
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
