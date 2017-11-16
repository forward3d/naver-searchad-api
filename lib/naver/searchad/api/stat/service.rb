require_relative '../core/base_service'

module Naver
  module Searchad
    module Api
      module Stat
        module DatePreset
          TODAY = 'today'.freeze
          YESTERDAY = 'yesterday'.freeze
          LAST_7_DAYS = 'last7days'.freeze
          LAST_30_DAYS = 'last30days'.freeze
          WEEK = 'lastweek'.freeze
          LAST_MOMTH = 'lastmonth'.freeze
          LAST_QUARTER = 'lastquarter'.freeze
        end

        class Service < Naver::Searchad::Api::Core::BaseService

          def initialize
            super('https://api.naver.com/', '')
          end

          def get_stat_by_id(id, fields, time_range, options: {}, &block)
            command = make_command(:get, 'stats', options)
            command.query['id'] = id
            command.query['fields'] = fields.to_json
            command.query['timeRange'] = time_range.to_json
            command.query['datePreset'] = options[:date_preset] if options[:date_preset]
            command.query['timeIncrement'] = options[:time_increment] if options[:time_increment]
            command.query['breakdown'] = options[:breakdown] if options[:breakdown]

            execute_command(command, &block)
          end

          def get_stat_by_ids(ids, fields, time_range, options: {}, &block)
            command = make_command(:get, 'stats', options)
            command.query['ids'] = ids
            command.query['fields'] = fields.to_json
            command.query['timeRange'] = time_range.to_json
            command.query['datePreset'] = options[:date_preset] if options[:date_preset]
            command.query['timeIncrement'] = options[:time_increment] if options[:time_increment]
            command.query['breakdown'] = options[:breakdown] if options[:breakdown]

            execute_command(command, &block)
          end
        end
      end
    end
  end
end
