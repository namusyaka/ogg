# Ogg

Ogg is an Open Graph Generator, support *Basic Metadata*, *Optional Metadata*, *Structured Properties* at present.

[Whats is Open Graph?](http://ogp.me/)

## Installation

add this line to your Gemfile. `gem 'ogg'`

or

`$ gem install ogg`

## Usage

### Basic

Basic style.

```ruby
require 'ogg'

ogg = Ogg.new
ogg.title = 'Site Title'
ogg.type  = 'Article'
ogg.description = 'Description'
ogg.url   = 'http://example.com/'
ogg.image = 'http://example.com/example.png'
ogg.site_image = 'http://example.com/site_image.png'
ogg.email = 'foo@bar.com'
ogg.html
```

Ogg support new method with block.

```ruby
ogg = Ogg.new do |o|
  o.title = 'Site Title'
  o.type  = 'Article'
  o.description = 'Description'
  o.url   = 'http://example.com/'
  o.image = 'http://example.com/example.png'
  o.site_image = 'http://example.com/site_image.png'
  o.email = 'foo@bar.com'
end
ogg.html
```

#### `:raise`

If you set :raise option and basic properties are inadequacy, occurs `InvalidBasicProperty`.

```ruby
ogg = Ogg.new(:raise => true)
begin
  ogg.html 
rescue InvalidBasicProperty
  puts "called"
end
```

### Structured Properties

#### like accessor

```ruby
ogg = Ogg.new do |o|
  o.image.url        = "http://example.com/example.png"
  o.image.secure_url = "https://example.com/example.png"
  o.image.type       = "image/png"
  o.image.width      = "400"
  o.image.height     = "300"

  o.video.secure_url = "https://example.com/example.swf"
  o.video.type       = "application/x-shockwave-flash"
  o.video.width      = "400"
  o.video.height     = "300"

  o.audio.secure_url = "https://example.com/example.mp3"
  o.audio.type       = "audio/mpeg"
end
ogg.html
```

#### like hash

```ruby
ogg = Ogg.new do |o|
  o.image[:url]        = "http://example.com/example.png"
  o.image[:secure_url] = "https://example.com/example.png"
  o.image[:type]       = "image/png"
  o.image[:width]      = "400"
  o.image[:height]     = "300"

  o.video[:secure_url] = "https://example.com/example.swf"
  o.video[:type]       = "application/x-shockwave-flash"
  o.video[:width]      = "400"
  o.video[:height]     = "300"

  o.audio[:secure_url] = "https://example.com/example.mp3"
  o.audio[:type]       = "audio/mpeg"
end
ogg.html
```

## Contributing

1. fork the project.
2. create your feature branch. (`git checkout -b my-feature`)
3. commit your changes. (`git commit -am 'commit message'`)
4. push to the branch. (`git push origin my-feature`
5. send pull request.

## License

the MIT License
