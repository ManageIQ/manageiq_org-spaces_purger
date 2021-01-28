#!/bin/env ruby
require 'bundler/setup'

def format_key(key)
  @string_size = [@string_size.to_i, key.length + 2].max
  key.ljust(@string_size, "-")
end

def s3_client
  @client ||= begin
    require 'aws-sdk-s3'
    Aws::S3::Client.new(:access_key_id => ENV['SPACES_KEY'], :secret_access_key => ENV['SPACES_SECRET'], :endpoint => "https://nyc3.digitaloceanspaces.com", :region => 'us-east-1')
  end
end

bucket         = ENV['SPACES_BUCKET']
deletion_count = 0
start_time     = Time.now.utc.to_i
puts "Cleaning objects in bucket: #{bucket}..."

s3_client.list_objects(:bucket => bucket).flat_map { |r| r.contents }.each do |obj|
  object = s3_client.head_object(:bucket => bucket, :key => obj.key)
  print format_key(obj.key)
  case object.metadata["delete-at"].to_i
  when 0
    puts "Skipping, no delete-at"
  when 1..start_time
    print "Deleting... "
    s3_client.delete_object(:bucket => bucket, :key => obj.key)
    deletion_count += 1
    puts "done"
  else
    puts "Skipping, delete-at in the future"
  end
end

puts "Completed in #{Time.now.utc.to_i - start_time} seconds."
puts "#{deletion_count} objects removed."
