# == Schema Information
#
# Table name: microposts
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  picture    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_microposts_on_user_id                 (user_id)
#  index_microposts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :check_picture_size

  private

  def check_picture_size
    return unless picture.size > 5.megabytes

    errors.add(:picture, 'should be less than 5MB')
  end
end
