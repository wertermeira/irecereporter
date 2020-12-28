class OldPosts
  class << self
    def posts(limit: 10)
      client.query("SELECT * FROM posts ORDER BY id desc LIMIT #{limit}")
    end
  
    def categories_by_post(id:)
      sql_query = "SELECT * FROM post_category_assn INNER JOIN categories ON categories.id = post_category_assn.category_id WHERE post_category_assn.post_id = #{id}"
      client.query(sql_query)
    end
  
    private
  
    def client
      Mysql2::Client.new(:host => "127.0.0.1", :username => "root", port: 3320, password: 'password', database: 'irecereporter_dev')
    end
  end
end