require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Faturando::Subscription do
  it 'has a default site config' do
    Faturando::Subscription.site.to_s.should == 'https://faturan.do/projects/1234/'
  end
end
