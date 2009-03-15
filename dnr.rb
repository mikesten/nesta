
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
    {:name => "Persuasive Design, Iceweb 2008", :date => "11/08", :kind => :conference, :role => "Speaker", :skills => "Design and Psychology"},
    {:name => "Tapping the Mainline, SHiFT 2008", :date => "10/08", :kind => :conference, :role => "Speaker", :skills => "Design and Psychology"},
    {:name => "From Ego to Ergo, Skillswap", :date => "07/08", :kind => :conference, :role => "Speaker", :skills => "Design and Psychology"},
    {:name => "But I'm a Bloody Designer, @media 2007", :date => "11/07", :kind => :conference, :role => "Speaker", :skills => "Design, Team Dynamics and Ruby"},
    {:name => "Collective Intelligence Indeterminacy and the Illusion of Control, ETech 2007", :date => "03/07", :kind => :conference, :role => "Speaker", :skills => "Product Design, Psychology"},
    {:name => "Building Modern Webapps, The Spring Experience 2006", :date => "12/06", :kind => :conference, :role => "Speaker", :skills => "XHTML, CSS and Javascript"},
    {:name => "SONAR Knowledge Map, Trampoline Systems", :date => "04/09", :kind => :product, :role => "Head of User Experience", :skills => "Design, User Experience, Product Design, Strategy, Ruby"},
    {:name => "Out of Five", :date => "01/08", :kind => :product, :role => "Designer and Developer", :skills => "Design, XHTML, CSS, Ruby"},
    {:name => "Angry Natives", :date => "02/09", :kind => :website, :role => "Designer and Developer", :skills => "Design, XHTML and CSS"},
    {:name => "Gavin Stenhouse", :date => "01/09", :kind => :website, :role => "Designer and Developer", :skills => "Design, XHTML and CSS"},
    {:name => "SONAR Dashboard, Trampoline Systems", :date => "09/07", :kind => :product, :role => "Head of User Experience", :skills => "Design, User Experience, Product Design, Strategy, Ruby"},
    {:name => "SONAR Flightdeck, Trampoline Systems", :date => "08/07", :kind => :product, :role => "Head of User Experience", :skills => "Design, User Experience, Ruby"},
    {:name => "SONAR Metascope, Trampoline Systems", :date => "06/07", :kind => :product, :role => "Head of User Experience", :skills => "User Experience, Ruby"},
    {:name => "Enron Explorer, Trampoline Systems", :date => "08/06", :kind => :website, :role => "Head of User Experience", :skills => "XHTML, CSS, DOM Scripting, Design, Usability, Ruby"},
    {:name => "Bloom Festival 2006", :date => "05/06", :kind => :website, :role => "Designer and Developer", :skills => "Design, CSS, XHTML, PHP"},
    {:name => "Bottom Drawer", :date => "04/06", :kind => :website, :role => "Developer", :skills => "XHTML, CSS, Accessibility"},
    {:name => "Keyword Researcher, Wordtracker", :kind => :product, :date => "04/06", :role => "User Experience Consultant", :skills => "XHTML, CSS, Javascript, PHP, User Experience"},
    {:name => "Will Barras", :date => "05/06", :kind => :website, :role => "Designer", :skills => "Design, XHTML, CSS, PHP"},
    {:name => "Window on Woking", :date => "02/06", :kind => :website, :role => "Designer", :skills => "Design, CSS"},
    {:name => "Elizabeth Rodgers Associates", :date => "08/05", :kind => :website, :role => "Developer", :skills => "XHTML, CSS"},
    {:name => "Guildhall School of Music &amp Drama", :date => "07/05", :kind => :website, :role => "Developer", :skills => "XHTML, CSS, Accessibility, Javascript"},
    {:name => "Children's Society Audit", :date => "04/05", :kind => :website, :role => "Consultant", :skills => "User Experience, Usability, Strategy"},
    {:name => "Wordtracker Website, Wordtracker", :date => "04/05 ", :kind => :website, :role => "Developer ", :skills => "XHTML, CSS, Accessibilty, Javascript, PHP"},
    {:name => "Warwick Arts Center ", :date => "04/05 ", :kind => :website, :role => "Developer ", :skills => "Design, XHTML, CSS, Accessibilty"},
    {:name => "The Ramblers Association ", :date => "03/05 ", :kind => :website, :role => "Designer and Developer ", :skills => "Design, XHTML, CSS, Accessibilty, Javascript"},
    {:name => "Lifestuff, Channel 4", :date => "03/05 ", :kind => :website, :role => "Designer and Developer ", :skills => "Design, XHTML, CSS, Accessibilty"},
    {:name => "Clothing at Tesco ", :date => "03/05 ", :kind => :website, :role => "Consultant ", :skills => "Accessibility"},
    {:name => "Use Your Paths, The Ramblers Association", :kind => :website, :date => "02/05 ", :role => "Designer and Developer ", :skills => "Design, XHTML, CSS, Accessibilty"},
    {:name => "International HIV/AIDS Alliance ", :date => "01/05", :kind => :website, :role => "Designer and Developer ", :skills => "Design, XHTML, CSS, ASP, XSLT, Accessibilty, Javascript, User Experience"},
    {:name => "Content with Style ", :date => "12/04", :kind => :website, :role => "Designer and Developer ", :skills => "Design, XHTML, CSS, Javascript"},
    {:name => "Webarriba CMS Interface ", :date => "11/04", :kind => :product, :role => "Designer and Developer ", :skills => "Design, XHTML, CSS, Accessibilty, User Experience"},
    {:name => "SCIE HR ", :date => "11/04 ", :kind => :website, :role => "Designer ", :skills => "CSS, XHTML, Accessibility"},
    {:name => "PwC Careers ", :date => "11/04 ", :kind => :website, :role => "Developer ", :skills => "HTML, CSS, Javascript"},
    {:name => "Course Discover ", :date => "10/04", :kind => :website, :role => "Developer ", :skills => "XHTML, CSS, Accessibilty, Javascript"},
    {:name => "Webarriba ", :date => "10/04 ", :kind => :website, :role => "Designer and Developer ", :skills => "Design, XHTML, CSS, Accessibilty"},
    {:name => "HAL Knowledge Solutions ", :date => "09/04", :kind => :website, :role => "Developer ", :skills => "XHTML, CSS, Accessibilty"},
    {:name => "Locus Design ", :date => "08/04 ", :kind => :website, :role => "Developer ", :skills => "XHTML, CSS, Accessibilty"},
    {:name => "Red Bull Final 5 ", :date => "07/04 ", :kind => :website, :role => "Developer ", :skills => "XHTML, CSS, PHP"},
    {:name => "Britten-Pears Foundation ", :date => "07/04 ", :kind => :website, :role => "Developer ", :skills => "XHTML, CSS, Accessibilty"},
    {:name => "English UK ", :date => "07/04 ", :kind => :website, :role => "Developer ", :skills => "XHTML, CSS, Accessibilty"},
    {:name => "Wafa Trading ", :date => "06/04 ", :kind => :website, :role => "Designer ", :skills => "Design"},
    {:name => "Spring Barn Vineyard ", :date => "06/04 ", :kind => :website, :role => "Designer and Developer ", :skills => "Design, XHTML, CSS, Accessibilty"},
    {:name => "Virgin Mobile Louder ", :date => "06/04 ", :kind => :website, :role => "Developer ", :skills => "XHTML, CSS, Accessibilty"},
    {:name => "Ken4London ", :date => "05/04 ", :kind => :website, :role => "Developer ", :skills => "XHTML, CSS, Accessibilty"},
    {:name => "Eurovision 2004, BBC", :date => "03/04 ", :kind => :website, :role => "Developer ", :skills => "HTML, CSS"},
    {:name => "BusinessLink Mk 2 ", :date => "03/04 ", :kind => :website, :role => "Developer ", :skills => "XHTML, CSS, Accessibilty"},
    {:name => "Postage Paid CSS Zen Garden ", :date => "02/04 ", :kind => :website, :role => "Designer and Developer ", :skills => "Design, CSS"},
    {:name => "Scooby Doo 2 ", :date => "01/04 ", :kind => :website, :role => "Developer ", :skills => "HTML, CSS"},
    {:name => "Torque ", :date => "01/04 ", :kind => :website, :role => "Developer ", :skills => "Flash, HTML"},
    {:name => "Virgin Holidays Email Promotion ", :date => "11/03 ", :kind => :website, :role => "Developer ", :skills => "HTML, CSS"},
    {:name => "Nykris Training ", :date => "11/03 ", :kind => :training, :role => "Writer", :skills => "Training, CSS, XHTML, Accessibility"},
    {:name => "Interent Car and Van Hire ", :date => "11/03 ", :kind => :website, :role => "Designer and Developer ", :skills => "Design, XHTML, CSS, PHP"},
    {:name => "BusinessLink Mk 1 ", :date => "09/03 ", :kind => :website, :role => "Developer ", :skills => "XHTML, CSS, Accessibilty"},
    {:name => "SpiritSoft ", :date => "04/03 ", :kind => :website, :role => "Designer and Developer ", :skills => "CSS, XHTML, ASP, SQL Server, Design"}
  ]
  @nav = :portfolio
  haml :portfolio
end
get "/contact" do
  set_common_variables
  @title = "Contact"
  @keywords = ""
  @description = ""
  @nav = :contact
  haml :contact
end
get "/me" do
  set_common_variables
  @title = "Mike Stenhouse"
  @keywords = "Mike Stenhouse, Me, UX, UI, Design, About"
  @description = "Mike spent several years doing the rounds in various London agencies as a web standards and accessibility specialist, working for clients including Virgin, the BBC, PriceWaterhouse Coopers and Red Bull. In pursuit of a broader interest in how and why people use the web Mike settled into User Experience, helping to conceive and implement effective and usable interfaces for web applications."
  @about = ['twitter.com/mikesten', 'linkedin.com/in/mikestenhouse', 'slideshare.net/mikesten', 'github.com/mikesten', 'oo5.whatiminto.com/peeps/mikesten', 'flickr.com/mikesten', 'brightkite.com/people/mikesten', 'last.fm/user/mikesten', 'dopplr.com/traveller/mikesten'].sort
  haml :me
end
get "/projects" do
  set_common_variables
  @title = "Projects"
  @keywords = ""
  @description = ""
  @nav = :projects
  haml :projects
end
