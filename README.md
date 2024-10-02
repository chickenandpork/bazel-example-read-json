# bazel-example-read-json

An example response to the recurring question of how Bazel can read a JSON file

# Build

```bash
bazel test //...
bazel run //:hydrate
```

# More Detail

This is a sample of how to parse JSON in a Bazel build, and use that value as an attribute for
other targets.  This pops up regularly, and is often hacked together as a solution, but I found
that using a repository_rule() gives a clean, functional solution that doesn't block
build-avoidance nor caching.

This is discussed on https://medium.com/@chickenandpork/reading-json-in-bazel-with-bzlmod-71f799da8161

