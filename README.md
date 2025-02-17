For when I don't to include a whole testing framework just to test some Ruby code.

### Usage

git clone git@github.com:eddorre/ruby_tools.git ~/.ruby_tools

In your Ruby code:

```ruby
require '~/.ruby_tools/simple_spec.rb'
include Eddorre::SimpleSpec

# Note that describe can be used instead of test (just in case I got RSpec on the brain)

### Running the test on the library
ruby '~/.ruby_tools/spec.rb'

### Checking for equality
test 'it should return two' do
  expect(1 + 1).to eq(2)
end

### Checking for truthiness
test 'it should return true' do
  expect { 1 + 1 == 2 }.to be_truthy
end

### Check for falsey-ness
test 'it should return true' do
  expect { 1 + 2 == 3 }.to be_falsey
end

### Skip a test, the expectation won't be evaluated and a message that the test is skipped is output
xtest 'it should be skipped' do
  expect(1 + 1).to eq(2)
end
```
