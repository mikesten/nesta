require "rubygems"
require "sinatra"
require 'sass'
require 'haml'

def require_or_load(file)
  if Sinatra::Application.environment == :development
    load File.join(File.dirname(__FILE__), "#{file}.rb")
  else
    require file
  end
end

require_or_load "lib/configuration"
require_or_load "lib/models"

helpers do
  def set_common_variables
    @categories = Category.find_all
    @site_title = Nesta::Configuration.title
    @google_analytics_code = Nesta::Configuration.google_analytics_code
  end

  def article_path(article)
    Nesta::Configuration.articles_matcher.gsub(/\:permalink/, article.permalink)
    # "/articles/#{article.permalink}"
  end

  def category_path(category)
    Nesta::Configuration.categories_matcher.gsub(/\:permalink/, category.permalink)
    # "/#{category.permalink}"
  end
  
  def url_for(page)
    base = page.is_a?(Article) ? base_url + "/articles" : base_url
    [base, page.permalink].join("/")
  end
  
  def base_url
    url = "http://#{request.host}"
    request.port == 80 ? url : url + ":#{request.port}"
  end  
  
  def nesta_atom_id_for_article(article)
    published = article.date.strftime('%Y-%m-%d')
    "tag:#{request.host},#{published}:/articles/#{article.permalink}"
  end
  
  def atom_id(article = nil)
    if article
      article.atom_id || nesta_atom_id_for_article(article)
    else
      "tag:#{request.host},2009:/articles"
    end
  end
  
  def format_date(date)
    date.strftime("%d %B %Y")
  end
end

not_found do
  set_common_variables
  haml :not_found
end

error do
  set_common_variables
  haml :error
end unless Sinatra::Application.environment == :development

get "/css/master.css" do
  content_type "text/css", :charset => "utf-8"
  if FileTest.exist?(Nesta::Configuration.stylesheet)
    template = File.open(Nesta::Configuration.stylesheet).read
    sass_engine = Sass::Engine.new(template)
    sass_engine.render
  else
    sass :master
  end
end

get "/" do
  set_common_variables
  @title = "Donotremove aka Mike Stenhouse :: UX, UI and Product Designer"
  @keywords = "web design, user experience design, user interface design, product design"
  @description = "This little corner of the interweb is occupied by Mike Stenhouse, a web developer and designer based in London."
  haml :home
