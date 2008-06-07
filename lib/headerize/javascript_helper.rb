module Headerize
  module JavascriptHelper
    def add_javascript(*args)
      @javascripts ||= []
      @javascripts << args

      nil
    end

    def javascript_includes(opts = {})
      return '' if @javascripts.nil?

      indent_amt = opts[:indent] || 4

      includes = @javascripts.inject('') do |str, files_and_opts|
        str << javascript_include_tag(*files_and_opts)
      end

      indent(includes, indent_amt)
    end

    private
      # Indents the given string by the given amount. Does not indent the first
      # line.
      def indent(string, amt)
        string.gsub /\n *([^\n]+)/m, "\n#{' ' * amt}\\1"
      end
  end
end

