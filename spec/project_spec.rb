require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Faturando::Project do
  it 'has a default site config' do
    Faturando::Project.site.to_s.should == 'https://faturan.do'
  end

  it 'returns current project details' do
    project = Factory(:project, :id => "1234")
    Faturando::Project.current.should == project
  end
end
