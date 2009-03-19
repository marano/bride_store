$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'test/unit'
require 'rubygems'
require 'action_controller'
require 'in_place_editing'
require 'in_place_macros_helper'

$:.unshift(File.dirname(__FILE__))

require 'i18n'

I18n.load_path += Dir.glob("test/locale/*.yml")

def clear_locale
  I18n.locale = nil
end

def localizate(locale)
  I18n.locale = locale
end