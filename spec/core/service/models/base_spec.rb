RSpec.describe Hyper::Core::Service::Base do
  context 'class attributes and methods' do
    subject { described_class }
    it { is_expected.to respond_to(:resource_url, :scope, :all, :find, :where, :build) }
  end
end
