# Hook

A simple API for adding before, after, and around callbacks to methods.

Think of it as `ActiveSupport::Callbacks`Lite.

## Installation

It's a gem. Install it:
    
    $ gem install hook

Or add it to your Gemfile:
    
    gem "hook"

## Usage

Imagine you've created a testing framework, and it includes a `Test`
class with an `execute` method:

```ruby
class Test
  #...
  def execute
    #...
  end
end
```

You'll likely want to offer hooks into the execution lifecycle of your
tests. First, include `Hook` into your class, then call `hook :execute`:

```ruby
class Test
  include ::Hook
  hook :execute
end
```

Next, you'll need to wrap the body of the `execute` method with a call
to `with_hooks(:execute)`:

```ruby
class Test
  include ::Hook
  hook :execute

  def execute
    with_hooks :execute do
      #...
    end
  end
end
```

Now, **anyone can hook into the lifecycle of a test**:

```ruby
Test.before_execute do |test|
  #...
end

Test.after_execute do |test|
  #...
end

Test.around_execute do |test|
  #...
end 
```

Notice that our blocks accepted a `test` parameter. This is an instance
of the `Test` object that `execute` was called on.

Basically, whenever anyone calls the `execute` method on a test
instance, here's what happens:

    before hooks run
    around hooks run
    execute method runs
    around hooks run
    after hooks run


##LICENSE

This software is public domain. Since I've relinquished copyright, you can do anything with it. GO WILD.

##Contributing

Submit a pull request. Tests required. Also, by submitting a pull
request, you are relinquishing your copyright over your contribution and
submitting it to the public domain.