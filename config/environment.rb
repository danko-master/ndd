
# Для 1gb# ENV['GEM_HOME']="#{ENV['HOME']}/.gems"
# Для 1gb# ENV['GEM_PATH']="#{ENV['GEM_HOME']}:#{ENV['HOME']}/opt/ruby/current/lib/ruby/gems/1.9.1:/opt/ruby/current/lib/ruby/gems/1.9.1"


# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Ndd::Application.initialize!

#WillPaginate::ViewHelpers.pagination_options[:prev_label] = t('page.prev')
#WillPaginate::ViewHelpers.pagination_options[:next_label] = t('page.next')
