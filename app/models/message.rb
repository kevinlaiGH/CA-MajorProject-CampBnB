class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates_presence_of :content, :converstaion_id, :user_id

  def message_time
    self.create_at.strftime("%v")
  end
end
