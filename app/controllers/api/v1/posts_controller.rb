class Api::V1::PostsController < ApplicationController
  # Get Posts
  def index
    url = createURL(params['limit'], params['count'], params['after'], params['before'])
    result = getRequest(url)
    response = parseResponse(result)
    render json: response
  end

  private

  def getRequest(url)
    require "net/http"
    uri = URI.parse(url)
    request = Net::HTTP::Get.new(uri)
    request.content_type = 'application/json'
    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') {|http| http.request request}
  end

  def createURL(limit, count, after = nil, before = nil)
    url = "https://www.reddit.com/top.json?limit=#{limit}&count=#{count}"

    if after != nil
      url = "#{url}&after=#{after}"
    end

    if before != nil
      url = "#{url}&before=#{before}"
    end

    url
  end

  def parseResponse(result)
    require 'json'
    posts = []
    response = {}
    parsedResult = JSON.parse(result.body)
    children = parsedResult['data']['children']

    for value in children do
      posts.push(value['data'])
    end

    response['after'] = parsedResult['data']['after']
    response['before'] = parsedResult['data']['before']
    response['posts'] = posts

    response
  end
end
