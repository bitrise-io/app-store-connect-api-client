# frozen_string_literal: true

RSpec.describe AppStoreConnectApi::Utils::HashUtils do
  describe '.deep_transform_keys' do
    subject(:deep_transform_keys) { described_class.deep_transform_keys object, &transformation }

    let(:object) do
      {
        k1: 'test',
        k2: {
          k3: 'data',
          k4: {
            'k5' => 'string'
          }
        }
      }
    end
    let(:transformation) { proc { |key| "#{key}_transformed" } }

    it "transforms a hash's keys with the specified Proc" do
      expect(deep_transform_keys).to eq 'k1_transformed' => 'test',
                                        'k2_transformed' => {
                                          'k3_transformed' => 'data',
                                          'k4_transformed' => {
                                            'k5_transformed' => 'string'
                                          }
                                        }
    end

    context 'when the object contains an array' do
      let(:object) { [{ k1: 'test' }, { k2: 'data' }] }

      it 'digs down into arrays as well' do
        expect(deep_transform_keys).to eq [{ 'k1_transformed' => 'test' }, { 'k2_transformed' => 'data' }]
      end
    end

    context 'when the object is not a Hash' do
      let(:object) { 'unchanged' }

      it 'returns the object unchanged' do
        expect(deep_transform_keys).to eq 'unchanged'
      end
    end
  end
end
