class OldPosts
  class << self
    def posts(limit: 10)
      client.query("SELECT * FROM posts ORDER BY id asc LIMIT #{limit}")
    end

    def categories_by_post(id)
      sql_query = 'SELECT * FROM post_category_assn INNER JOIN '\
                  'categories ON categories.id = post_category_assn.category_id '\
                  "WHERE post_category_assn.post_id = #{id}"
      client.query(sql_query)
    end

    private

    def client
      Mysql2::Client.new(credentials)
    end

    def credentials
      {
        host: ENV['OLD_DB_HOST'], username: ENV['OLD_DB_USER'],
        port: ENV['OLD_DB_PORT'], password: ENV['OLD_DB_PASSWORD'],
        database: ENV['OLD_DB_DATABASE']
      }
    end
  end
end
