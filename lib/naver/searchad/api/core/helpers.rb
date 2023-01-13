require 'naver/searchad/api'

module Naver
  module Searchad
    module Api
      module Core
        module Helpers
          private

          def new_template(url)
            Addressable::Template.new(remove_excessive_fslashes_from_url(url))
          end

          def remove_excessive_fslashes_from_url(url)
            tmp = Addressable::URI.parse(url)
            tmp.path = tmp.path.squeeze('/')
            tmp.to_s
          end
        end
      end
    end
  end
end
