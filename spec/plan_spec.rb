require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Faturando::Plan do

  context 'subscribible' do
    before do
      @subscribible_plan = Factory(:plan, :subscribible => true)
      @non_subscribible_plan = Factory(:plan, :subscribible => false)

      @all = [@subscribible_plan, @non_subscribible_plan]
      FakeWeb.register_uri(:get, "/project/1234/#{test_domain}/plans.xml", :body => @all.to_xml)
    end

    it 'finds only subscribible plans' do
      Faturando::Plan.subscribible.should == [@subscribible_plan]
    end
  end

  it "find a feature value based on handle" do
    plan = Factory(:plan)
    feature = Factory(:feature, handle: 'notas_fiscais')
    plan.feature_values = [
      Faturando::FeatureValue.create(plan: plan, feature: feature, value: 'XXXX')
    ]

    plan.feature_value_by_handle('notas_fiscais').should == plan.feature_values.first
    plan.feature_value_by_handle('non_exising').should == nil
  end

  it "has virtual methods based on feature handles" do
    plan = Factory(:plan)
    feature_notas = Factory(:feature, handle: 'notas_fiscais')
    feature_email = Factory(:feature, handle: 'emails_limit')
    plan.feature_values = [
      Faturando::FeatureValue.create(plan: plan, feature: feature_notas, value: 'XXXX'),
      Faturando::FeatureValue.create(plan: plan, feature: feature_email, value: 'YYYY')
    ]

    plan.notas_fiscais.should == 'XXXX'
    plan.emails_limit.should == 'YYYY'

    expect {
      plan.notas_fiscais_limit
    }.to raise_error(NoMethodError)
  end

  it "has virtual methods to discover if a feature is unlimited" do
    plan = Factory(:plan)
    feature_notas = Factory(:feature, handle: 'notas_fiscais')
    feature_email = Factory(:feature, handle: 'emails_limit')
    plan.feature_values = [
      Faturando::FeatureValue.create(plan: plan, feature: feature_notas, value: 'XXXX', unlimited: true),
      Faturando::FeatureValue.create(plan: plan, feature: feature_email, value: 'YYYY', unlimited: false)
    ]

    plan.unlimited_notas_fiscais?.should be_true
    plan.unlimited_emails_limit?.should be_false

    plan.unlimited_notas_fiscais_test? be_nil
  end
end
