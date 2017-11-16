require_relative '../core/base_service'

module Naver
  module Searchad
    module Api
      module BusinessChannel
        class Service < Naver::Searchad::Api::Core::BaseService

          def initialize
            super('https://api.naver.com/', 'ncc/')
          end

          def list_channels(options: nil, &block)
            command = make_command(:get, 'channels', options)
            execute_command(command, &block)
          end
        end
      end
    end
  end
end
