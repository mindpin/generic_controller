require "action_controller"
require "action_controller/test_case"
require "active_model"
require "generic_controller"
require "rspec"
require "pry"

class DummyModel
  include ActiveModel::Model
  extend ActiveModel::Naming

  attr_accessor :attr1, :attr2
  attr_reader :destroyed, :updated

  def self.find(id)
    @instance ||= DummyModel.new
  end

  def update_attributes(parameters)
    @updated = parameters
  end

  def attributes=(parameters)
    @updated = parameters
  end

  def save
    true
  end

  def destroy
    @destroyed = true
  end

  def id
    1234
  end
end

class DummyController < ActionController::Base
  include GenericController

  set_model DummyModel, :allow_attrs => [:attr1, :attr2]

  destroy_with {}

  extra_params = {
    :sf => proc {obj.split(" ")}
  }
  
  update_with(extra_params) {}

  def obj
    "a string"
  end

  def _instance
    model_instance
  end
end
