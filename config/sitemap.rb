# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://evercard.herokuapp.com"

SitemapGenerator::Sitemap.public_path = 'tmp/sitemaps/'

SitemapGenerator::Sitemap.create do
  add login_path, priority: 0.0
  Card.find_each do |card|
    add card_path(card), lastmod: card.updated_at
  end
end

SitemapGenerator::Sitemap.ping_search_engines