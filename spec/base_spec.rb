require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Faturando::Base do
  it 'parses element names' do
    Faturando::Base.stub!(:name).and_return("Test::Namespace::ElementName")
    Faturando::Base.element_name.should eql('element_name')
  end
end