end
get "/portfolio" do
  set_common_variables
  @title = "Portfolio"
  @keywords = "web design, user experience design, user interface design, product design, html, xhtml, css, user interface development"
  @description = ""
  @portfolio = [
    {:name => "SONAR Knowledge Map, Trampoline Systems", :date => "04/09", :role => "Head of User Experience", :skills => "Design, User Experience, Product Design, Strategy"},
    {:name => "Angry Natives", :date => "02/07", :role => "Designer and Developer", :skills => "Design, XHTML and CSS"},
    {:name => "Gavin Stenhouse", :date => "01/07", :role => "Designer and Developer", :skills => "Design, XHTML and CSS"},
    {:name => "SONAR Dashboard, Trampoline Systems", :date => "09/07", :role => "Head of User Experience", :skills => "Design, User Experience, Product Design, Strategy"},
    {:name => "SONAR Flightdeck, Trampoline Systems", :date => "08/07", :role => "Head of User Experience", :skills => "Design, User Experience"},
    {:name => "SONAR Metascope, Trampoline Systems", :date => "06/07", :role => "Head of User Experience", :skills => "User Experience"},
    {:name => "Enron Explorer, Trampoline Systems", :date => "08/06", :role => "Head of User Experience", :skills => "XHTML, CSS, DOM Scripting, Design, Usability"},
    {:name => "Bloom Festival 2006", :date => "05/06", :role => "Designer and Developer", :skills => "Design, CSS, XHTML, PHP"},
    {:name => "Bottom Drawer", :date => "04/06", :role => "Developer", :skills => "XHTML, CSS, Accessibility"},
    {:name => "Keyword Researcher, Wordtracker", :date => "04/06", :role => "User Experience Consultant", :skills => "XHTML, CSS, Javascript, PHP, User Experience"},
    {:name => "Window on Woking", :date => "02/06", :role => "Designer", :skills => "Design, CSS"},
    {:name => "Elizabeth Rodgers Associates", :date => "08/05", :role => "Developer", :skills => "XHTML, CSS"},
    {:name => "Guildhall School of Music &amp Drama", :date => "07/05", :role => "Developer", :skills => "XHTML, CSS, Accessibility, Javascript"},
    {:name => "Children's Society Audit", :date => "04/05", :role => "Consultant", :skills => "User Experience, Usability, Strategy"},
    {:name => "Wordtracker Website, Wordtracker", :date => "04/05 ", :role => "Developer ", :skills => "XHTML, CSS, Accessibilty, Javascript, PHP"},
    {:name => "Warwick Arts Center ", :date => "04/05 ", :role => "Developer ", :skills => "Design, XHTML, CSS, Accessibilty"},
    {:name => "The Ramblers Association ", :date => "03/05 ", :role => "Designer and Developer ", :skills => "Design, XHTML, CSS, Accessibilty, Javascript"},
    {:name => "Lifestuff, Channel 4", :date => "03/05 ", :role => "Designer and Developer ", :skills => "Design, XHTML, CSS, Accessibilty"},
    {:name => "Clothing at Tesco ", :date => "03/05 ", :role => "Consultant ", :skills => "Accessibility"},
    {:name => "Use Your Paths, The Ramblers Association", :date => "02/05 ", :role => "Designer and Developer ", :skills => "Design, XHTML, CSS, Accessibilty"},
    {:name => "International HIV/AIDS Alliance ", :date => "01/05 ", :role => "Designer and Developer ", :skills => "Design, XHTML, CSS, ASP, XSLT, Accessibilty, Javascript, User Experience"},
    {:name => "Content with Style ", :date => "12/04 ", :role => "Designer and Developer ", :skills => "Design, XHTML, CSS, Javascript"},
    {:name => "Webarriba CMS Interface ", :date => "11/04 ", :role => "Designer and Developer ", :skills => "Design, XHTML, CSS, Accessibilty, User Experience"},
    {:name => "SCIE HR ", :date => "11/04 ", :role => "Designer ", :skills => "CSS, XHTML, Accessibility"},
    {:name => "PwC Careers ", :date => "11/04 ", :role => "Developer ", :skills => "HTML, CSS, Javascript"},
    {:name => "Course Discover ", :date => "10/04 ", :role => "Developer ", :skills => "XHTML, CSS, Accessibilty, Javascript"},
    {:name => "Webarriba ", :date => "10/04 ", :role => "Designer and Developer ", :skills => "Design, XHTML, CSS, Accessibilty"},
    {:name => "HAL Knowledge Solutions ", :date => "09/04 ", :role => "Developer ", :skills => "XHTML, CSS, Accessibilty"},
    {:name => "Locus Design ", :date => "08/04 ", :role => "Developer ", :skills => "XHTML, CSS, Accessibilty"},
    {:name => "Red Bull Final 5 ", :date => "07/04 ", :role => "Developer ", :skills => "XHTML, CSS, PHP"},
    {:name => "Britten-Pears Foundation ", :date => "07/04 ", :role => "Developer ", :skills => "XHTML, CSS, Accessibilty"},
    {:name => "English UK ", :date => "07/04 ", :role => "Developer ", :skills => "XHTML, CSS, Accessibilty"},
    {:name => "Wafa Trading ", :date => "06/04 ", :role => "Designer ", :skills => "Design"},
    {:name => "Spring Barn Vineyard ", :date => "06/04 ", :role => "Designer and Developer ", :skills => "Design, XHTML, CSS, Accessibilty"},
    {:name => "Virgin Mobile Louder ", :date => "06/04 ", :role => "Developer ", :skills => "XHTML, CSS, Accessibilty"},
    {:name => "Ken4London ", :date => "05/04 ", :role => "Developer ", :skills => "XHTML, CSS, Accessibilty"},
    {:name => "Eurovision 2004, BBC", :date => "03/04 ", :role => "Developer ", :skills => "HTML, CSS"},
    {:name => "BusinessLink Mk 2 ", :date => "03/04 ", :role => "Developer ", :skills => "XHTML, CSS, Accessibilty"},
    {:name => "Postage Paid CSS Zen Garden ", :date => "02/04 ", :role => "Designer and Developer ", :skills => "Design, CSS"},
    {:name => "Scooby Doo 2 ", :date => "01/04 ", :role => "Developer ", :skills => "HTML, CSS"},
    {:name => "Torque ", :date => "01/04 ", :role => "Developer ", :skills => "Flash, HTML"},
    {:name => "Virgin Holidays Email Promotion ", :date => "11/03 ", :role => "Developer ", :skills => "HTML, CSS"},
    {:name => "Nykris Training ", :date => "11/03 ", :role => "Trainer ", :skills => "Training, CSS, XHTML, Accessibility"},
    {:name => "Interent Car and Van Hire ", :date => "11/03 ", :role => "Designer and Developer ", :skills => "Design, XHTML, CSS, PHP"},
    {:name => "BusinessLink Mk 1 ", :date => "09/03 ", :role => "Developer ", :skills => "XHTML, CSS, Accessibilty"},
    {:name => "SpiritSoft ", :date => "04/03 ", :role => "Designer and Developer ", :skills => "CSS, XHTML, ASP, SQL Server, Design"}
  ]
  haml :portfolio
end
get "/contact" do
  "Contact"
end


get Nesta::Configuration.site_matcher do
  set_common_variables
  @body_class = "home"
  @heading = Nesta::Configuration.title
  @subtitle = Nesta::Configuration.subtitle
  @description = Nesta::Configuration.description
  @keywords = Nesta::Configuration.keywords
  @title = "#{@heading} - #{@subtitle}"
  @articles = Article.find_all[0..7]
  haml :index
end

get Nesta::Configuration.categories_matcher do
  set_common_variables
  @category = Category.find_by_permalink(params[:permalink])
  raise Sinatra::NotFound if @category.nil?
  @title = "#{@category.heading} - #{Nesta::Configuration.title}"
  @description = @category.description
  @keywords = @category.keywords
  haml :category
end

get Nesta::Configuration.articles_matcher do
  set_common_variables
  @article = Article.find_by_permalink(params[:permalink])
  raise Sinatra::NotFound if @article.nil?
  @title = if @article.parent
    "#{@article.heading} - #{@article.parent.heading}"
  else
    "#{@article.heading} - #{Nesta::Configuration.title}"
  end
  @description = @article.description
  @keywords = @article.keywords
  @comments = @article.comments
  haml :article
end

get "/attachments/:filename.:ext" do
  file = File.join(
      Nesta::Configuration.attachment_path, "#{params[:filename]}.#{params[:ext]}")
  send_file(file, :disposition => nil)
end

get "/articles.xml" do
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





