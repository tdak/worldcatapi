require 'rubygems'
require 'worldcatapi'

@key = ENV["WORLDCAT_KEY"]

puts "KEY=#{@key}"

client = WORLDCATAPI::Client.new(key: @key, debug: true)

response = client.OpenSearch(:q=>'building digital libraries', :format=>'atom', :start => '1', :count => '25', :cformat => 'all')

puts "Total Results: " + response.header["totalResults"]
response.records.each {|rec|
  puts "Title: " + rec[:title] + "\n"
  puts "URL: " + rec[:link] + "\n"
  puts "Authors: " + rec[:author].join(" ") + "\n"
  puts "OCLC #: " + rec[:id] + "\n"
  puts "Description: " + rec[:summary] + "\n"
  puts "citation: " + rec[:citation] + "\n" 
 
}

puts "\n\n\n"

puts "Get Record Test: " + "\n\n"
record = client.GetRecord(:type => "oclc", :id => "15550774")

puts record.record[:title] + "\n"
puts record.record[:link] + "\n"

puts "\n\n\n"
puts "Get Location Test: " + "\n\n"
info = client.GetLocations(:type=>"oclc", :id => "15550774")

info.institutions.each {|info|
  puts "Institutional Identifier:  " + info[:institutionIdentifier] + "\n"
  puts "OPAC Link: " + info[:link] + "\n"
  puts "Copies: " + info[:copies] + "\n\n\n"
} 

puts "\n\n\n"
puts "Citation Example: " + "\n\n"

citation = client.GetCitation(:type=>"oclc", :id=>"15550774", :cformat => 'all')
puts citation
puts "\n\n"


puts "\n\n\n"
puts "SRU Search Example: " + "\n\n"
records = client.SRUSearch(:query => '"civil war"')
puts "Total Records: " + records.header["numberOfRecords"] + "\n"
records.records.each {|rec|
  puts "Title: " + rec[:title] + "\n"
  puts "URL: " + rec[:link] + "\n\n\n"
}