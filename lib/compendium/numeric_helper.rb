module Compendium
  module NumericHelper

    def numeric?(value)
      case value
      when String, Symbol
        !(value.to_s =~ /\A-?\d+(\.\d+)?\z|\A-?\.\d+\z/).nil?
      when Numeric
        true
      else
        false
      end
    end

    def zero?(value)
      case value
      when String, Symbol
        value.to_s.in?(['0', '0.0'])
      when Numeric
        value.zero?
      else
        false
      end
    end
    
  end
end