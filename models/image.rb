class Image < ActiveRecord::Base
  class << self
    def all_search(keyword)
      where(<<~"QUERY"
        (id LIKE "%#{keyword}%")
        OR (title LIKE "%#{keyword}%")
        OR (author LIKE "%#{keyword}%")
        OR (url LIKE "%#{keyword}%")
      QUERY
           )
    end

    def partial_search(id:, title:, author:, url:, mode:)
      query = []
      query << "(id LIKE \"%#{id}%\")" if id.present?
      query << "(title LIKE \"%#{title}%\")" if title.present?
      query << "(author LIKE \"%#{author}%\")" if author.present?
      query << "(url LIKE \"%#{url}%\")" if url.present?

      query_str = case mode
                  when "or"
                    query.join(" OR ")
                  when "and"
                    query.join(" AND ")
                  else
                    raise("modeが正しくありません")
                  end

      where(query_str)
    end

    def sort_by_similar_rgb(id)
      image = self.select('red, green, blue').find(id)

      sql = ActiveRecord::Base.send(
              :sanitize_sql_array,
              [
                'SELECT * FROM images WHERE id != :id ORDER BY (red * :red + blue * :blue + green * :green) DESC',
                id: id,
                red: image.red, 
                blue: image.blue, 
                green: image.green 
              ]
            )

      con = ActiveRecord::Base.connection
      result = con.select_all(sql).to_hash

      result.map { |r| self.new(r) }
    end

    def search_label(keyword)
      where("labels like ?", "%#{keyword}%")
    end
  end
end
