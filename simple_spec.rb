require_relative 'terminal_colors'

using Eddorre::TerminalColors

module Eddorre
  module SimpleSpec
    class ExpectationTarget
      def initialize(expectation)
        @expectation = expectation 
      end

      def expectation
        @expectation.respond_to?(:call) ? @expectation.call : @expectation
      end

      def to(matcher)
        raise ArgumentError, 'Not a matcher' unless matcher.respond_to?(:matches?)
        test_match(matcher.matches?(expectation))
      end

      def not_to(matcher)
        raise ArgumentError, 'Not a matcher' unless matcher.respond_to?(:matches?)
        test_match(!matcher.matches?(expectation))
      end

      private

      def test_match(condition)
        if condition
          puts 'Pass'.upcase.green
        else
          puts 'Fail'.downcase.red
        end
      end
    end

    def describe(label, &block)
      puts "Running test: #{label}"
      yield if block_given?
    end

    alias test describe

    class TruthyMatcher
      def matches?(target)
        !!target
      end
    end

    class EqualityMatcher
      def initialize(expected)
        @expected = expected
      end

      def matches?(target)
        target == @expected
      end
    end

    def eq(expected)
      EqualityMatcher.new(expected)
    end

    def expect(target = nil, &block)
      ExpectationTarget.new(target || block)
    end

    def be_truthy
      TruthyMatcher.new
    end
  end
end
