require "jekyll"
require "json"
require "open-uri"

module JekyllHNComments
  class CommentLinkGenerator < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)
      site.posts.docs.each do |p|
        if not p.data['hn-id']
          next
        end
        target = "https://hacker-news.firebaseio.com/v0/item/#{p.data['hn-id']}.json"
        res = JSON.load(URI.open(target))

        p.data['link'] = "https://news.ycombinator.com/item?id=#{p.data['hn-id']}"
        p.data['num_comments'] = res['descendants'] 
      end
    end
  end
end
