RSpec.describe Hyper::Core::Service::Client do
  subject { Class.new { include Hyper::Core::Service::Client }.new }

  let(:endpoint) { 'foos' }
  let(:args) { ['verify'] }
  let(:kwargs) { {} }
  let(:dispatcher) { Hyper::Core::Service::Dispatcher.new(request_method, endpoint, *args, kwargs) }

  before do
    allow(dispatcher).to receive(:call)
    allow(Hyper::Core::Service::Dispatcher).to receive(:new).and_return(dispatcher)
  end

  describe '#get' do
    let(:request_method) { :get }

    it 'delegates to the dispatcher' do
      subject.get(endpoint)
      expect(dispatcher).to have_received(:call)
    end
  end

  describe '#post' do
    let(:request_method) { :post }

    it 'delegates to the dispatcher' do
      subject.post(endpoint)
      expect(dispatcher).to have_received(:call)
    end
  end
end
