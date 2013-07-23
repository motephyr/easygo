require 'rubygems'
require 'stomp'
require 'date'

now = DateTime.now.to_s
queue = "/queue/manager"

puts "Producer for queue #{queue}"

client = Stomp::Client.new "system","manager", "localhost", 61613, true

(1..100).each do |i|
  puts "productin #{i}"
  client.publish queue, "#{now} #{i} hello !", { :persistent => true}
  sleep 1
end

client.close