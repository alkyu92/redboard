class CreateCertificates < ActiveRecord::Migration[5.0]
    def change
        create_table :certificates do |t|
            t.string  :name
            t.text    :description
            t.string  :department
            t.date    :graduation
            t.integer :integer
            t.integer :copies
            t.string  :phone
            t.string  :language
            t.date    :birthdate
            t.references :user, foreign_key: true

            t.timestamps
        end
    end
end
