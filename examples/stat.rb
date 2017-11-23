require 'naver/searchad/api/stat/service'
require 'naver/searchad/api/auth'

ENV['NAVER_API_KEY'] = 'Access license'
ENV['NAVER_API_SECRET'] = 'Private key'
ENV['NAVER_API_CLIENT_ID'] = 'CUSTOMER_ID'

# If you want to see debug level logs
# Naver::Searchad::Api.logger.level = Logger::DEBUG

stat = Naver::Searchad::Api::Stat::Service.new
stat.authorization = Naver::Searchad::Api::Auth.get_application_default

ad_id = 'ad id'
fields = %w[impCnt clkCnt ctr cpc avgRnk ccnt]
time_range = { since: '2017-11-21', until: '2017-11-21' }

puts 'Stat'
p stat.get_stat_by_id(ad_id, fields, time_range)

# breakdown option should be used with `allDays` time_increment
puts 'Stat with placement level breakdown'

result = stat.get_stat_by_id(ad_id, fields, time_range, time_increment: 'allDays', breakdown: 'eventCode')
result.data.each do |row|
  row['breakdowns'].each do |b|
    p b
  end
end

puts 'Stat with platform breakdown'

result = stat.get_stat_by_id(ad_id, fields, time_range, time_increment: 'allDays', breakdown: 'pcMblTp')
result.data.each do |row|
  row['breakdowns'].each do |b|
    p b
  end
end

puts 'Stat with day in week breakdown'
result = stat.get_stat_by_id(ad_id, fields, time_range, time_increment: 'allDays', breakdown: 'dayw')
result.data.each do |row|
  row['breakdowns'].each do |b|
    p b
  end
end

puts 'Stat with 24 hours breakdown'
result = stat.get_stat_by_id(ad_id, fields, time_range, time_increment: 'allDays', breakdown: 'hh24')
result.data.each do |row|
  row['breakdowns'].each do |b|
    p b
  end
end

puts 'Stat with region breakdown'
result = stat.get_stat_by_id(ad_id, fields, time_range, time_increment: 'allDays', breakdown: 'regnNo')
result.data.each do |row|
  row['breakdowns'].each do |b|
    p b
  end
end
