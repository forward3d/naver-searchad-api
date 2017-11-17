require_relative '../core/base_service'
require 'addressable/uri'

module Naver
  module Searchad
    module Api
      module StatReport
        class Service < Naver::Searchad::Api::Core::BaseService

          def initialize
            super('https://api.naver.com/', '')
          end

          def download_report(download_url, file_path, options: {}, &block)
            uri = Addressable::URI.parse(download_url)

            command = make_download_command(:get, uri.path, options)
            command.query['authtoken'] = uri.query_values['authtoken']
            command.download_dest = file_path
            execute_command(command, &block)
          end

          def get_stat_report(report_job_id, options: {}, &block)
            command = make_command(:get, '/stat-reports/{report_job_id}', options)
            command.params['report_job_id'] = report_job_id
            execute_command(command, &block)
          end

          def list_stat_reports(options: {}, &block)
            command = make_command(:get, '/stat-reports', options)
            execute_command(command, &block)
          end

          def create_stat_report(type, date, options: {}, &block)
            command = make_command(:post, '/stat-reports', options)
            command.request_object = {
              'reportTp' => type,
              'statDt' => date
            }
            execute_command(command, &block)
          end

          def delete_stat_reports(options: {}, &block)
            command = make_command(:delete, '/stat-reports', options)
            execute_command(command, &block)
          end

          def delete_stat_report(report_job_id, options: {}, &block)
            command = make_command(:delete, '/stat-reports/{report_job_id}', options)
            command.params['report_job_id'] = report_job_id
            execute_command(command, &block)
          end
        end
      end
    end
  end
end
