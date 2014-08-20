# Stolen from http://stackoverflow.com/a/3212565/2540643
module Rake
  module Notes
    class ExitWithCode
      def initialize(code)
        @code = code
      end

      def matches?(event_proc)
        @event_proc = event_proc
        return false unless event_proc.respond_to?(:call)
        raise_block_syntax_error if block_given?

        begin
          event_proc.call
        rescue SystemExit => e
          @actual = e.status
        end
        @actual && (@actual == @code)
      end

      def supports_block_expectations?
        true
      end

      def failure_message
        "expected block to call exit(#{@code}) but exit" +
            (@actual.nil? ? ' not called' : "(#{@actual}) was called")
      end

      def failure_message_when_negated
        "expected block not to call exit(#{@code})"
      end

      def description
        "expect block to call exit(#{@code})"
      end
    end

    module CustomMatchers
      def exit_with_code(code)
        ExitWithCode.new(code)
      end
    end
  end
end
