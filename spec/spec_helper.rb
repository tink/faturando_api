require 'rubygems'
require 'rspec'
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'faturando_api'

require 'fakeweb'
require 'mocks/fake_resource'
ActiveResource::Base.send :include, ActiveResource::FakeResource
FakeWeb.allow_net_connect = false
require 'factory_girl'
require 'faker'
require 'factories'

Faturando.configure do |c|
  c.project_key = '1234'
  c.api_key   = 'test'
end

RSpec.configure do |config|
  config.after(:each) do
    ActiveResource::FakeResource.clean
  end
end

def test_domain
  "#{Faturando::Base.connection.site.scheme}://#{Faturando::Base.connection.user}:#{Faturando::Base.connection.password}@#{Faturando::Base.connection.site.host}:#{Faturando::Base.connection.site.port}"
end
