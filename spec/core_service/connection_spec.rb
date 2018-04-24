RSpec.describe Hyper::CoreService::Connection do
  describe '.new' do
    let(:url) { 'https://example.com' }
    subject { described_class.new(url) }

    it { is_expected.to be_a(Faraday::Connection) }
  end
end
