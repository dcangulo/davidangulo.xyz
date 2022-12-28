---
categories: ['General Programming']
tags: ['Ruby', 'Testing', 'RSpec']
title: 'Test Doubles Stubbing & Mocking'
---
## What are test doubles?
Test doubles are a substitute for production apps used for testing purposes. There are at least five (5) types of test doubles according to Gerard Meszaros but we are going to focus on two (2) which are **stubbing** and **mocking**.

## The difference between stubbing & mocking
### Stubbing
* Doesn’t fail.
* Makes sure that the method returns the correct value.
* Returns hard-coded values.
* Answers the question ‘What is the result?’.

### Mocking
* Can fail.
* Runs the actual method and making sure everything is correct before returning the correct value.
* Returns calculated values.
* Answers the question ‘How the result has been achieved?’.

## Why use stubbing & mocking?
* To prevent tests failing intermittently due to connectivity issues.
* For faster test suites.
* To avoid hitting API limits when using 3rd party APIs.
* To prevent creating/updating/deleting real data from tests.

### Real life example
<blockquote>
Imagine your kid has a glass plate and he starts playing with it. Now, you’re afraid that it will break, so you gave him a plastic plate instead. The plastic plate is mocking the glass plate. (same behavior and usage).
<br />
<br />
Now, say you don’t have a plastic replacement, so you can say to your kid “If you continue playing with it, it will break!”. The quoted words are a stub. (you predefined the outcome in advance).
<br />
<br />
Source: https://stackoverflow.com/a/53189007/9375533
</blockquote>

## Code example
Imagine that we have a simple calculator app that uses 3rd party API, in this case, our 3rd party API is [math.js](https://api.mathjs.org/).

The thing is, we don’t want to make a request to math.js’s endpoint every time we ran our tests as this will make our tests slow since we need to wait for the response before we can proceed to the next test suite.

The tests can also fail if we don’t have an internet connection and we also might hit the API limit of their free service.

### Without stubbing & mocking
```ruby
result = '3*3' # EXAMPLE 1
result = '4*4' # EXAMPLE 2
uri = URI "https://api.mathjs.org/v4/?expr=#{result}"
expect(Net::HTTP.get(uri)).to eq(9)
# EXAMPLE 1 RETURNS 9 (SUCCESS)
# EXAMPLE 2 RETURNS 16 (FAILS)
```

### With stubbing
```ruby
result = '3*3' # EXAMPLE 1
result = '4*4' # EXAMPLE 2
stub_request(:get, "https://api.mathjs.org/v4/?expr=#{result}").to_return :body => "9"
uri = URI "https://api.mathjs.org/v4/?expr=#{result}"
expect(Net::HTTP.get(uri)).to eq(9)
# EXAMPLE 1 RETURNS 9 (SUCCESS)
# EXAMPLE 2 RETURNS 9 (SUCCESS)
```

What we did here is, we basically stubbed some data to the endpoint that we are going to call for our test.

In this case, we stubbed data to the endpoint with a body of 9. Which means, whenever we call the endpoint that we stubbed it will always return 9.

### With mocking
```ruby
result = '3*3' # EXAMPLE 1
result = '4*4' # EXAMPLE 2
expect(eval(result)).to eq(9)
# EXAMPLE 1 RETURNS 9 (SUCCESS)
# EXAMPLE 2 RETURNS 16 (FAILS)ß
```

We know that the endpoint simply calculates the expression params then return its result. Now we can mock it ourselves. `eval(result)` is the mock of the API endpoint as it returns the same output exclusively for our test suites.

That’s what I can share about stubbing & mocking. I hope you learned something. Using a test double type really depends on your needs. In my case, I use both stubbing & mocking at the same time.
