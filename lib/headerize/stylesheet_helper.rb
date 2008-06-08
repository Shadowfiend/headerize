module Headerize
  module StylesheetHelper
    def add_stylesheet(*args)
      @stylesheets ||= []
      @stylesheets << args

      nil
    end

    def stylesheet_links(opts = {})
      return '' if @stylesheets.nil?

      links = @stylesheets.inject('') do |str, files_and_opts|
        str << stylesheet_link_tag(*files_and_opts)
      end

      indent(links, opts[:indent] || 4)
    end

    private
      # Indents the given string by the given amount. Does not indent the first
      # line.
      def indent(string, amt)
        string.gsub /\n *([^\n]+)/m, "\n#{' ' * amt}\\1"
      end
  end
end

