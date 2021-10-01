# frozen_string_literal: true

json.array! @posts do |post|
  json.extract! post, :id, :body
end
