require "spec_helper"

describe GenericController do
  let(:controller)   {DummyController.new}
  let(:request_url)  {"/foo?id=1234&dummy_model[attr1]=attr1&dummy_model[attr2]=attr2"}
  let(:rack_request) {Rack::MockRequest.env_for(request_url)}
  let(:request)      {ActionController::TestRequest.new(rack_request)}

  subject {controller}

  before(:each) {controller.request = request}

  it "defines actions" do
    controller.should respond_to :update
    controller.should respond_to :destroy
  end

  its(:model)        {should be DummyModel}
  its(:allow_attrs)  {should eq [:attr1, :attr2]}
  its(:require_name) {should eq "dummy_model"}

  it "updates model from request" do
    controller.send :find_model_instance
    controller.update
    controller._instance.updated.should eq "attr1" => "attr1", "attr2" => "attr2"
  end

  it "deletes model from request" do
    controller.send :find_model_instance
    controller.destroy
    controller._instance.destroyed.should be true
  end
end
