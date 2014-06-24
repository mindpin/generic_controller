require "generic_controller/version"
require "active_support/concern"

module GenericController
  extend ActiveSupport::Concern

  included do
    before_action :find_model_instance,
                  :only => [:update, :show, :destroy, :edit]

    before_action :new_model_instance,
                  :only => [:new]

    delegate :model, :allow_attrs, :require_name, :to => :class
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
    params.require(require_name).permit(*allow_attrs)
  end

  module ClassMethods
    def show_with(&block)
      with_callback :show, block
    end

    def edit_with(&block)
      with_callback :edit, block
    end

    def update_with(&block)
      with_callback :update, block do
        model_instance.update_attributes model_params
        model_instance.save
      end
    end

    def destroy_with(&block)
      with_callback :destroy, block do
        model_instance.destroy
      end
    end

    def set_model(klass, allow_attrs: [], require_name: nil)
      @_model = klass
      @_allow_attrs = allow_attrs
      @_require_name = require_name || model.model_name.element
    end

    def require_name
      @_require_name
    end

    def model
      @_model
    end

    def allow_attrs
      @_allow_attrs
    end

    def with_callback(action, callback, &block)
      method_name = "__#{action}_callback__"

      define_method method_name, &callback

      define_method action do
        instance_eval &block if block
        send method_name
      end
    end
  end
end
