require 'headerize'
ActionView::Base.send :include, Headerize::JavascriptHelper
ActionView::Base.send :include, Headerize::StylesheetHelper
