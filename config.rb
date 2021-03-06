require 'lib/custom_helpers'
require 'lib/add_links_to_navigation.rb'
require 'lib/modify_widths.rb'
require 'lib/embed.rb'
require 'ansi/code'
require 'slim'

###
# Blog settings
###

set :markdown_engine, :redcarpet
set :markdown, fenced_code_blocks: true, disable_indented_code_blocks: true, strikethrough: true, smartypants: true, with_toc_data: true
set :relative_links, true
set :slim, :layout_engine => :slim

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  blog.prefix = "blog"
  blog.permalink = "{title}.html"

  blog.summary_separator = /\(READMORE\)/
  blog.new_article_template = File.expand_path('new_article.markdown.erb', File.dirname(__FILE__))
  blog.layout = "partials/_blog_post"
end

# Activate the middleman-search extension and customize it.
activate :search do |search|
  # I only want to search blog articles, not about/ or books/ or anything.
  search.resources = ['blog/']

  # Search fields are indexed by default, but not stored. Storing takes up 
  # space, so we should only store what is needed to render search results: the
  # title, the date, and the URL. We'll index the content but no store it.
  # Additionally, we apply a "boost" to the title and content fields. 
  search.fields = {
    title:   {boost: 100, store: true, required: true},
    date:    {index: false, store: true},
    content: {boost: 50},
    url:     {index: false, store: true}
  }
end

###
# Other settings
###

helpers CustomHelpers

activate :syntax
activate :directory_indexes
activate :sprockets
activate :inliner
activate :add_links_to_navigation
activate :modify_widths
activate :embed

page "/*.xml", layout: false

set :css_dir, 'css'
set :js_dir, 'javascripts'
set :images_dir, 'img'
