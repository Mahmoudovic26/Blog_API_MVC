json.extract! article, :id, :title, :body, :created_at, :updated_at
json.url article_url(article, format: :json)
json.comments article.comments do |comment|
  json.partial! 'comments/comment', comment: comment
end