## Pudgy

A generic Ruby interface for any JSON or XML API.  There are many libraries which handle connections to a remote service.  Pudgy is designed to consume the response data and auto-magically convert that data into Ruby representations, which can be viewed, modified and updated.

#### Usage

##### Connecting to a resource

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

#### Consume (GET)

```ruby
users = Pudgy.consume("http://api.example.com/users")
````

You can also pass in a representation and Pudgy will output a Ruby representation:

```ruby
users = Pudgy.consume("{ user: { firstname: "Billy", lastname: "Bob" } }")
````

#### Emit (POST)

```ruby
address = {
  street: "111 Main St.",
  city: "Ashland",
  state: "OR",
  zipcode: "97520"
}

response = Pudgy.emit("http://api.example.com/users/1", data: address)
````

##### Representing an entity

By default Pudgy will consume a representation and convert all attributes into `attr_accessor` properties on the object.

It assumes the root element is the object definition (e.g. "user" is `User`)

```ruby
user = Pudgy.consume("{
  "user": {
    "firstname": "Billy",
    "lastname": "Bob"
  }
}")
```

You can customize a representation by defining a Representation class:

```ruby
module Pudgy
  module Representation
    class User < Base
      property: "firstname"
      property: "lastname"
      
      def fullname
        "#{self.firstname} #{self.lastname}"
      end
    end
  end
end
```

Pudgy will look for a defined representation before it uses a generic representation.

#### Defining Relationships

Pudgy will attempt to build relationships between objects.

```json
{
  "users": [{
    "id": "1",
    "company_id": "1",
    "firstname": "Billy",
    "lastname": "Bob",
  },{
    "id": "2",
    "company_id": "2",
    "firstname": "Jimmy",
    "lastname": "John",
  }],
  
  "companies": [{
    "id": "1",
    "name": "ABC, Inc."
  },{
    "id": "2",
    "name": "DEF, LLC."
  }]
}
```

Similar to Rails, when the association is pluralized, Pudgy will assume a has\_many relationship between "companies" and the "user" and a belong\_to relationship between "user" and "companies".  You can customize this relationship by defining a `foreign_key` on in your custom representation:

```ruby
module Pudgy
  module Representation
    class User < Base
      belongs_to :company, foreign_key: "organization"
      ...
    end
  end
end
```
