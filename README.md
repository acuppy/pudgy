## Pudgy

A generic Ruby interface for any JSON or XML API

#### Usage

```ruby
users = Pudgy.connect("http://api.example.com/users").query(token: "abcd1234").consume!
````
