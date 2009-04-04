require "rubygems"
require "sinatra"
require 'sass'
require 'haml'

# require 'linguistics'
# Linguistics::use( :en )

def require_or_load(file)
  if Sinatra::Application.environment == :development
    load File.join(File.dirname(__FILE__), "#{file}.rb")
  else
    require file
  end
end

require_or_load "lib/cache"
require_or_load "lib/configuration"
require_or_load "lib/models"

set :cache_dir, "cache"
set :cache_enabled, Nesta::Configuration.cache

helpers do
  def set_common_variables
    @categories = Category.find_all
    @site_title = Nesta::Configuration.title
    @google_analytics_code = "UA-360581-1" #Nesta::Configuration.google_analytics_code
  end

  def article_path(article)
    Nesta::Configuration.articles_matcher.gsub(/\:permalink/, article.permalink)
    # "/articles/#{article.permalink}"
  end

  def articles_path
    Nesta::Configuration.articles_matcher.gsub(/\/\:permalink/, "")
  end

  def category_path(category)
    Nesta::Configuration.categories_matcher.gsub(/\:permalink/, category.permalink)
    # "/#{category.permalink}"
  end
  
  def feed_url
    # "#{base_url}#{Nesta::Configuration.site_matcher}.xml"
    "http://feeds2.feedburner.com/donotremove"
  end
  
  def url_for(page)
    if page.is_a?(Article)
      base_url + article_path(page)
    elsif page.is_a?(Category)
      base_url + category_path(page)
    elsif page.is_a?(String)
      [base_url, page].join("/")
    else
      [base_url, page.permalink].join("/")
    end
  end
  
  def base_url
    url = "http://#{request.host}"
    request.port == 80 ? url : url + ":#{request.port}"
  end  
  
  def nesta_atom_id_for_article(article)
    published = article.date.strftime('%Y-%m-%d')
    # "tag:#{request.host},#{published}:/articles/#{article.permalink}"
    "tag:#{request.host},#{published}:#{article_path(article)}"
  end
  
  def atom_id(article = nil)
    if article
      article.atom_id || nesta_atom_id_for_article(article)
    else
      "tag:#{request.host},2009:#{articles_path}"
    end
  end
  
  def format_date(date)
    date.strftime("%d %B %Y")
  end
  
  def pagination
    out = []
    out << "<a href='?page=#{Article.page - 1}'>Previous</a>" if Article.previous?
    out << "Page #{Article.page} of #{Article.pages}"
    out << "<a href='?page=#{Article.page + 1}'>Next</a>" if Article.next?
    out.join(" | ")
  end
  
  def internet_explorer_class
    request.user_agent =~ /MSIE\s(\d)/
    unless Regexp.last_match(1).nil?
      # ie_version = Regexp.last_match(1).to_i
      return "ie"
    end
  end
end

not_found do
  set_common_variables
  cache haml(:not_found)
end

error do
  set_common_variables
  cache haml(:error)
end unless Sinatra::Application.environment == :development

load 'dnr.rb'

get "/css/master.css" do
  content_type "text/css", :charset => "utf-8"
  if FileTest.exist?(Nesta::Configuration.stylesheet)
    template = File.open(Nesta::Configuration.stylesheet).read
    sass_engine = Sass::Engine.new(template)
    cache sass_engine.render
  else
    cache sass(:master)
  end
end

get Nesta::Configuration.site_matcher do
  set_common_variables
  @body_class = "home"
  @heading = Nesta::Configuration.title
  @subtitle = Nesta::Configuration.subtitle
  @description = Nesta::Configuration.description
  @keywords = Nesta::Configuration.keywords
  @title = "#{@heading} | #{@subtitle}"
  # @articles = Article.find_all[0..7]
  @articles = Article.paginate(params[:page])
  @nav = :weblog
  cache haml(:index)
end

get Nesta::Configuration.articles_matcher do
  set_common_variables
  @article = Article.find_by_permalink(params[:permalink])
  raise Sinatra::NotFound if @article.nil?
  @title = if @article.parent
    "#{@article.heading} | #{@article.parent.heading}"
  else
    "#{@article.heading} | #{Nesta::Configuration.title}"
  end
  @description = @article.description
  @keywords = @article.keywords
  @comments = @article.comments
  @nav = :weblog
  cache haml(:article)
end

get "/attachments/:filename.:ext" do
  file = File.join(
      Nesta::Configuration.attachment_path, "#{params[:filename]}.#{params[:ext]}")
  send_file(file, :disposition => nil)
end

get "#{Nesta::Configuration.site_matcher}.xml" do
  content_type :xml, :charset => "utf-8"
  @title = Nesta::Configuration.title
  @subtitle = Nesta::Configuration.subtitle
  @author = Nesta::Configuration.author
  @articles = Article.find_all.select { |a| a.date }[0..9]
  builder :atom
end

get "/sitemap.xml" do
  content_type :xml, :charset => "utf-8"
  @pages = Category.find_all + Article.find_all
  @last = @pages.map { |page| page.last_modified }.inject do |latest, this|
    this > latest ? this : latest
  end
  builder :sitemap
end

get Nesta::Configuration.categories_matcher do
  set_common_variables
  @category = Category.find_by_permalink(params[:permalink])
  raise Sinatra::NotFound if @category.nil?
  @title = "#{@category.heading} - #{Nesta::Configuration.title}"
  @description = @category.description
  @keywords = @category.keywords
  @nav = :weblog
  cache haml(:category)
end
