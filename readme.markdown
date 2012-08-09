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

Letting people hook around a method in your object is as simple as:

```ruby
class SomeObject
  include Hook

  +hook
  def some_method; end
end
```

Now, anyone can hook into your method:

```ruby
SomeObject.hook_before(:some_method) do |some_object|
  #...
end

SomeObject.hook_after(:some_method) do |some_object|
  #...
end

SomeObject.hook_around(:some_method) do |some_object|
  #...
end 
```

`some_object` is the instance of `SomeObject` that `some_method` executed on.

Basically, whenever anyone calls the `some_method` method on a `SomeObject`
instance, here's what happens:

    around some_method hooks run
    before some_method hooks run
    some_method method runs
    after some_method hooks run
    around some_method hooks run

### Resetting callbacks

The hook library allows you to remove configured callbacks for either a
specific hooked method, or for all hooked methods.

#### Specific Hooked Method
You can remove all before, after, and around some_method callbacks on your class
with the "remove\_callbacks!" method:

```ruby
SomeObject.remove_callbacks! :some_method
```

#### All Hooked Methods

If you want to remove all configured callbacks for all hooked methods in
one fail swoop, you can use the "remove_all_callbacks!" method:

```ruby
SomeObject.remove_all_callbacks!
```


##LICENSE

This software is public domain. Since I've relinquished copyright, you can do anything with it. GO WILD.

##Contributing

Submit a pull request. Tests required. Also, by submitting a pull
request, you are relinquishing your copyright over your contribution and
submitting it to the public domain.
