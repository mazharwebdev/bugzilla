class CreateBugs < ActiveRecord::Migration[5.1]
  def change
    create_table :bugs do |t|
      t.string :title
      t.text :description
      t.date :deadline
      t.string :screenshot
      t.string :bug_type
      t.string :status

      t.references :project, foreign_key: true

      t.integer :created_id , foreign_key: true #belongs_to :account
      t.integer :developed_id , foreign_key: true #belongs_to :account

      t.timestamps
    end
  end
end
