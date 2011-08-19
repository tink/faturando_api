begin
  require 'active_resource'
rescue LoadError
  begin
    require 'rubygems'
    require 'active_resource'
  rescue LoadError
    abort <<-ERROR
The 'activeresource' library could not be loaded. If you have RubyGems
installed you can install ActiveResource by doing "gem install activeresource".
ERROR
  end
end


# Version check
module Faturando
  MIN_VERSION = '2.3.4'
end
require 'active_resource/version'
unless Gem::Version.new(ActiveResource::VERSION::STRING) >= Gem::Version.new(Faturando::MIN_VERSION)
  abort <<-ERROR
    ActiveResource version #{Faturando::MIN_VERSION} or greater is required.
  ERROR
end

# Patch ActiveResource version 2.3.4
if ActiveResource::VERSION::STRING == '2.3.4'
  module ActiveResource
    class Base
      def save
        save_without_validation
        true
      rescue ResourceInvalid => error
        case error.response['Content-Type']
        when /application\/xml/
          errors.from_xml(error.response.body)
        when /application\/json/
          errors.from_json(error.response.body)
        end
        false
      end
    end
  end
end

module Faturando
  class << self
    attr_accessor :project_key, :api_key, :site, :format, :timeout

    def configure
      yield self

      Base.user      = api_key
      Base.password  = 'X'
      Base.timeout   = timeout unless (timeout.blank?)

      self.site ||= "https://faturan.do/"

      base_path = site + "/projects/#{project_key}"
      Base.site = base_path
      FeatureValue.site = base_path + "/plans/:plan_id"
    end
  end

  class Base < ActiveResource::Base
    self.format = :xml

    def self.element_name
      name.split(/::/).last.underscore
    end

    def to_xml(options = {})
      options.merge!(:dasherize => false)
      super
    end
  end

  class Feature < Base
  end

  class FeatureValue < Base
  end

  class Plan < Base
    def self.subscribible
      self.all.select(&:subscribible)
    end

    def feature_value_by_handle(handle)
      found = feature_values.select do |feature_value|
        feature_value.feature.handle == handle
      end
      found.first
    end

    def method_missing(method, *args, &block)
      if method.to_s.match(/^unlimited_(.+)\?$/)
        feature_value = feature_value_by_handle($1)
        if feature_value
          return feature_value.unlimited
        end
      end

      begin
        super
      rescue NoMethodError => e
        feature_value = feature_value_by_handle(method.to_s)
        if feature_value
          return feature_value.value
        end
        raise(e)
      end
    end
  end
end
