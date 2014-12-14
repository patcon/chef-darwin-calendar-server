require 'digest/md5'

module Opscode
  module CalendarServerHelpers

def create_guid(username)
  hyphen_positions = [20, 16, 12, 8]
  hash = Digest::MD5.hexdigest(username).upcase
  guid = hyphen_positions.inject(hash) { |result, element| result.insert(element, '-') }

  guid
end

  end
end
