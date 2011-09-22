class String
  unless method_defined?(:constantize)
    # Based on constantize from ActiveSupport::Inflector
    def constantize
      names = self.split('::')
      names.shift if names.empty? || names.first.empty?

      constant = Object
      names.each do |name|
        constant = constant.const_defined?(name, false) ? constant.const_get(name) : constant.const_missing(name)
      end
      constant
    end
  end

  unless method_defined?(:camelize)
    # Adapted from camelize from ActiveSupport::Inflector
    def camelize first_letter_in_uppercase = true
      if first_letter_in_uppercase
        self.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
      else
        self.to_s[0].chr.downcase + self[1..-1].camelize
      end
    end
  end
end