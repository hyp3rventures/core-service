RSpec.describe Hyper::Core::Service::Client do
  subject { Class.new { include Hyper::Core::Service::Client }.new }

  let(:stub_dispatcher) { double('Dispatcher', call: {}) }

  before do
    allow(Hyper::Core::Service::Dispatcher).to receive(:new).and_return(stub_dispatcher)
  end

  describe '#get' do
    it 'delegates to the dispatcher' do
      subject.get('foos')
      expect(stub_dispatcher).to have_received(:call)
    end
  end

  describe '#post' do
    it 'delegates to the dispatcher' do
      subject.post('foos')
      expect(stub_dispatcher).to have_received(:call)
    end
  end
end
