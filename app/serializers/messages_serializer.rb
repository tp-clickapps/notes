class MessagesSerializer < ActiveModel::Serializer
  attributes :id, :user, :body, :time

  def user
    object.user.name
  end

  def time
    object.created_at.strftime("%H:%M %p")
  end
end
