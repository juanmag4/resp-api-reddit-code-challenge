class Api::V1::ImagesController < ApplicationController
  require 'set'
  $images = []
  def index
    render json: $images
  end

  def create
    response = {}
    if $images.include?(params['url'])
      response['code'] = 400
      response['message'] = 'Image already saved'
    else
      $images.push(params['url'])
      response['code'] = 200
      response['message'] = 'Image saved'
    end

    render json: response
  end
end
