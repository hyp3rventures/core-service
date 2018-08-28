RSpec.describe Hyper::Core::Service::Serializer do
  let(:blob) { '{}' }
  let(:endpoint) { 'foos' }
  subject { described_class.new(blob, endpoint) }

  describe '#run' do
    context 'given an empty json string response object' do
      it 'returns a hash' do
        expect(subject.run).to eq({})
      end
    end

    context 'given a full json string response object' # TODO
  end

  describe '#parsed' do
    let(:object) { '{"foo":"bar"}' }

    it 'returns a hash with symbol keys' do
      expect(subject.parsed(object)[:foo]).to eq('bar')
    end
  end

  describe '#make_indifferent' do
    context 'given an array argument' do
      let(:object) { [{ 'foo' => 'bar' }, { 'baz' => 'quux' }] }

      it 'transforms each value to a HashWithIndifferentAccess' do
        expect(subject.make_indifferent(object)).to all(satisfy { |o| o.is_a?(ActiveSupport::HashWithIndifferentAccess) })
      end
    end

    context 'given a hash argument' do
      let(:object) { { 'foo' => 'bar' } }

      it 'transforms each value to a HashWithIndifferentAccess' do
        expect(subject.make_indifferent(object)).to be_a(ActiveSupport::HashWithIndifferentAccess)
      end
    end
  end

  describe '#get_root' do
    context 'given a singular resource response' do
      let(:object) { ActiveSupport::HashWithIndifferentAccess.new(foo: { yes: 'also yes' }) }

      it 'returns the actual root object' do
        expect(subject.get_root(object)).to eq(object['foo'])
      end
    end

    context 'given a collection resource response' do
      let(:collection) { [{ id: 1, baw: 'wit' }, { id: 2, da: 'bah' }, { id: 3, da: 'bang' }, { id: 4, da: 'bang' }, { id: 5, diggy: 'diggy' }] }
      let(:object) { collection.map { |item| ActiveSupport::HashWithIndifferentAccess.new(item) } }

      it 'returns an array of objects' do
        expect(subject.get_root(object)).to be_a(Array)
        expect(subject.get_root(object).first).to eq(object.first)
      end
    end

    context 'given a collection response with a "meta" key' do
      let(:object) { ActiveSupport::HashWithIndifferentAccess.new(meta: 'yes', foos: { yes: 'also yes' }) }

      it 'returns that hash without the "meta" key' do
        expect(subject.get_root(object)).to eq(object['foos'])
      end
    end
  end
end
