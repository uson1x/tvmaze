TVmaze API Gem
==============

Ruby wrapper for the [TVmaze API](http://api.tvmaze.com/).


## Required gems:

* rest-client ~> 1.8.0
(not tested with other versions)

## Install:

Add this line to your application's Gemfile:

```ruby
gem 'tvmaze'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install tvmaze
```

## Basic Usage

As for now, the scope of the library is very limited 
and supports only searching for shows and individual show fetching.
Also, `nextepisode` and `episodes` embeds are available.

First require `tvmaze`

```ruby
require 'tvmaze'
```
Then use one of the available methods:

```ruby
shows = TVMaze::Show.search('big bang')

show = TVMaze::Show.find(66)
show = TVMaze::Show.find(66, {embed: ['nextepisode']})
show = TVMaze::Show.find(66, {embed: ['episodes']})
```

## Testing

To run the specs:

```
bundle exec rspec
```

## Contributions

You're welcome to submit patches and new features!

- Create a new branch for your feature of bugfix
- Don't forget to add tests
- Open a new pull request

## License

The MIT License (MIT)

Copyright (c) 2015-2016 Ivan Parfenchuk, <uson1x@gmail.com>
