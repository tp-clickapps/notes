# == Schema Information
#
# Table name: conversations
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Conversation < ActiveRecord::Base

  # Associations
  has_many :messages, dependent: :destroy
  has_and_belongs_to_many :users

  # Validations
  

end
