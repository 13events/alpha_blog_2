# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

#Disable Rails 'Field With Error' feature
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end