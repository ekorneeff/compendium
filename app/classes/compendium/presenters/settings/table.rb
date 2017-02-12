require 'compendium/presenters/settings/query'

module Compendium::Presenters::Settings
  class Table < Query
    attr_reader :headings

    def initialize(*)
      super

      @headings = {}

      # Set default values for settings
      number_format       Compendium.config.table.number_format
      table_class         Compendium.config.table.table_class
      header_class        Compendium.config.table.header_class
      row_class           Compendium.config.table.row_class
      totals_class        Compendium.config.table.totals_class
      skipped_total_cols  []
    end

    def set_headings(headings)
      headings.map!(&:to_sym)
      @headings = Hash[headings.zip(headings)].with_indifferent_access
    end

    def override_heading(*args, &block)
      if block_given?
        @headings.each do |key, val|
          res = yield val.to_s
          @headings[key] = res if res
        end
      else
        col, label = args
        @headings[col] = label
      end
    end

    def format(column, &block)
      @settings[:formatters] ||= {}
      @settings[:formatters][column] = block
    end

    def formatters
      (@settings[:formatters] || {})
    end

    def skip_total_for(*cols)
      @settings[:skipped_total_cols].concat(cols.map(&:to_sym))
    end
  end
end
