require_relative '../core/base_service'

module Naver
  module Searchad
    module Api
      module Stat
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
