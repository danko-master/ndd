# Используя символ ':user' или 'main', мы указываем Factory Girl на необходимость симулировать модель User или Main.


Factory.define :main do |main|
  main.title "Title example"
  main.content "Content example" 
  main.metadescription "metadescription example"
  main.metakeywords "metakeywords example"
  main.head "head example"
  main.contact "contact example"
  main.footer "footer example"
  main.counter "counter example"
  
end


Factory.define :page do |page|
  page.name "Name example page"
  page.title "Title example page"
  page.content "Content example page" 
  page.metadescription "metadescription example page"
  page.metakeywords "metakeywords example page"
  page.head "head example page"
  page.ismenu true
    
end

Factory.define :user do |user|
  user.sequence(:name) { |n| "UserTest#{n}" }
  user.sequence(:email) {|n| "email#{n}@example.com" }
  user.password              "foobar"
  user.password_confirmation "foobar"
end