---
categories: ['Meta']
tags: ['CS50', 'Ruby', 'Python']
title: "Doing CS50's Lab 6: World Cup problem in Ruby"
---
Yesterday, I experienced a power outage where I'm left with just a laptop at 50% battery with Ruby interpreter and a mobile phone with limited internet access.

With nothing else to do I tried to do [CS50's Lab 6: World Cup](https://cs50.harvard.edu/x/2023/labs/6/) problem, since I have no Python experience at this time, I instead tried to do it in Ruby.

I connected my laptop to my mobile data just to load the problem's page and to download the zip file.

In the extracted zip file we have the following files:
```text
answers.txt  2018m.csv  2019w.csv  tournament.py
```

## Creating the Ruby file.

What I did:
* Created a file named `tournament.rb`.
* Copied the content `tournament.py` to `tournament.rb`.
* Commented out codes that Ruby can't interpret.
* Rewrite functions to Ruby syntax.

```ruby
# Simulate a sports tournament

# import csv
# import sys
# import random

# Number of simluations to run
N = 1000


def main()

    # Ensure correct usage
    # if len(sys.argv) != 2:
    #     sys.exit("Usage: python tournament.py FILENAME")

    teams = []
    # TODO: Read teams into memory from file

    counts = {}
    # TODO: Simulate N tournaments and keep track of win counts

    # Print each team's chances of winning, according to simulation
    # for team in sorted(counts, key=lambda team: counts[team], reverse=True):
    #     print(f"{team}: {counts[team] * 100 / N:.1f}% chance of winning")
end


def simulate_game(team1, team2)
    """Simulate a game. Return True if team1 wins, False otherwise."""
    rating1 = team1["rating"]
    rating2 = team2["rating"]
    probability = 1 / (1 + 10 ** ((rating2 - rating1) / 600))
    # return random.random() < probability
end


def simulate_round(teams)
    """Simulate a round. Return a list of winning teams."""
    winners = []

    # Simulate games for all pairs of teams
    # for i in range(0, len(teams), 2):
    #     if simulate_game(teams[i], teams[i + 1]):
    #         winners.append(teams[i])
    #     else:
    #         winners.append(teams[i + 1])

    return winners
end


def simulate_tournament(teams)
    """Simulate a tournament. Return name of winning team."""
    # TODO
end

# if __name__ == "__main__":
#     main()
```
{: file='tournament.rb' }

## The `simulate_game` function.

We need to rewrite some parts of this function to Ruby.

### What I did:
* Added `.to_i` to both team's ratings, the CSV reader reads it as string, we need to convert it to integer.
* Added `.to_f` on divisors since Ruby will return an integer instead if we keep it as is when we are expecting a float.
* Removed `return` keyword since Ruby will always return the last line.
* Replaced `random.random()` with Ruby equivalent `rand` function.

```ruby
def simulate_game(team1, team2)
  """Simulate a game. Return True if team1 wins, False otherwise."""
  rating1 = team1['rating'].to_i
  rating2 = team2['rating'].to_i
  probability = 1 / (1 + 10 ** ((rating2 - rating1) / 600.to_f)).to_f
  rand < probability
end
```

## The `simulate_round` function.

What this function does is given an array of `teams`, it iterates through `teams` with a step of `2` then calls `simulate_game` function for the current team and the next team to get the winner between the 2 teams, the winner team then gets appended to the `winners` array and returned.

### What I did:
Instead of iterating with a step of 2, I grouped the array of `teams` by twos using `.each_slice(2).to_a` method.

What it does:
```ruby
[1, 2, 3, 4, 5, 6].each_slice(2).to_a
# => [[1, 2], [3, 4], [5, 6]]
```

Since we only have a pair, we can just use `first` and `last` to get the teams.

```ruby
def simulate_round(teams)
  """Simulate a round. Return a list of winning teams."""
  winners = []

  teams.each_slice(2).to_a.each do |pair|
    if simulate_game(pair.first, pair.last)
      winners << pair.first
    else
      winners << pair.last
    end
  end

  winners
end
```

Looking at the above code, we can even make it shorter as we don't even need the `winners` variable that came from the template.

```ruby
def simulate_round(teams)
  """Simulate a round. Return a list of winning teams."""
  teams.each_slice(2).to_a.map do |pair|
    simulate_game(pair.first, pair.last) ? pair.first : pair.last
  end
end
```

Instead of creating a new `winners` array, we can just manipulate the grouped `teams` array.

## The `simulate_tournament` function.

This is where the challenge starts as we have to write the code instead of just rewriting.

To successfully simulate a tournament we need to only have one winner. Remember that the `simulate_round` function already returns an array of `winners`, but we just need one.

So how do we do that? We can just repeatedly call `simulate_round` for winners only until there is only one team left.

```ruby
def simulate_tournament(teams)
  """Simulate a tournament. Return name of winning team."""
  winners = teams

  loop do 
    winners = simulate_round(winners)

    break if winners.length == 1
  end

  winners.first
end
```

I initially assigned `teams` to `winners`, I then simulated a round, where the `winners` gets updated with only the winning teams removing the others, I then checks if we only have 1 team left, if it does then it must be the winner of the tournament, else just keep simulating rounds until 1 team is left.

Since we only have 1 winner we can just return `winners.first`.

## The imports.

Aside from the `CSV` library I don't think we need anything else.

We replaced:
```python
import csv
import sys
import random
```

With just:
```ruby
require 'csv'
```

## Calling the `main` function.

In Ruby, there really isn't a `main` function. All codes written outside `class .. end` or `module .. end` are executed in a special `main` object.

Looking at this question: [Should I define a main method in my ruby scripts?](https://stackoverflow.com/questions/582686/should-i-define-a-main-method-in-my-ruby-scripts), I decided to follow one of the answers.

We simply replaced:
```python
if __name__ == "__main__":
    main()
```

With:
```ruby
if __FILE__ == $PROGRAM_NAME
  main
end
```

## The `main` function.

### Ensuring the correct usage.

We replaced:
```python
# Ensure correct usage
if len(sys.argv) != 2:
    sys.exit("Usage: python tournament.py FILENAME")
```

With:
```ruby
if ARGV.first.nil?
  puts "Usage: ruby tournament.rb FILENAME"
  exit
end
```

In Python `sys.argv` is an array of strings separated by space that came from the command line arguments. In the case of `python tournament.py FILENAME`, `sys.argv[0]` has a value `tournament.py`, `sys.argv[1]` has a value `FILENAME` and so on.

While in Ruby `ARGV` is almost the same as Python's but it does not include the current file. In the case of `ruby tournament.rb FILENAME`, `ARGV[0]` is `FILENAME` and not `tournament.rb`.

Both `sys.exit` and `exit` functions defaults in exiting with code `0`.

### Reading the teams into memory from file.

We can just do it one line in Ruby.

```ruby
teams = CSV.foreach(ARGV.first, :headers => true).map(&:to_h)
```

The `CSV` library reads the CSV file from the file path given in the command line arguments. We added `:headers => true` so that it generates a key-value pair where the key came from the first row of the CSV, then we mapped all the rows to make it a hash.

The `teams` array should look like this:
```ruby
[{"team"=>"Uruguay", "rating"=>"976"}, {"team"=>"Portugal", "rating"=>"1306"}, ...]
```

As you can see, `rating` here is a string that is why we added `to_i` in `simulate_game`.

### Simulating the tournament `N` number of times.

```ruby
counts = {}
```
The `counts` in Ruby is an instance of `Hash` where the default value of non-existent keys are `nil`.

Example:
```ruby
counts['non_existent_key']
# => nil
```

But since we need to dynamically add keys and increment their values, we can't have `nil` as the default value for non-existent keys as the following code will raise an error.

```ruby
counts['team_name'] += 1
# => undefined method `+' for nil:NilClass (NoMethodError)
```

We can do the long method:
```ruby
if counts['team_name'].nil?
  counts['team_name'] = 1
else
  counts['team_name'] += 1
end
```

But we can also do the better method:
```ruby
counts = Hash.new(0)

# or
counts = {}
counts.default = 0
```

The default value is now `0` instead of `nil`. The previous code will now work as expected.
```ruby
counts['team_name'] += 1
# => 1
```

Integers in Ruby has a `times` method where it creates a loop `N` number of times.

We know that the `simulate_tournament` we created returns a single winner of the tournament and we just have to run it `N` number of times and then increment their score in the `counts` object.

```ruby
N.times do
  winner = simulate_tournament teams

  counts[winner['team']] += 1
end
```

Now that we have their scores after doing `N` number of simulations we just need to sort it where the teams with the most score first.

```ruby
counts = Hash[counts.sort_by { |key, value| value }.reverse]
```

### Printing each team's chances of winning, according to simulation

```ruby
counts.keys.each do |key|
  puts "#{key}: #{counts[key] * 100 / N.to_f}% chance of winning"
end
```

## The output

```text
MacBook-Pro:world-cup davidangulo$ ruby tournament.rb 2018m.csv 
Belgium: 21.6% chance of winning
Brazil: 18.9% chance of winning
Portugal: 15.3% chance of winning
Spain: 11.6% chance of winning
Switzerland: 10.2% chance of winning
Argentina: 7.9% chance of winning
France: 4.0% chance of winning
England: 3.3% chance of winning
Colombia: 2.2% chance of winning
Denmark: 1.9% chance of winning
Croatia: 1.2% chance of winning
Uruguay: 0.7% chance of winning
Sweden: 0.6% chance of winning
Mexico: 0.6% chance of winning
```

## The full script.

```ruby
# Simulate a sports tournament

require 'csv'

# Number of simluations to run
N = 1000


def main
  # Ensure correct usage
  if ARGV.first.nil?
    puts "Usage: ruby tournament.rb FILENAME"
    exit
  end

  teams = CSV.foreach(ARGV.first, :headers => true).map(&:to_h)
  counts = Hash.new(0)

  N.times do
    winner = simulate_tournament(teams)

    counts[winner['team']] += 1
  end

  counts = Hash[counts.sort_by { |key, value| value }.reverse]

  # Print each team's chances of winning, according to simulation
  counts.keys.each do |key|
    puts "#{key}: #{counts[key] * 100 / N.to_f}% chance of winning"
  end
end


def simulate_game(team1, team2)
  """Simulate a game. Return True if team1 wins, False otherwise."""
  rating1 = team1['rating'].to_i
  rating2 = team2['rating'].to_i
  probability = 1 / (1 + 10 ** ((rating2 - rating1) / 600.to_f)).to_f
  rand < probability
end


def simulate_round(teams)
  """Simulate a round. Return a list of winning teams."""
  teams.each_slice(2).to_a.map do |pair|
    simulate_game(pair.first, pair.last) ? pair.first : pair.last
  end
end


def simulate_tournament(teams)
  """Simulate a tournament. Return name of winning team."""
  winners = teams

  loop do 
    winners = simulate_round(winners)

    break if winners.length == 1
  end

  winners.first
end


if __FILE__ == $PROGRAM_NAME
  main
end
```
{: file='tournament.rb' }
