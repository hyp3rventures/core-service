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
      :version=,
    )
  end

  describe '#base_url' do
    context 'with default values' do
      subject { described_class.new.base_url }

      it { is_expected.to eq('https://app.hyp3r.co/api/v3') }
    end
  end
end
