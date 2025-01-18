require_relative 'simple_spec'

include Eddorre::SimpleSpec
using Eddorre::TerminalColors

# Test the test method
test 'testing test method' do
  puts 'pass'.upcase.green
end

# Test the describe method
test 'testing describe method' do
  puts 'pass'.upcase.green
end

# Test the eq matcher with a value
test 'testing eq matcher' do
  expect(1).to eq(1)
end

# Test the eq matcher with a block
test 'testing eq matcher with block' do
  expect { 1 + 1 }.to eq(2)
end

# Test the eq matcher with not_to
test 'testing eq matcher with not_to' do
  expect(1).not_to eq(2)
end

# Test the truthy matcher
test 'testing truthy matcher' do
  expect(1).to be_truthy
end

# Test the truthy matcher with a boolean
test 'testing truthy matcher with boolean' do
  expect(true).to be_truthy
end

# Test the truthy matcher with a block
test 'testing truthy matcher with block' do
  expect { 1 + 1 == 2 }.to be_truthy
end

# Test a failing test
test 'this test should fail' do
  expect(1).to eq(2)
end
