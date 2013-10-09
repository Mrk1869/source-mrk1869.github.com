module Jekyll

  class EntriesPage < Page
    def initialize(site, base, dir)
      @site, @base, @dir = site, base, dir
      @name = 'index.html'

      self.process(@name)
      raise 'name is null' unless @name
      self.read_yaml(File.join(base, '_layouts'), 'entries.html')
      self.data['title'] = "entries"
      self.data['name'] = "全記事一覧 | Markovnikov Laboratory"
      self.data['posts'] = site.posts.reverse
    end
  end

  class EntriesPageGenerator < Generator
    safe true

    def generate(site)
        site.pages << EntriesPage.new(site, site.source, 'entries')
    end
  end
end
