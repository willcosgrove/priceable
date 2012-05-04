class CreateLlamas < ActiveRecord::Migration
  def change
    create_table :llamas do |t|
      t.string :name
      t.integer :price_in_cents

      t.timestamps
    end
  end
end
