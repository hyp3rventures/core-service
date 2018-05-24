RSpec.describe Hyper::Core::Service::Dispatcher do
  let(:request_method) { :get }
  let(:status) { 200 }
  let(:body) { {} }
  let(:response) { OpenStruct.new(body: body.to_json, status: status) }
  let(:options) { {} }
  let(:endpoint) { 'foos' }

  subject { described_class.new(request_method, endpoint, options) }

  before do
    allow(Hyper::Core::Service.connection).to receive(:get).and_return(response)
  end

  describe '#call' do
    it 'returns self with @result set' do
      expect { subject.call }.to change { subject.result }.from(nil).to({})
      expect(subject.call).to eq(subject)
    end
  end

  describe '#response' do
    it 'returns a response object' do
      expect(subject.response).to eq(response)
    end
  end

  describe '#url' do
    context 'given no path arguments' do
      it 'returns the endpoint' do
        expect(subject.url).to eq(subject.endpoint)
      end
    end

    context 'given path arguments' do
      subject { described_class.new(request_method, endpoint, 'bar', 'baz') }
      it 'returns the endpoint plus those path arguments concatenated with "/"' do
        expect(subject.url).to eq('foos/bar/baz')
      end
    end
  end

  describe '#params' do
    context 'given no options hash' do
      it 'returns a hash with organization_id at minimum' do
        result = { organization_id: 3 }
        expect(subject.params).to eq(result)
      end
    end

    context 'given an options hash' do
      let(:options) { { fromp: 'yz', jonk: 'gom' } }
      it 'returns that hash with organization_id added' do
        result = { organization_id: 3, fromp: 'yz', jonk: 'gom' }
        expect(subject.params).to eq(result)
      end
    end
  end

  describe '#object_key' do
    let(:body) do
      {
        'nerps' => {
          'foo' => 1,
          'bar' => 2
        }
      }
    end

    context 'given an options hash with an object_key key set' do
      let(:options) { { object_key: 'nerps' } }

      it 'sets the value from the object_key key and passes it to the serializer' do
        subject.call
        expect(subject.object_key).to eq('nerps')
        expect(subject.result).to eq(body[subject.object_key])
      end
    end

    context 'given no object_key key set' do
      it 'sets the value to the endpoint' do
        expect(subject.object_key).to eq('foos')
      end
    end
  end

  describe '#handle_errors' do
    context 'given 200 status' do
      # let(:status) { 200 } # at the top of this spec
      it 'returns nil' do
        expect(subject.send(:handle_errors, response)).to be_nil
      end
    end

    context 'given 404 status' do
      let(:status) { 404 }
      it 'raises NotFound' do
        expect { subject.send(:handle_errors, response) }.to raise_error(Hyper::Core::Service::NotFoundError)
      end
    end

    context 'given 4xx status' do
      let(:status) { 400 }
      it 'raises Error' do
        expect { subject.send(:handle_errors, response) }.to raise_error(Hyper::Core::Service::Error)
      end
    end

    context 'given 5xx status' do
      let(:status) { 500 }
      it 'raises InternalServerError' do
        expect { subject.send(:handle_errors, response) }.to raise_error(Hyper::Core::Service::InternalServerError)
      end
    end
  end
end
