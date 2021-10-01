# frozen_string_literal: true

json.array! @posts.sort_by(&:created_at).reverse, partial: 'api/posts/post', as: :post
