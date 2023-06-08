# frozen_string_literal: true

class VideoReflex < ApplicationReflex
  def search
    videos = Video.where('title like ?', "%#{element.value}%") unless element.value.blank?
    videos ||= []
    morph '#results', render(partial: 'pages/videos', locals: {videos: videos, query: element.value})
  end
end
