module Naver
  module Searchad
    module Api
      VERSION = '1.1.2'

      OS_VERSION = begin
        if RUBY_PLATFORM =~ /mswin|win32|mingw|bccwin|cygwin/
          `ver`.sub(/\s*\[Version\s*/, '/').sub(']', '').strip
        elsif RUBY_PLATFORM =~ /darwin/i
          "Mac OS X/#{`sw_vers -productVersion`}"
        elsif RUBY_PLATFORM == 'java'
          require 'java'
          name = java.lang.System.getProperty('os.name')
          version = java.lang.System.getProperty('os.version')
          "#{name}/#{version}"
        else
          `uname -sr`.sub(' ', '/')
        end
      rescue
        RUBY_PLATFORM
      end.gsub("\n", '')
    end
  end
end
