class CreateDocusigns < ActiveRecord::Migration[5.1]
  def change
    create_table :docusigns do |t|
      t.string :envelopeId
      t.string :uri
      t.datetime :statusDateTime
      t.string :status

      t.timestamps
    end
  end
end
