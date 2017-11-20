require_relative 'api_command'
require 'addressable/uri'

module Naver
  module Searchad
    module Api
      module Core
        class DownloadCommand < ApiCommand
          OK_STATUSES = [200, 201, 206]

          attr_accessor :download_dest

          def prepare!
            @state = :start
            @download_url = nil
            @offset = 0

            if download_dest.is_a?(String)
              @download_io = File.open(download_dest, 'wb')
              @close_io_on_finish = true
            else
              @download_io = StringIO.new('', 'wb')
              @close_io_on_finish = false
            end

            super
          end

          def release!
            @download_io.close if @close_io_on_finish
          end

          def _execute(client)
            request_header = {}
            apply_request_options(request_header)
            download_offset = nil

            http_res = client.get(url.to_s,
                                  query: nil,
                                  header: request_header,
                                  follow_redirect: true) do |res, chunk|
              status = res.http_header.status_code.to_i
              next unless OK_STATUSES.include?(status)

              download_offset ||= (status == 206 ? @offset : 0)
              download_offset += chunk.bytesize

              if download_offset - chunk.bytesize == @offset
                next_chunk = chunk
              else
                chunk_index = @offset - (download_offset - chunk.bytesize)
                next_chunk = chunk.byteslice(chunk_index..-1)
                next if next_chunk.nil?
              end

              @download_io.write(next_chunk)
              @offset += next_chunk.bytesize
            end

            @download_io.flush

            if @close_io_on_finish
              result = nil
            else
              result = @download_io
            end
            check_status(http_res.status.to_i, http_res.header, http_res.body)
            logger.debug("DownloadCommand: Success")
            success(result)
          rescue => e
            @download_io.flush
            logger.debug("DownloadCommand: Error - #{e.inspect}")
            error(e)
          end
        end
      end
    end
  end
end
