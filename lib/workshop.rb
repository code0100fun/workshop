require "rake"
require "yaml"
require "active_support/core_ext/string/inflections"
# Get rid of deprication warning
I18n.enforce_available_locales = false
require "workshop/version"
require "workshop/project"
require "workshop/builder"
require "workshop/uploader"
require "workshop/arduino"
require "workshop/tools"
require "workshop/tasks"
require "workshop/project/configuration"
require "workshop/project/configuration/build"
require "workshop/project/configuration/upload"

module Workshop
end
