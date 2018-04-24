RSpec.describe Hyper::CoreService::Request do
  let(:user) { { :id => 1, :email => 'user@example.com', :authentication_token => '1234abcd' } }
  let(:headers) { { 'X-Entity-Token' => user[:authentication_token], 'X-Entity-Email' => user[:email] } }
  let(:config) { Hyper::CoreService::Config.new }
  let(:connection) { Hyper::CoreService::Connection.new(config.base) }
  let(:status) { { status: 200, body: user.to_json } }

  subject { described_class.new }

  before do
    allow(connection).to receive(:post).and_call_original
    allow(subject).to receive(:connection).and_return(connection)
    stub_request(:post, config.url)
      .to_return(status)
  end

  describe 'initialization' do
    before do
      allow(subject).to receive(:config).and_return(config)
    end
    context 'with a block' do
      let(:url) { 'http://example.com' }
      let(:config_block) { Proc.new { |c| c.base = url } }

      it 'sets the config base url to the given value' do
        instance = described_class.new(&config_block)
        expect(instance.send(:config).base).to eq(url)
        expect(instance.send(:config).url).to eq("#{url}#{Hyper::CoreService::Config::AUTHENTICATION_PATH}")
      end
    end

    context 'without a block' do
      it 'sets the url base to a default value' do
        instance = described_class.new
        expect(instance.send(:config).base).to eq(Hyper::CoreService::Config::AUTHENTICATION_BASE)
      end
    end
  end

  describe '#run' do
    it { is_expected.to respond_to(:run) }

    context 'with well-formed user object' do
      context 'when successful' do
        let(:result) {
          {
            'email' => user[:email],
            'authentication_token' => user[:authentication_token],
            'id' => user[:id]
          }
        }

        it 'returns a response object' do
          response = subject.run(user)
          expect(connection).to have_received(:post)
          user_response = JSON.parse(response.body)
          expect(user_response).to eq(result)
        end
      end

      context 'when unsuccessful' do
        let(:result) { { 'error' => 'Invalid user or token' } }
        let(:status) { { status: 401, body: result.to_json } }

        it 'raises an UnauthorizedUserError' do
          expect { subject.run(user) }.to raise_error(Hyper::CoreService::UnauthorizedUserError, result['error'])
        end
      end
    end

    context 'without well-formed user object' do
      let(:user) { { :name => 'Anakin Skywalker', :is_jedi_master => false } }

      it 'raises an InvalidUserObjectError' do
        expect { subject.run(user) }.to raise_error(Hyper::CoreService::InvalidUserObjectError)
      end
    end

    context 'with a 500 range response code from external authentication check' do 
      let(:status) { { status: 504 } }

      it 'raises an InternalServerError' do 
        expect { subject.run(user) }.to raise_error(Hyper::CoreService::InternalServerError)
      end
    end
  end
end
