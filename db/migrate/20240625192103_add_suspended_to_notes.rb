class AddSuspendedToNotes < ActiveRecord::Migration[6.1]
  def change
    add_column :notes, :suspended, :boolean, :default => false
  end
end
