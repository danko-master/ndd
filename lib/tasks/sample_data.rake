namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Admin",
                         :email => "admin@admin.example",
                         :password => "1234567",
                         :password_confirmation => "1234567")
                         
    admin.toggle!(:admin)
    
    
    main = Main.create!(:title => "Main Page Title",
                         :content => "Content of main page",
                         :metadescription => "Meta description of main page",
                         :metakeywords => "Meta keywords of main page",
                         :head => "",
                         :contact => "Contact 12345",
                         :footer => "Footer here",
                         :counter => "")
                         
     page = Page.create!(:name => "First Page",
                         :title => "Page Title",
                         :content => "Content of page",
                         :metadescription => "Meta description of page",
                         :metakeywords => "Meta keywords of page",
                         :head => "",
                         :ismenu => true)  

  end
end