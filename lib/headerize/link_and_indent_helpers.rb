module Headerize
  # Contains helpers for indenting and producing links or includes. Used by
  # +StylesheetHelper+ and +JavascriptHelper+.
  module LinkAndIndentHelpers
    private
      # Indents the given string by the given amount. Does not indent the first
      # line.
      def indent(string, amt)
        string.gsub /\n *([^\n]+)/m, "\n#{' ' * amt}\\1"
      end

      # Collects the (string) results of invoking +method_name+ with each of the
      # parameter sets in +collection+ and then taking the result and invoking
      # the above +indent+ method on it. Returns a blank string if the
      # collection is nil.
      def collect_and_indent(collection, method_name, indent_amt)
        return '' if collection.nil?

        collected = collection.inject('') do |str, args|
          str << send(method_name, *args)
        end

        indent(collected, indent_amt)
      end
  end
end
