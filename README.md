# Urlpreview

**TODO: Add description**

## Installation

Include the package in `mix.exs`:

```elixir
def deps do
  [{:urlpreview, "~> 0.0.2"}]
end
```

Then use it in the following way:

```elixir
if Urlpreview.is_valid_url?("http://www.google.com") do
  preview = Urlpreview.preview("http://www.google.com")
end
```

The following properties are currently available

```elixir
preview.real_url
preview.url
preview.description
preview.images <- list of site images
preview.title
```

Docs can be found at [https://hexdocs.pm/urlpreview](https://hexdocs.pm/urlpreview).
