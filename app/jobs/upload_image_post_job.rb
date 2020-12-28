class UploadImagePostJob < ApplicationJob
  queue_as :default

  def perform(id, kind, url_image)
    post = Post.find_by(id: id)
    return if post.blank?
    if kind == 'cover'
      post.cover.attach(io: URI.parse(url_image).open, filename: post.slug)
    elsif kind == 'image'
      post.cover.attach(io: URI.parse(url_image).open, filename: post.slug)
    end
  end
end