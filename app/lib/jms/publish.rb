require 'rubygems'
require 'yaml'
require 'jms'

jms_provider = ARGV[0] || 'activemq'

# Load Connection parameters from configuration file
config = {
    :factory => 'org.apache.activemq.ActiveMQConnectionFactory',
    :broker_url => 'tcp://127.0.0.1:61616',
    :require_jars => [
      "/usr/local/Cellar/activemq/5.8.0/libexec/activemq-all-5.8.0.jar",
      "/usr/local/Cellar/activemq/5.8.0/libexec/lib/optional/log4j-1.2.17.jar"
    ]
}

JMS::Connection.session(config) do |session|
  session.producer(:topic_name => 'MobileNoticeDestination') do |producer|
    producer.send(session.message("Hello World: #{Time.now}"))
    JMS::logger.info "Successfully published one message to topic SampleTopic"
  end
end