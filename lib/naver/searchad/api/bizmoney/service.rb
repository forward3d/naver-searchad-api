require_relative '../core/base_service'

module Naver
  module Searchad
    module Api
      module Bizmoney
        class Service < Naver::Searchad::Api::Core::BaseService

          def initialize
            super('https://api.naver.com/', 'billing/')
          end

          def get_bizmoney(options: nil, &block)
            command = make_command(:get, 'bizmoney', options)
            execute_command(command, &block)
          end

          def get_bizmoney_cost(start_date, end_date, options: nil, &block)
            command = make_command(:get, 'bizmoney/cost', options)
            command.query['searchStartDt'] = start_date.strftime('%Y%m%d')
            command.query['searchEndDt'] = end_date.strftime('%Y%m%d')
            execute_command(command, &block)
          end

          def get_bizmoney_charge(start_date, end_date, options: nil, &block)
            command = make_command(:get, 'bizmoney/histories/charge', options)
            command.query['searchStartDt'] = start_date.strftime('%Y%m%d')
            command.query['searchEndDt'] = end_date.strftime('%Y%m%d')
            execute_command(command, &block)
          end

          def get_bizmoney_exhaust(start_date, end_date, options: nil, &block)
            command = make_command(:get, 'bizmoney/histories/exhaust', options)
            command.query['searchStartDt'] = start_date.strftime('%Y%m%d')
            command.query['searchEndDt'] = end_date.strftime('%Y%m%d')
            execute_command(command, &block)
          end

          def get_bizmoney_period(start_date, end_date, options: nil, &block)
            command = make_command(:get, 'bizmoney/histories/period', options)
            command.query['searchStartDt'] = start_date.strftime('%Y%m%d')
            command.query['searchEndDt'] = end_date.strftime('%Y%m%d')
            execute_command(command, &block)
          end

        end
      end
    end
  end
end
