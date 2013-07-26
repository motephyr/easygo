#
# Sample Topic Subscriber:
#   Retrieve all messages from a topic using a non-durable subscription
#
# Try starting multiple copies of this Consumer. All active instances should
# receive the same messages
#
# Since the topic subscription is non-durable, it will only receive new messages.
# Any messages sent prior to the instance starting will not be received.
# Also, any messages sent after the instance has stopped will not be received
# when the instance is re-started, only new messages sent after it started will
# be received.

# Allow examples to be run in-place without requiring a gem install

require 'rubygems'
require 'jms'
require 'yaml'


jms_provider = ARGV[0] || 'activemq'

# Load Connection parameters from configuration file
class MQ < Goliath::WebSocket
def startServer
mqconfig = {
  :factory => 'org.apache.activemq.ActiveMQConnectionFactory',
  :broker_url => 'tcp://127.0.0.1:61616',
  :require_jars => [
    "/usr/local/Cellar/activemq/5.8.0/libexec/activemq-all-5.8.0.jar",
    "/usr/local/Cellar/activemq/5.8.0/libexec/lib/optional/log4j-1.2.17.jar"
  ]
}



JMS::Connection.session(mqconfig) do |session|
  session.consume(:topic_name => 'MobileNoticeDestination', :timeout=>300000) do |message|
    puts 'bb'
    JMS::logger.info message.inspect
    config['channel'].push(message)
    #測試websocket
  end
end
end
end



