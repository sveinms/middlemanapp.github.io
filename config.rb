###
# Compass
###
 
# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end
 
###
# Page options, layouts, aliases and proxies
###
 
# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end
 
# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }
 
###
# Helpers
###
 
# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes
 
# Reload the browser automatically whenever files change
 configure :development do
   #activate :livereload
   #set :debug_assets, true
 end

# before build hooks
before_build do |builder|
  print "Before build we look for changes in Contentful"
  system("middleman contentful  --rebuild")
  puts "done."
end
 
# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end
 
set :css_dir, 'stylesheets'
 
set :js_dir, 'javascripts'
 
set :images_dir, 'images'

set :build_dir, 'build'
 

 
# Contentful plugin 
activate :contentful do |f|
  f.space         = {playground: '12yz202mwxwc'}
  f.access_token  = '73d810b86f8ca023c3012098c76fe0bb9cc195b24b97fa3ebdc2026ff5bc8167'
  f.cda_query     = { content_type: '5L6cg0jdReS4KM0eO8QcGY', include: 1 }
  f.content_types = { position: '5L6cg0jdReS4KM0eO8QcGY'}
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css
 
  # Minify Javascript on build
  # activate :minify_javascript
 
  # Enable cache buster
  # activate :asset_hash
 
  # Use relative URLs
  # activate :relative_assets
 
  # Or use a different image path
  # set :http_prefix, "/Content/images/"
 
  # Assumes the file source/about/template.html.erb exists
data.playground.position.each do |id , position|
  proxy "/positions/#{position.jobTitle.parameterize}.html", "/positions/template.html", :locals => { :position => position }, :ignore => true
end
 
end