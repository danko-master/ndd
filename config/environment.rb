# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Ndd::Application.initialize!

#WillPaginate::ViewHelpers.pagination_options[:prev_label] = t('page.prev')
#WillPaginate::ViewHelpers.pagination_options[:next_label] = t('page.next')