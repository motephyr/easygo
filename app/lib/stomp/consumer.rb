require 'rubygems'
require 'stomp'

queue = "/queue/manager"

puts "Consumer for quque #{queue}"

client = Stomp::Client.new "system","manager", "localhost", 61613, true

client.subscribe queue,{ :ack => :client } do |message|
    puts "message=#{message.body}"
    client.acknowledge message
end

client.join
client.close