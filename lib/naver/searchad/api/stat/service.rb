require_relative '../core/base_service'

module Naver
  module Searchad
    module Api
      module Stat
        class Service < Naver::Searchad::Api::Core::BaseService

          def initialize
            super('https://api.naver.com/', '')
          end

          def get_stat_by_id(id,
                             fields,
                             time_range,
                             options: {},
                             date_preset: nil,
                             time_increment: nil,
                             breakdown: nil,
                             &block)
            command = make_command(:get, 'stats', options)
            command.query['id'] = id
            command.query['fields'] = fields.to_json
            command.query['timeRange'] = time_range.to_json
            command.query['datePreset'] = date_preset if date_preset
            command.query['timeIncrement'] = time_increment if time_increment
            command.query['breakdown'] = breakdown if breakdown

            execute_command(command, &block)
          end

          def get_stat_by_ids(ids,
                              fields,
                              time_range,
                              options: {},
                              date_preset: nil,
                              time_increment: nil,
                              breakdown: nil,&block)
            command = make_command(:get, 'stats', options)
            command.query['ids'] = ids
            command.query['fields'] = fields.to_json
            command.query['timeRange'] = time_range.to_json
            command.query['datePreset'] = date_preset if date_preset
            command.query['timeIncrement'] = time_increment if time_increment
            command.query['breakdown'] = breakdown if breakdown

            execute_command(command, &block)
          end
        end
      end
    end
  end
end
