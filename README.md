# packages

Allow installing packages directly from Hiera

## Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Development - Guide for contributing to the module](#development)

## Description

With this module, you can create a Hash in your Hiera files to automatically install the corresponding packages in
Puppet via the `create_resources` function.

### Usage

You just need to include the class in your puppet code or in Hiera if you configured it :

#### In your Puppet code

```puppet
include packages

# OR

class { packages:
}
```

#### In Hiera

`site.pp`:
```puppet
lookup('classes', { merge => unique, default_value => [] }).include
```

`hiera.yaml`:
```yaml
---
classes:
  - packages
```

## Usage

You can change the merge behavior of the lookup, by default, no merge behavior is set and the one set in Hiera is used:
```yaml
packages::merge_behavior: deep
```
Or:
```puppet
class { packages:
  merge_behavior => deep,
}
```

Once you included the class, you can declare the resources like this:
```yaml
packages:
    htop:
      ensure: latest
    requests:
      provider: pip3
    man:
    vim:    
```

You can check the [examples/hiera.yaml](examples/hiera.yaml) for a real world examples

## Release Notes/Contributors/Etc.

### Release 0.1.0

Initial Release
