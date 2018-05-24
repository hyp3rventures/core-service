RSpec.describe Hyper::Core::Service::Base do
  context 'given a subclass' do
    subject { TestObject } # spec/support/test_object.rb

    describe '.where' do
      let(:response) { double('Response', body: body.to_json, status: 200) }

      before do
        allow(Hyper::Core::Service.connection).to receive(:get).and_return(response)
      end

      context 'given a collection response' do
        let(:body) { { 'test_objects' => attributes_for_list(:test_object, 2, grable_id: 1) } }

        it 'returns a list of built objects' do
          expect(subject.where(grable_id: 1)).to all(be_a(TestObject))
        end
      end

      context 'given a resource response' do
        let(:body) { attributes_for(:test_object, grable_id: 1) }

        it 'raises ArgumentError' do
          expect { subject.where(grable_id: 1) }.to raise_error(ArgumentError)
        end
      end
    end

    describe '.find' do
      let(:response) { double('Response', body: body.to_json, status: 200) }

      before do
        allow(Hyper::Core::Service.connection).to receive(:get).and_return(response)
      end

      context 'given a resource response' do
        let(:body) { attributes_for(:test_object, grable_id: 1) }

        it 'returns a built object' do
          expect(subject.find(1)).to eq(TestObject.build(body))
        end
      end

      context 'given a collection response' do
        let(:body) { { 'test_objects' => attributes_for_list(:test_object, 2, grable_id: 1) } }

        it 'raises ArgumentError' do
          expect { subject.find(1) }.to raise_error(ArgumentError)
        end
      end
    end

    describe '.build' do
      let(:blob) { { yes: 1, no: 2, quux: 3 } }

      it 'returns a new object using only the properties defined on the blob' do
        expect { subject.build(blob) }.to_not raise_error
        expect(subject.build(blob)).to eq(TestObject.new(yes: 1, no: 2))
      end
    end

    describe '.build_collection' do
      let(:blobs) do
        [
          { yes: 1, no: 2, quux: 3 },
          { yes: 2, no: 3, quux: 4 }
        ]
      end

      it 'returns a list of objects by passing them to .build' do
        result = subject.build_collection(blobs)
        expect(result).to match_array([TestObject.new(yes: 1, no: 2), TestObject.new(yes: 2, no: 3)])
      end
    end

    describe '.resource_url' do
      subject { Class.new(described_class) }

      before { allow(subject).to receive(:name).and_return('Bar') }

      context 'given no set value' do
        before { subject.resource_url = nil }

        it 'infers resource_url from the class name' do
          expect(subject.resource_url).to eq('bars')
        end
      end

      context 'given a set value' do
        before { subject.resource_url = 'foo' }

        it 'reads the property' do
          expect(subject.resource_url).to eq('foo')
        end
      end
    end

    describe '.resource_scope' do
      subject { Class.new(TestObject) }

      context 'given no set value' do
        it 'receives it from the parent' do
          expect(subject.resource_scope).to eq('grable')
        end
      end

      context 'given a set value' do
        before do
          subject.resource_scope = 'yahoo'
        end

        it 'reads the property and does not change the parent' do
          expect(subject.resource_scope).to eq('yahoo')
          expect(TestObject.resource_scope).to eq('grable')
        end
      end
    end
  end

  context 'given an instance' do
    let(:object) { build(:test_object) }

    subject { object == other }

    describe '#==' do
      context 'when id matches do' do
        let(:other) { build(:test_object, id: object.id) }

        it { is_expected.to be(true) }
      end
    end

    context 'when id does not match' do
      let(:other) { build(:test_object, id: object.id + 1) }

      it { is_expected.to be(false) }
    end
  end
end
