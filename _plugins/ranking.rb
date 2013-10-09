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
      self.read_yaml(File.join(base, '_layouts'), 'entries.html')
      self.data['title'] = "ranking"
      self.data['name'] = "人気の記事 | Markovnikov Laboratory"

      # 強引だけどここでオフライン検知
      begin
        #status is online

        site.posts.each do |post|
          score = 0
          url = site.config['url'] + post.url

          # hatena
          uri = "http://api.b.st-hatena.com/entry.count?url=#{url}"
          body = Net::HTTP.get_response(URI.parse(uri)).body
          if body != ""
            score = score + WEIGHT_OF_HATENA * body.to_i
          end

          # facebook
          uri = "http://graph.facebook.com/#{url}"
          body = Net::HTTP.get_response(URI.parse(uri)).body
          json = JSON.parse(body)
          if json['shares']
            score = score + WEIGHT_OF_FACEBOOK * json['shares']
          end

          # tweet
          uri = "http://urls.api.twitter.com/1/urls/count.json?url=#{url}"
          body = Net::HTTP.get_response(URI.parse(uri)).body
          json = JSON.parse(body)
          score = score + WEIGHT_OF_TWITTER * json['count']

          @posts_with_score << {"post" => post, "score" => score}
          puts "finished loading #{post.title}..#{score}"
        end

        # sort
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
