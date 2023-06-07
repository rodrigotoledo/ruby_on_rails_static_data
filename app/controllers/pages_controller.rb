class PagesController < ApplicationController
  def home; end

  def about; end

  def videos
    @videos = if params[:query].empty?
              Video.all
            else
              Video.where('title like ?', "%#{params[:query]}%")
            end
  end
end
