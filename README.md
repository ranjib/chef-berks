# Chef::Berks
 Chef Berks monkey patches chef to allow grabbing cookbooks using berkshelf on the fly.
 If this works well, 
  * you dont have to  upload community cookbooks at your chef server.
  * you dont have to use vagrant-berkshelf plugin etc

 

## Installation

Add this line to your application's Gemfile:

    gem 'chef-berks'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chef-berks

## Usage
 You have to require chef-berks library in your chef client or solo config
 You also have to set the __use_berkshelf__ config to true. 

```ruby
require 'chef/berks'
use_berkshelf = true
```

 By default this library uses _/etc/chef/Berksfile_ , you can specify a different path 
 using the __berksfile__ config parameter (set in solo or client config).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
