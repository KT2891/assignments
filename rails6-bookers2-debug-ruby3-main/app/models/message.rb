class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :conetnt, presence: true,
                      length: { maximum: 140 }
end
