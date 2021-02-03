class UploadImagePostJob < ApplicationJob
  queue_as :default
  discard_on OpenURI::HTTPError

  def perform(id, kind, url_image)
    post = Post.find_by(id: id)
    return if post.blank?

    case kind
    when 'cover'
      post.cover.attach(io: URI.parse(url_image).open, filename: post.slug)
    when 'image'
      post.image.attach(io: URI.parse(url_image).open, filename: post.slug)
    end
  end
end
