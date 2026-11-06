# spread-mise

A [mise](https://mise.jdx.dev/) plugin that installs [Spread](https://github.com/canonical/spread),
a full-system integration test runner.

Spread runs test suites on local or remote machines described in a
`spread.yaml` file. It supports multiple backends, including LXD, QEMU,
OpenStack, Google, Linode, and ad-hoc SSH, and can run tasks in parallel
across systems.

## Installation

Add the plugin and the desired Spread version to your `mise.toml`:

```toml
[plugins]
spread = "https://github.com/cmatsuoka/spread-mise"

[tools]
spread = "2026.07.12"
```

Then install it:

```sh
mise install
```

The plugin builds Spread from source with `go install`, so a Go toolchain
must be available. Configure one in the same `mise.toml` if needed:

```toml
[tools]
go = "1.27"
spread = "2026.07.12"
```

List available versions with:

```sh
mise ls-remote spread
```

## Usage

```sh
spread --help
spread -list
```

See the [Spread documentation](https://github.com/canonical/spread) for how
to write `spread.yaml` files and run projects.
