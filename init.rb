require 'redmine'
require_relative 'lib/query_patch'
require_relative 'lib/time_entry_query_patch'

# ActionDispatch::Callbacks.to_prepare do                for Rails 5.0 -- deprecoted TODO sim need testing
# ActiveSupport::Reloader.to_prepare do                  for Rails 5.1
reloader = defined?(ActiveSupport::Reloader) ? ActiveSupport::Reloader : ActionDispatch::Reloader
reloader.to_prepare do
  QueryCustomFieldColumn.send :include, QueryCustomFieldColumnPatch
end

reloader.to_prepare do
  TimeEntryQuery.send :include, TimeEntryQueryPatch
end

Redmine::Plugin.register :user_custom_fields_extention do
  name 'User custom fields extention plugin'
  author 'Sergey Melnikov'
  description 'Added users custom fields to time_entry report. '
  version '0.0.1'
  url 'https://github.com/SimSmolin/user_custom_fields_extention.git'
  author_url 'https://github.com/SimSmolin'
end
