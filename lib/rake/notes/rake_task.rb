require 'rake'
require 'rake/tasklib'

require 'rake/notes/source_annotation_extractor'

module Rake
  module Notes
    class RakeTask < ::Rake::TaskLib
      include ::Rake::DSL if defined?(::Rake::DSL)

      def initialize(*args)
        yield self if block_given?

        desc "Enumerate all annotations (use notes:optimize, :fixme, :todo for focus)"
        task :notes do
          ["OPTIMIZE", "TODO"].each do |annotation|
            SourceAnnotationExtractor.enumerate annotation, tag: true
          end
          ["FIXME"].each do |annotation|
            SourceAnnotationExtractor.enumerate annotation, tag: true, fail_on_exit: true
          end
        end

        namespace :notes do
          ["OPTIMIZE", "TODO"].each do |annotation|
            desc "Enumerate all #{annotation} annotations"
            task annotation.downcase.intern do
              SourceAnnotationExtractor.enumerate annotation
            end
          end

          ["FIXME"].each do |annotation|
            desc "Enumerate all #{annotation} annotations"
            task annotation.downcase.intern do
              SourceAnnotationExtractor.enumerate annotation, fail_on_exit: true
            end
          end

          desc "Enumerate a custom annotation, specify with ANNOTATION=CUSTOM"
          task :custom do
            SourceAnnotationExtractor.enumerate ENV['ANNOTATION']
          end
        end
      end
    end
  end
end

Rake::Notes::RakeTask.new
