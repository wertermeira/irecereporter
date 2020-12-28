require 'old_posts'
namespace :migrate_data do

  desc 'Populete posts'
  task posts: :environment do
    p "start #{Time.current.to_s(:time)}"
    old_post = OldPosts
    results = old_post.posts(limit: 500)
    results.each do |row|
      data = {
        name: row['title'], subname: row['smalltitle'],
        headline: row['title_large'], body: row['body'],
        summary: row['summary'],
        url_video: row['video'],
        created_at: row['date_post'],
        active: row['active'],
        feature_post: row['featured']
      }
      Post.create(data).tap do |post|
        UploadImagePostJob.perform_later(post.id, 'cover', "#{path_img}/#{row['id']}/#{row['image']}")
        categories = []
        old_post.categories_by_post(row['id']).each do |cat|
          categories.push(Category.find_or_create_by(name: cat['name']).id)
        end
        post.category_ids = categories
        post.save
      end
    end
    p "finish #{Time.current.to_s(:time)}"
  end

  def path_img
    "http://irecereporter.com.br/uploads/posts"
  end
end
