## Pudgy

A generic Ruby interface for any JSON or XML API

#### Usage

Build a connection relationship:

```ruby
users = Pudgy.connect("http://api.example.com/users").query(auth_token: "abcd1234")
````

Or, pass a block to specify connection configuration options:

```ruby
users = Pudgy.connect "http://api.example.com/users" do |connection|
  connection.query(auth_token: "abcd1234")
end
````

Similar to ActiveRecord::Relation, the resulting information is not loaded until an iteration method (e.g. `each()`) is called; therefore, you can continue to build onto the connection object.

```ruby
users = Pudgy.connect "http://api.example.com/users" do |connection|
  connection.query(auth_token: "abcd1234")
end

# Add parameters to the connection object
users.data({})

# Now the request is triggered
users.each do |user
  # ...
end
````

There are also shorthand methods which will build the connection and make the request

#### Consume (get)

```ruby
users = Pudgy.consume("http://api.example.com/users")
````

Bypass autoloading by passing `autoload: false` as a argument:

```ruby
users = Pudgy.consume("http://api.example.com/users", autoload: false)
````

#### Emit (post)

```ruby
address = {
  street: "111 Main St.",
  city: "Ashland",
  state: "OR",
  zipcode: "97520"
}

response = Pudgy.emit("http://api.example.com/users/1", data: address)
````
