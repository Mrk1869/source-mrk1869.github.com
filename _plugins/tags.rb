module Jekyll

  class TagPage < Page
    def initialize(site, base, dir, tag)
      @site, @base, @dir = site, base, dir
      @name = 'index.html'

      self.process(@name)
      raise 'name is null' unless @name
      self.read_yaml(File.join(base, '_layouts'), 'entries.html')
      self.data['posts'] = site.tags[tag]
      self.data['tag'] = tag
      self.data['page_name'] = "tag:"+tag
    end
  end

  class TagPageGenerator < Generator
    safe true

    def generate(site)
      site.tags.keys.each do |tag|
        site.pages << TagPage.new(site, site.source, File.join('tag', tag), tag)
      end
    end
  end
end
