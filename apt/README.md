# APT salt module

This module provides an easy way to manage your Debian repositories. The main
features are:

 * /etc/apt/sources.list and /etc/apt/sources/list.d:
   - full customization
   - sane defaults
   - multiarch for Debian releases that support it
 * /etc/apt/apt.conf and /etc/apt/apt.conf.d:
   - recommended and suggested packages are not installed by default
   - run dist-upgrade on release change
 * /etc/apt/preferences and /etc/apt/preferences.d:
   - prepare environment for apt-pinning.

# Usage

Jinja template for `/etc/apt/sources.list` is an ultimate tamplate that can be
used to generate other files in sources.list format using YAML configuration
data. The nost interesting part is `context.repositories`, an here is extended
example how to use it:

    repositories:
      # The shortest form, everything is set to default values
      - name: stable

      # The longest form
      - name: wheezy/updates
        arch: [armel, amd64, i386]
        components: [main, contrib, non-free]
        trusted: True
        type: [binary, source]
        url: "http://security.debian.org/"

This will give the following output:

    deb http://cdn.debian.net/debian stable main

    deb [arch=armel,amd64,i386 trusted=yes] http://security.debian.org/ wheezy/updates main contrib non-free
    deb-src http://security.debian.org/ wheezy/updates main contrib non-free

# Options

Every repository can be defined by at least it's name. This will assume to
point to an official binary Debian repository with a single `main` component
used.

  * `name` - a distribution to be used. Should be set manually;
  * `arch` - list of architectures used with multiarch features; not set by
    default;
  * `components` - list of repository components to used; set to [main];
  * `trusted` - assume all packages from this repository are trusted; not set by
    default;
  * `type` - list of types of repository to use; types are `binary` and `source`
    that will genedate `deb` and `deb-src` lines respectively; defaults to
    `[binary]`
  * `url` - repository URL; cdn.debian.org is used by default

# TODO

 * run `dpkg --add-architecture` when new architecture appears as well as `dpkg
   --remove-architecture` when disappears
