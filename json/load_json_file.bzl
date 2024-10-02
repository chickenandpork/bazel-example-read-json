def _load_json_file_impl(repository_ctx):
    """Generate a starlark equivalent of a parsed JSON file

    Args:
      repository_ctx: repository context
    """

    json_data = json.decode(repository_ctx.read(repository_ctx.attr.src))

    repository_ctx.file("BUILD", "exports_files([ \"json.bzl\"])")
    repository_ctx.file("json.bzl", "{}={}".format(
        repository_ctx.attr.variable_name,
        repr(json_data),
    ))

# DRY via JSON: Initial conversion of a JSON file to a dict/struct that Bazel can interpret.  This
# is a bit indirect: this is used during MODULE.bazel registration of external resources.  We
# create a virtual external dependency called @name that provides a file called "@name//:json.bzl"
# that provides a JSON struct called "version_json"; usage is similar to:
#
# load("@name//:json.bzl", "version_json")
# ...
#    version = version_json["terraform"]["version"]
# ...
load_json_file = repository_rule(
    implementation = _load_json_file_impl,
    attrs = {
        "src": attr.label(allow_single_file = True, default = "//:.github/renovate-regex.json", doc = "a JSON file to wrap in a starlark file in a repo"),
        "variable_name": attr.string(default = "version_json", doc = "symbol to define by the contents of the JSON file, for use in a BUILD file"),
    },
    local = True,
)
