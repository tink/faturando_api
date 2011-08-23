require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Faturando::FeatureValue do
  it 'has a default site config' do
    Faturando::FeatureValue.site.to_s.should == 'https://faturan.do/projects/1234/plans/:plan_id'
  end
end
