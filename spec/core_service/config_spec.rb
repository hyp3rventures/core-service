RSpec.describe Hyper::CoreService::Config do
  it { is_expected.to respond_to(:base, :path, :url) }

  describe 'default values' do
    describe '#base' do
      it "equals 'https://app.hyp3r.co'" do
        expect(subject.base).to eq('https://app.hyp3r.co')
      end
    end

    describe '#path' do
      it "equals '/api/v2/authentications/verify'" do
        expect(subject.path).to eq('/api/v2/authentications/verify')
      end
    end

    describe '#url' do
      it "equals 'https://app.hyp3r.co/api/v2/authentications/verify'" do
        expect(subject.url).to eq('https://app.hyp3r.co/api/v2/authentications/verify')
      end
    end
  end

  describe 'user-supplied values' do
    describe '#url' do
      context 'with different base' do
        it 'substitutes the base' do
          subject.base = 'https://empire.com'
          expect(subject.url).to eq('https://empire.com/api/v2/authentications/verify')
        end
      end

      context 'with different path' do
        it 'substitutes the path' do
          subject.path = '/orders/66/execute'
          expect(subject.url).to eq('https://app.hyp3r.co/orders/66/execute')
        end
      end

      context 'with different base & path' do
        it 'substitutes the entire url' do
          subject.base = 'https://empire.com'
          subject.path = '/orders/66/execute'
          expect(subject.url).to eq('https://empire.com/orders/66/execute')
        end
      end
    end
  end
end
