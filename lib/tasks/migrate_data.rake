require 'old_posts'
namespace :migrate_data do

  desc 'Populete posts'
  task posts: :environment do
    old_post = OldPosts
    results = old_post.posts
    results.each do |row|
      data = {
        name: row['title'], subname: row['title_large'],
        headline: row['smalltitle'], body: row['body'],
        summary: row['summary'],
        url_video: row['video'],
        created_at: row['date_post'],
        active: row['active'],
        feature_post: row['featured']
      }
      Post.create(data)
    end
    p Post.count
  end
end
