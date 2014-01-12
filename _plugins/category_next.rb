module Jekyll
  class CategoryAwareNextGenerator < Generator

    safe true
    priority :high

    def generate(site)
      site.categories.each_pair do |category_name, posts|
        posts.sort! { |a, b| b <=> a }

        posts.each do |post|
          position = posts.index post

          if position && position < posts.length - 1
            category_previous = posts[position + 1]
          else
            category_previous = nil
          end

          if position && position > 1
            category_next = posts[position - 1]
          else
            category_next = nil
          end

          post.data["#{category_name}_previous"] = category_previous unless category_previous.nil?
          post.data["#{category_name}_next"] = category_next unless category_next.nil?
        end
      end
    end
  end
end
