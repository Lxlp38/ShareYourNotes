class AddPdfToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :pdf, :string
  end
end
