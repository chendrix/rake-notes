# stolen and tweaked from http://robots.thoughtbot.com/test-rake-tasks-like-a-boss

require 'rake'

shared_context 'rake' do
  let(:rake)      { Rake::Application.new }
  let(:task_name) { self.class.top_level_description.split(' ').last }
  let(:task_lib_path) { 'rake/notes/rake_task' }
  let(:task_path) { File.join(LIB_PATH, "#{task_lib_path}.rb") }
  subject         { rake[task_name] }

  before do
    Rake.application = rake
    load task_path
  end
end
