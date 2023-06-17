class Video < ApplicationRecord
  after_create :broadcasting_to_latest_video
  after_update :broadcasting_to_latest_video
  after_destroy :broadcasting_to_latest_video
  protected
  def broadcasting_to_latest_video
    broadcast_update_to 'latest_video', target: 'latest_video', partial: 'videos/latest_video'
  end
end
