# Webhookr::PostmarkInbound

This gem is a plugin for [Webhookr](https://github.com/darkpanda/webhookr) that enables your application to accept [webhooks from Postmark Inbound Mail Processing](https://postmarkapp.com/manual#implementing-inbound-processing).

## Installation

Add this line to your application's Gemfile:

    gem 'webhookr-postmark_inbound'

Or install it yourself:

    $ gem install webhookr-postmark_inbound

[webhookr](https://github.com/zoocasa/webhookr) is installed as a dependency of webhookr-postmark_inbound. If you have not [setup Webhookr](https://github.com/zoocasa/webhookr#usage--setup), do so now:

```console
rails g webhookr:add_route
```

## Usage

Once you have the gem installed run the generator to add the code to your initializer.
An initializer will be created if you do not have one.

```console
rails g webhookr:postmark_inbound:init postmark_inbound -s
```

Run the generator to create an example file to handle postmark_inbound webhooks.

```console
rails g webhookr:postmark_inbound:example_hooks
```

Or create a postmark_inbound handler class for any event that you want to handle. For example
to handle unsubscribes you would create a class as follows:

```ruby
class postmark_inbound_hooks
  def on_email(incoming)
    # Your custom logic goes here.
    User.unsubscribe_newletter(incoming.payload.msg.email)
  end
end
```

For a complete list of events, and the payload format, see below.

Edit config/initializers/postmark_inbound.rb and change the commented line to point to
your custom PostmarkInbound event handling class. If your class was called *PostmarkInboundHooks*
the configuration line would look like this:

```ruby
  Webhookr::PostmarkInbound::Adapter.config.callback = PostmarkInboundHooks
```

To see the list of PostmarkInbound URLs your application can use when you configure
postmark_inbound webhooks,
run the provided webhookr rake task:

```console
rake webhookr:services
```

Example output:

```console
postmark_inbound:
  GET	/webhookr/events/postmark_inbound/19xl64emxvn
  POST	/webhookr/events/postmark_inbound/19xl64emxvn
```

## PostmarkInbound Events & Payload

### Events

<table>
  <tr>
    <th>PostmarkInbound Event</th>
    <th>Event Handler</th>
  </tr>
  <tr>
    <td>send</td>
    <td>on_email(incoming)</td>
  </tr>
</table>

### Payload

The payload is the full payload data as per the [postmark_inbound documentation](http://help.postmark_inbound.com/entries/24466132-Webhook-Format), converted to an OpenStruct for ease of access. Examples

```ruby
 
```

### <a name="supported_services"></a>Supported Service - postmark_inbound

* [http://help.postmark_inbound.com/entries/21738186-Introduction-to-Webhooks](postmark_inbound - v1.0)

## <a name="works_with"></a>Works with:

webhookr-postmark_inbound works with Rails 5.0+, and has been tested on the following Ruby
implementations:

* 2.5.1

### Versioning
This library aims to adhere to [Semantic Versioning 2.0.0](http://semver.org/). Violations of this scheme should be reported as
bugs. Specifically, if a minor or patch version is released that breaks backward compatibility, that
version should be immediately yanked and/or a new version should be immediately released that restores
compatibility. Breaking changes to the public API will only be introduced with new major versions. As a
result of this policy, once this gem reaches a 1.0 release, you can (and should) specify a dependency on
this gem using the [Pessimistic Version Constraint](http://docs.rubygems.org/read/chapter/16#page74) with
two digits of precision. For example:

    spec.add_dependency 'webhookr-postmark_inbound', '~> 1.0'

While this gem is currently a 0.x release, suggestion is to require the exact version that works for your code:

    spec.add_dependency 'webhookr-postmark_inbound', '0.0.1'

## License

webhookr-postmark_inbound is released under the [MIT license](http://www.opensource.org/licenses/MIT).

## Author

* [Gerry Power](https://github.com/gerrypower)
