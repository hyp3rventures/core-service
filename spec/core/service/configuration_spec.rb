RSpec.describe Hyper::Core::Service::Configuration do
  it do
    is_expected.to respond_to(
      :email,
      :email=,
      :host,
      :host=,
      :prefix,
      :prefix=,
      :organization_id,
      :organization_id=,
      :product,
      :product=,
      :token,
      :token=,
      :version,
      :version=
    )
  end

  describe '#base_url' do
    context 'with default values' do
      subject { described_class.new.base_url }

      it { is_expected.to eq('https://app.hyp3r.co/api/v3') }
    end

    context 'with configuration changes' do
      let(:config) { described_class.new }

      it 'supports http configuration' do
        config.protocol = 'http'
        expect(config.base_url).to eq('http://app.hyp3r.co/api/v3')
      end

      it 'supports host configuration' do
        config.protocol = 'http'
        config.host = 'localhost:3001'
        expect(config.base_url).to eq('http://localhost:3001/api/v3')
      end

      it 'supports prefix configuration' do
        config.prefix = 'appi'
        expect(config.base_url).to eq('https://app.hyp3r.co/appi/v3')
      end

      it 'supports version configuration' do
        config.version = '8'
        expect(config.base_url).to eq('https://app.hyp3r.co/api/v8')
      end
    end

    context 'with versioned_base_url param' do
      let(:config) { described_class.new }

      it 'return api url default as versioned' do
        config.version = '7'

        expect(config.base_url).to eq('https://app.hyp3r.co/api/v7')
      end

      it 'return api url with versioned_base_url = true' do
        config.version = '8'

        expect(config.base_url(true)).to eq('https://app.hyp3r.co/api/v8')
      end

      it 'return api url with versioned_base_url = false' do
        config.version = '9'

        expect(config.base_url(false)).to eq('https://app.hyp3r.co/api')
      end
    end
  end
end
