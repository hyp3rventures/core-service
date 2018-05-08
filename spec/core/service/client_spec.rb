RSpec.describe Hyper::Core::Service::Client do
  subject { Class.new { include Hyper::Core::Service::Client }.new }

  before do
    Hyper::Core::Service.configure do |config|
      config.email = 'user@example.com'
      config.token = 'abcd1234'
      config.organization_id = 3
      config.host = 'www.example.com'
    end
  end

  it { is_expected.to respond_to(:connection, :request, :get, :post, :parse, :handle_errors) }

  describe '#connection' do
    it 'returns a Faraday connection object' do
      expect(subject.connection).to be_a(Faraday::Connection)
    end
  end

  describe '#request' do
    # do something here
  end

  describe '#get' do
    # do something here
  end

  describe '#post' do
    # do something here
  end

  describe '#parse' do
    let(:response) { OpenStruct.new(body: '{}', status: 200) }

    it 'returns a hash' do
      expect(subject.parse(response)).to eq({})
    end
  end


  describe '#handle_errors' do
    let(:response) { OpenStruct.new(body: '{}', status: status) }

    context 'given 200 status' do
      let(:status) { 200 }
      it 'returns nil' do
        expect(subject.handle_errors(response)).to be_nil
      end
    end

    context 'given 404 status' do
      let(:status) { 404 }
      it 'raises NotFound' do
        expect { subject.handle_errors(response) }.to raise_error(Hyper::Core::Service::NotFoundError)
      end
    end

    context 'given 4xx status' do
      let(:status) { 400 }
      it 'raises Error' do
        expect { subject.handle_errors(response) }.to raise_error(Hyper::Core::Service::Error)
      end
    end

    context 'given 5xx status' do
      let(:status) { 500 }
      it 'raises InternalServerError' do
        expect { subject.handle_errors(response) }.to raise_error(Hyper::Core::Service::InternalServerError)
      end
    end
  end
end
