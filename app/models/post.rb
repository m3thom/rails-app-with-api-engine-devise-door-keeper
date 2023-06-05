class Post < ApplicationRecord
  belongs_to :user, optional: true

  validates :content,
            :title,
            :user_id,
            presence: true

  # Realtime-data happens here
  broadcasts
end
