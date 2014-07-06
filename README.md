# Atabodi

Unofficial idobata.io api client

## Installation

Add this line to your application's Gemfile:

    gem 'atabodi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install atabodi

## Usage

``` ruby
require 'atabodi'

# API client for bot
bot = Atabodi::Bot.new(api_token: 'your_idobata_bot_api_token_here')

# Get bot lists
res = bot.list_bots
p res.body.bots
# => [{"id":3543,"name":"ys","icon_url":"https://idobata.s3.amazonaws.com/uploads/bot/icon/3543/mihashi.jpg","api_token":"your_idobata_bot_api_token_here","status":"offline","channel_name":"presence-guy_3543"}]

# Update your idobata bot icon
bot.update_bot_icon(id: 3543, file_path: 'path/to/icon/image.jpg')

# API client for idobata user
user = Atabodi::User.new(user: 'your_idobata_user_mailadress', password: 'your_idobata_user_password')

# Get bot lists
res = user.list_bots
```

## Contributing

1. Fork it ( http://github.com/hanachin/atabodi/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
