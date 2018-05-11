RSpec.describe Hyper::Core::Service::Company do
  context 'class attributes' do
    describe '.resource_url' do
      subject { described_class.resource_url }
      it { is_expected.to eq('companies') }
    end
  end
end
