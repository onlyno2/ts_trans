# frozen_string_literal: true

RSpec.describe TsTrans do
  it 'has a version number' do
    expect(TsTrans::VERSION).not_to be nil
  end

  it 'generate schema file' do
    path = described_class.configuration.output
    File.delete(path) if File.exist?(path)

    described_class.generate
    assert File.exist?(path)
  end
end
