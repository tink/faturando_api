require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Faturando::Customer do
  it 'has a default site config' do
    Faturando::Customer.site.to_s.should == 'https://faturan.do/'
  end
end
