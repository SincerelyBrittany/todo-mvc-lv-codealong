class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :description
      t.integer :list_id
      #wiring the schema, the database (foreign key)
      #wire the model with the association
      t.timestamps
    end
  end
end
