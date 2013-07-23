require 'rubygems'
require 'jms'

# Connect to ActiveMQ
config = {
    :factory => 'org.apache.activemq.ActiveMQConnectionFactory',
    :broker_url => 'tcp://127.0.0.1:61616',
    :require_jars => [
      "/usr/local/Cellar/activemq/5.6.0/libexec/activemq-all-5.6.0.jar",
      "/usr/local/Cellar/activemq/5.6.0/libexec/lib/optional/log4j-1.2.16.jar"
    ]
}

JMS::Connection.session(config) do |session|
    session.producer(:queue_name => 'ExampleQueue') do |producer|
    producer.send(session.message("Hello World"))
    end
end