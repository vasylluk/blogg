class PhotosController < ApplicationController
before_action :authenticate_user!

def index
  @photos = Photo.all
  @like = {}
  @photos.each do |photo|
    @votes = Vote.where(photo_id: photo.id).sum(:like)
    @like[photo.id] = @votes
end

end

def new
  @photo = Photo.new
end

def create
  params[:photo][:category_id] = params[:category_id]
  params[:photo][:user_id] = current_user.id
  @photo = Photo.create(photo_params)
  redirect_to photos_path
end

def edit
end

def update
end

def destroy
  @photo.destroy
  redirect_to photos_path
end

def vote
  @photo = Photo.find(params[:id])
  @vote = Vote.where(user_id: current_user.id, photo_id: @photo.id).first
  if @vote == nil or @vote.like == 0
    @like = 1
    Vote.create(user_id: current_user.id, photo_id: @photo.id, like: @like)
  else
    @vote.update(like: @vote.like-1)
  end
  redirect_to photos_path
end

private

def photo_params
  params.require(:photo).permit(:user_id, :category_id, :name, :photo)
end

end