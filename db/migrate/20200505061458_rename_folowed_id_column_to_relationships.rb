class RenameFolowedIdColumnToRelationships < ActiveRecord::Migration[5.2]
  def change
    rename_column :relationships, :folowed_id, :followed_id
  end
end
