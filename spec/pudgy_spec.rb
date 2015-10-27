require 'spec_helper'
require 'json'

describe Pudgy do
  it 'has a version number' do
    expect(Pudgy::VERSION).not_to be nil
  end

  describe 'consuming an API' do
    describe '.consume' do
      subject { described_class.consume resource, parser: parser }

      context 'from String' do
        let(:parser)   { JSON }
        let(:resource) {
          '{ "object": { "foo": "bar" } }'
        }
        let(:parsed_resource) {
          {'object' => { 'foo' => 'bar' }}
        }

        it { is_expected.to eq parsed_resource }
      end
    end
  end
end
