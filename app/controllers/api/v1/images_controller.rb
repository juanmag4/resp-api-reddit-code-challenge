class Api::V1::ImagesController < ApplicationController
  $images = []
  def index
    render json: $images
  end

  def create
    puts $images
    $images.push(params['url'])
    render json: 'Success'
  end
end
