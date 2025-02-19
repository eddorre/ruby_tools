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
        test_match(matcher.matches?(expectation), matcher, expectation)
      end

      def not_to(matcher)
        raise ArgumentError, 'Not a matcher' unless matcher.respond_to?(:matches?)
        test_match(!matcher.matches?(expectation), matcher, expectation)
      end

      private

      def test_match(condition, matcher, actual)
        if condition
          puts 'Pass'.upcase.green
        else
          puts 'Fail'.upcase.red + " - #{failure_message(matcher, actual)}"
        end
      end

      def failure_message(matcher, actual)
        expected = matcher.instance_variable_get(:@expected) rescue nil
        return matcher.failure_message(expected, actual) if matcher.respond_to?(:failure_message)

        "Expected #{expected.inspect} but got: #{actual}"
      end
    end

    def describe(label, &block)
      puts "Running spec: #{label}"
      yield if block_given?
    end

    def xdescribe(label, &block)
      puts "Skipping spec: #{label}".yellow
    end

    alias test describe
    alias xtest xdescribe

    class TruthyMatcher
      def matches?(target)
        !!target
      end

      def failure_message(_expected, actual)
        "Expected #{actual} to be truthy, but it was falsey"
      end
    end

    class FalseyMatcher
      def matches?(target)
        !target
      end

      def failure_message(_expected, actual)
        "Expected #{actual} to be falsey, but it was truthy"
      end
    end

    class EqualityMatcher
      attr_reader :expected

      def initialize(expected)
        @expected = expected
      end

      def matches?(target)
        target == @expected
      end

      def failure_message(expected, actual)
        "Expected #{actual} to be equal to #{expected}"
      end
    end

    class NilMatcher
      def matches?(target)
        target.nil?
      end

      def failure_message(_expected, actual)
        "Expected #{actual} to be nil, but it was not"
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

    def be_falsey
      FalseyMatcher.new
    end

    def be_nil
      NilMatcher.new
    end
  end
end
