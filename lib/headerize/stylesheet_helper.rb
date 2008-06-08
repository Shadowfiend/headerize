require File.dirname(__FILE__) + '/link_and_indent_helpers'

module Headerize
  # Includes helpers for placing stylesheets in the head of a page while still
  # allowing the addition of stylesheets in any template file.
  #
  # See the main README for more information. +add_stylesheet+ is the main
  # interface, used to add stylesheets to the list of links anywhere. Then,
  # +stylesheet_links+ can be used to retrieve the full list of links to place
  # in the head of the page (probably in a layout file).
  module StylesheetHelper
    include LinkAndIndentHelpers

    # Adds all given stylesheets to the list of stylesheet link tags that will
    # be returned by +stylesheet_links+. See the +stylesheet_link_tag+
    # documentation for more on what arguments can be passed (an invocation to
    # +add_stylesheet+ can be exactly the same as one to +stylesheet_link_tag+).
    def add_stylesheet(*args)
      @stylesheets ||= []
      @stylesheets << args

      nil
    end

    alias_method :add_stylesheets, :add_stylesheet

    # Returns all stylesheet links added by +add_stylesheet+. These links are
    # indented by 4 spaces by default. Pass the <tt>:indent</tt> option with a
    # different number for a different indentation level.
    def stylesheet_links(opts = {})
      collect_and_indent @stylesheets, :stylesheet_link_tag,
                         opts[:indent] || 4
    end
  end
end

