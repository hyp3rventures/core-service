RSpec.describe Hyper::Core::Service do
  subject { described_class }

  describe '.configuration' do
    it { is_expected.to respond_to(:configuration) }

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
end
