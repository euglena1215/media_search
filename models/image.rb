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
  end
end
