class ChangeSavesToKeeps < ActiveRecord::Migration[5.2]
  def change
    rename_table :saves, :keeps
  end
end
