require_relative 'simple_spec'

include Eddorre::SimpleSpec
using Eddorre::TerminalColors

# Test the test method
test 'testing test method' do
  puts 'pass'.upcase.green
end

# Test the describe method
describe 'testing describe method' do
  puts 'pass'.upcase.green
end

# Test the xdescribe method
xdescribe 'testing xdescribe method' do
  puts 'skipped'.upcase.yellow
end

# Test the xtest method
xtest 'testing xtest method' do
  puts 'skipped'.upcase.yellow
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

# Test the falsey matcher
test 'testing falsey matcher with a boolean' do
  expect(false).to be_falsey
end

# Test the falsety matcher with a block
test 'testing falsey matcher with block' do
  expect { 1 + 1 == 3 }.to be_falsey
end

# Test the nil matcher
test 'testing nil matcher' do
  expect(nil).to be_nil
end

# Test the nil matcher with not_to
test 'testing nil matcher with not_to' do
  expect(1).not_to be_nil
end

# Test a failing test
test 'this test should fail' do
  expect(1).to eq(2)
end
