# GhTrend

Get Trending repositories on Github for CLI.

## Installation

    $ gem install gh-trend

## Usage
    
    $ gh-trend -h
    Usage: gh-trend <command> [options] <args>
    -l, --lang        Select language.
    -d, --desc        Display description.
    -n, --num         Limit numbers.
    -b, --brows       Open repository on browser.
    -s, --star        Star a repository.
    -u, --unstar      Unstar a repository.
    -h, --help        Display this help message.

## Authentication

Reading credentials from a netrc file (defaulting to ~/.netrc). Given these lines in your netrc.
if user authenticated, you can use '-s' and '-u' options.

    machine api.github.com
      login xxxxx
      password xxxxxxxxxx

### Example

If user authenticated, it is a displayed star or unstar at a right side.

    $ gh-trend -l ruby -d -n 3

    Trending Ruby repositories on GitHub today
    --------------------------------------------------------
    1: Gazler/githug                                  unstar
       Git your game on!
    2: pawurb/termit                                  star
       Google Translate with speech synthesis in your terminal
    3: webnuts/post_json                              star
       A Fast and Flexible Document Database by Combining Features of Ruby and PostgreSQL with PLV8

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

