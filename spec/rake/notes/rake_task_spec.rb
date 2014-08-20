require 'spec_helper'
require_relative '../../support/rake_examples'

describe 'rake notes' do
  include_context 'rake'

  before do
    allow(Rake::Notes::SourceAnnotationExtractor).to receive(:enumerate)
  end

  it 'extracts source annotations for TODO with tag: true' do
    expect(Rake::Notes::SourceAnnotationExtractor).to receive(:enumerate).with('TODO', tag: true)
    subject.invoke
  end

  it 'extracts source annotations for OPTIMIZE with tag: true' do
    expect(Rake::Notes::SourceAnnotationExtractor).to receive(:enumerate).with('OPTIMIZE', tag: true)
    subject.invoke
  end

  it 'extracts source annotations for FIXME with tag: true and fail_on_exit: true' do
    expect(Rake::Notes::SourceAnnotationExtractor).to receive(:enumerate)
                                                      .with('FIXME', tag: true, fail_on_exit: true)
    subject.invoke
  end
end

describe 'rake notes:todo' do
  include_context 'rake'

  before do
    allow(Rake::Notes::SourceAnnotationExtractor).to receive(:enumerate)
  end

  it 'extracts source annotations for TODO without tag: true' do
    expect(Rake::Notes::SourceAnnotationExtractor).to receive(:enumerate).with('TODO')
    subject.invoke
  end
end

describe 'rake notes:optimize' do
  include_context 'rake'

  before do
    allow(Rake::Notes::SourceAnnotationExtractor).to receive(:enumerate)
  end

  it 'extracts source annotations for OPTIMIZE without tag: true' do
    expect(Rake::Notes::SourceAnnotationExtractor).to receive(:enumerate).with('OPTIMIZE')
    subject.invoke
  end
end

describe 'rake notes:fixme' do
  include_context 'rake'

  before do
    allow(Rake::Notes::SourceAnnotationExtractor).to receive(:enumerate)
  end

  it 'extracts source annotations for OPTIMIZE without tag: true and with fail_on_exit: true' do
    expect(Rake::Notes::SourceAnnotationExtractor).to receive(:enumerate).with('FIXME', fail_on_exit: true)
    subject.invoke
  end
end

describe 'rake notes:custom' do
  include_context 'rake'

  before do
    allow(Rake::Notes::SourceAnnotationExtractor).to receive(:enumerate)
  end

  it "extracts source annotations for what's in ENV['ANNOTATION'] without tag: true" do
    ENV['ANNOTATION'] = 'this_does_not_matter'

    expect(Rake::Notes::SourceAnnotationExtractor).to receive(:enumerate).with('this_does_not_matter')
    subject.invoke
  end
end
