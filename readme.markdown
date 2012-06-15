# Hook

[![Build Status](https://secure.travis-ci.org/moonmaster9000/hook.png)](http://travis-ci.org/moonmaster9000/hook)

A simple API for adding before, after, and around callbacks to methods.

Think of it as `ActiveSupport::Callbacks`Lite.

## Installation

It's a gem. Install it:
    
    $ gem install hook

Or add it to your Gemfile:
    
    gem "hook"

## Usage

Imagine you've created a testing framework, and it includes a `Test`
class with an `execute` method.

You'll likely want to offer hooks into the execution lifecycle of your
tests. First, include `Hook` into your class, then decorate any methods you wish to hook with `+hook`:

```ruby
class Test
  include Hook

  +hook
  def execute; end
end
```

Now, anyone can hook into the lifecycle of a test:

```ruby
Test.hook_before(:execute) do |test|
  #...
end

Test.hook_after(:execute) do |test|
  #...
end

Test.hook_around(:execute) do |test|
  #...
end 
```

Notice that our blocks accepted a `test` parameter. This is an instance
of the `Test` object that `execute` was called on.

Basically, whenever anyone calls the `execute` method on a test
instance, here's what happens:

    around execute hooks run
    before execute hooks run
    execute method runs
    after execute hooks run
    around execute hooks run

### Resetting callbacks

The hook library allows you to remove configured callbacks for either a
specific hooked method, or for all hooked methods.

#### Specific Hooked Method
You can remove all before, after, and around execute callbacks on your class
with the "remove\_execute\_callbacks!" method:

```ruby
Test.remove_callbacks! :execute
```

#### All Hooked Methods

If you want to remove all configured callbacks for all hooked methods in
one fail swoop, you can use the "remove_callbacks" method:

```ruby
Test.remove_all_callbacks!
```


##LICENSE

This software is public domain. Since I've relinquished copyright, you can do anything with it. GO WILD.

##Contributing

Submit a pull request. Tests required. Also, by submitting a pull
request, you are relinquishing your copyright over your contribution and
submitting it to the public domain.
