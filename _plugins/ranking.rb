require 'net/http'
require 'json'

WEIGHT_OF_HATENA = 2
WEIGHT_OF_FACEBOOK = 1
WEIGHT_OF_TWITTER = 1

module Jekyll

  class RankingPage < Page
    def initialize(site, base, dir)
      @site, @base, @dir = site, base, dir
      @name = 'index.html'
      @posts_with_score = []

      self.process(@name)
      raise 'name is null' unless @name
      self.read_yaml(File.join(base, '_layouts'), 'ranking.html')

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

          ## hatena
          uri = "http://api.b.st-hatena.com/entry.count?url=#{url}"
          body = Net::HTTP.get_response(URI.parse(uri)).body
          # scoreは文字列で返ってくる. 0は"".
          if body != ""
            score = score + WEIGHT_OF_HATENA * body.to_i
          end

          ## facebook
          uri = "http://graph.facebook.com/#{url}"
          body = Net::HTTP.get_response(URI.parse(uri)).body
          # scoreはjsonで返ってくる. 0は0.
          json = JSON.parse(body)
          if json['shares']
            score = score + WEIGHT_OF_FACEBOOK * json['shares']
          end

          ## tweet
          uri = "http://urls.api.twitter.com/1/urls/count.json?url=#{url}"
          body = Net::HTTP.get_response(URI.parse(uri)).body
          # scoreはjsonで返ってくる. 0は0.
          json = JSON.parse(body)
          if json['count']
            score = score + WEIGHT_OF_TWITTER * json['count']
          end

          @posts_with_score << {"post" => post, "score" => score}
          puts "finished loading #{post.title}..#{score}"
        end

        ## sort
        @posts = []
        @posts_with_score.sort_by{|val| val['score']}.reverse.each do |entry|
          @posts << entry['post']
        end

      rescue
        # status is offline
        @posts = site.posts.reverse
      end

      self.data['posts'] = @posts

    end

  end

  class RankingPageGenerator < Generator
    safe true

    def generate(site)
      site.pages << RankingPage.new(site, site.source, 'ranking')
    end
  end
end
