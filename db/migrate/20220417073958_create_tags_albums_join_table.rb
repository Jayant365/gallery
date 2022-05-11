class CreateTagsAlbumsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :tags, :albums
  end
end
