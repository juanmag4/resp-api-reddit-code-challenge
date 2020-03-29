class Api::V1::PostsController < ApplicationController
  # Get Posts
  def index
    require 'json'
    posts = []
    response = {}
    result = api_request(:get, 'https://www.reddit.com/top.json?limit=50&count=0')
    parsedResult = JSON.parse(result.body)
    children = parsedResult['data']['children']
    for value in children do
      posts.push(value['data'])
    end
    response['after'] = parsedResult['data']['after']
    response['before'] = parsedResult['data']['before']
    response['posts'] = posts
    render json: response
  end

  def api_request(type , url, body=nil, header =nil )
    require "net/http"
    uri = URI.parse(url)
    case type
    when :post
      request = Net::HTTP::Post.new(uri)
      request.body = body
    when :get
      request = Net::HTTP::Get.new(uri)
    when :put
      request = Net::HTTP::Put.new(uri)
      request.body = body
    when :delete
      request = Net::HTTP::Delete.new(uri)
    end
    request.initialize_http_header(header)
    request.content_type = 'application/json'
    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') {|http| http.request request}
  end
end
