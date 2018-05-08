RSpec.describe Hyper::Core::Service::User do
  context 'class attributes' do
    describe '.resource_url' do
      subject { described_class.resource_url }
      it { is_expected.to eq('users') }
    end
  end
end
