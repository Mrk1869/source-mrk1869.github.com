require 'net/http'
require 'json'

WEIGHT_OF_HATENA = 2
WEIGHT_OF_FACEBOOK = 1
WEIGHT_OF_TWITTER = 1

module Jekyll
  class RankingGenerator < Generator

    safe true
    priority :high

    def generate(site)
      @posts, @posts_with_score = [], []

      # 強引だけどここでオフライン検知
      begin
        #status is online

        # --draftsオプションを含めてビルドした場合も取得しない
        if site.config['show_drafts']
          raise
        end

        site.posts.each do |post|
          score = 0
          url = site.config['url'] + post.url

          # hatena 文字列で返ってくる. 0は""
          uri = "http://api.b.st-hatena.com/entry.count?url=#{url}"
          body = Net::HTTP.get_response(URI.parse(uri)).body
          score = body != "" ? score + WEIGHT_OF_HATENA * body.to_i : score

          # facebook jsonで返ってくる. 0は0.
          uri = "http://graph.facebook.com/#{url}"
          body = Net::HTTP.get_response(URI.parse(uri)).body
          json = JSON.parse(body)
          score = json['shares'] ? score + WEIGHT_OF_FACEBOOK * json['shares'] : score

          # tweet jsonで返ってくる. 0は0.
          uri = "http://urls.api.twitter.com/1/urls/count.json?url=#{url}"
          body = Net::HTTP.get_response(URI.parse(uri)).body
          json = JSON.parse(body)
          score = json['count'] ? score + WEIGHT_OF_TWITTER * json['count'] : score

          @posts_with_score << {"post" => post, "score" => score}
          puts "finished loading #{post.title}..#{score}"
        end

        ## sort
        @posts_with_score.sort_by{|val| val['score']}.reverse.each do |entry|
          @posts << entry['post']
        end

      rescue
        # status is offline
        @posts = site.posts.reverse
      end

      site.data['popular_posts'] = @posts
    end

  end
end
