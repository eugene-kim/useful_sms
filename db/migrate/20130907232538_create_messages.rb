class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :keyword
      t.string :body
      t.string :description

      t.timestamps
    end
  end
end
