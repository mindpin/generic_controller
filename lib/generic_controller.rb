require "generic_controller/version"
require "active_support/concern"

module GenericController
  extend ActiveSupport::Concern

  included do
    before_action :find_model_instance,
                  :only => [:update, :show, :destroy, :edit]

    before_action :new_model_instance,
                  :only => [:new]

    delegate :model, :allow_attrs, :to => :class
  end

  def new
  end

  def show
  end

  def edit
  end

  protected

  def find_model_instance
    instance_variable_set model_ivar, model.find(params[:id])
  end

  def new_model_instance
    instance_variable_set model_ivar, model.new
  end

  def model_instance
    instance_variable_get model_ivar
  end

  def model_ivar
    model && "@#{model.model_name.element}"
  end

  def model_params
    params.require(model.model_name.element).permit(*allow_attrs)
  end

  module ClassMethods
    def show_with(&block)
      define_method :show do
        instance_eval &block
      end
    end

    def edit_with(&block)
      define_method :edit do
        instance_eval &block
      end
    end

    def update_with(&block)
      define_method :update do
        model_instance.update_attributes model_params
        model_instance.save
        instance_eval &block
      end
    end

    def destroy_with(&block)
      define_method :destroy do
        model_instance.destroy
        instance_eval &block
      end
    end

    def set_model(klass, allow_attrs: [])
      @_model = klass
      @_allow_attrs = allow_attrs
    end

    def model
      @_model
    end

    def allow_attrs
      @_allow_attrs
    end
  end
end
