class CreateJoinTableConversationUser < ActiveRecord::Migration
  def change
    create_join_table :conversations, :users do |t|
      # t.index [:conversation_id, :user_id]
      # t.index [:user_id, :conversation_id]
    end
  end
end
