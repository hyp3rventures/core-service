RSpec.describe Hyper::Core::Service do
  subject { described_class }

  describe '.configuration' do
    it 'returns a configuration object' do
      expect(subject.configuration).to be_a(Hyper::Core::Service::Configuration)
    end
  end

  describe '.configure' do
    it 'takes a block' do
      expect { |b| subject.configure(&b) }.to yield_control
    end

    it 'fails without a block' do
      expect { subject.configure }.to raise_error(LocalJumpError)
    end
  end

  describe '#connection' do
    context 'given no block' do
      it 'returns a Faraday connection object set to the configuration values' do
        result = subject.connection
        expect(result).to be_a(Faraday::Connection)
        expect(result.headers).to include('X-Entity-Email' => 'user@example.com') # from spec_helper.rb
      end
    end

    context 'given a block' do
      let(:block) do
        Proc.new do |f|
          f.headers['yes'] = 'no'
          f.adapter :net_http_persistent
        end
      end

      it 'returns a Faraday connection object set to the block values' do
        result = subject.connection(&block)
        expect(result).to be_a(Faraday::Connection)
        expect(result.headers).to include('yes' => 'no')
        expect(result.builder.handlers).to include(Faraday::Adapter::NetHttpPersistent)
      end
    end
  end
end
