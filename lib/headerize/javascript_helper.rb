require File.dirname(__FILE__) + '/link_and_indent_helpers'

module Headerize
  # Includes helpers for placing javascript in the head of a page while still
  # allowing the addition of scripts in any template file.
  #
  # See the main README for more information. +add_javascript+ is the main
  # interface, used to add scripts to the list of includes anywhere. Then,
  # +javascript_includes+ can be used to retrieve the full list of links to
  # place in the head of the page (probably in a layout file).
  module JavascriptHelper
    include LinkAndIndentHelpers

    # Adds all given javascript files to the list of javascript include tags
    # that will be returned by +javascript_includes+. See the
    # +javascript_include_tag+ documentation for more on what arguments can be
    # passed (an invocation to +add_javascript+ can be exactly the same as one
    # to +javascript_include_tag+).
    def add_javascript(*args)
      @javascripts ||= []
      @javascripts << args

      nil
    end

    alias_method :add_javascripts, :add_javascript

    # Returns all Javascript includes added by +add_javascript+. These includes
    # are indented by 4 spaces by default. Pass the <tt>:indent</tt> option with
    # a different number for a different indentation level.
    def javascript_includes(opts = {})
      collect_and_indent @javascripts, :javascript_include_tag,
                         opts[:indent] || 4
    end
  end
end

