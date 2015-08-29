class CreateCompanyData < ActiveRecord::Migration
  def change
    create_table :company_data do |t|

      t.timestamps null: false
    end
  end
end
