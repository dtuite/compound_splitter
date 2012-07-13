# CompoundSplitter

Split compoind words into their component parts. For example, 'rainyday' ->
'rainy day'.

    CompoundSplitter.split('longwalk')
    # => ['long', 'walk']

## Installation

Add this line to your application's Gemfile:

    gem 'compound_splitter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install compound_splitter

## Usage

**Basic Usage**

    splitter = CompoundSplitter::Splitter.new
    splitter.split('rainyday')
    # => ['rainy', 'day']

    splitter.split('wickedweather')
    # => ['wicked', 'weather']

**Shortcut**

There is a shortcut `split` method available on the top-level namespace.

    CompoundSplitter.split('longwalk')
    # => ['long', 'walk']

The longer version should be used wherever possible since doing so will
prevent loading and prepearing of the dictionary multiple times.

**The Dictionary File**
The compound splitter assumes you have a dictionary file
in your file system at `/usr/share/dict/words`. If you would like
to use a different dictionary file then you can create a new dictionary
object and pass it into the splitters initializer.

    dict = CompoundSplitter::Dictionary.new('path/to/dictionary/file')

    splitter = CompoundSplitter::Splitter.new(dict)
    splitter.split('rainyday')
    # => ['rainy', 'day']

## Acknologements

This gem is basically a translation to Ruby of a [Stack Overflow answer](http://stackoverflow.com/a/481773/574190)
by Darius Bacon. The answer was given in python. Thus credit for the implementation should go to Darius.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
