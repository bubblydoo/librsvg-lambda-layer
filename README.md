# Static rsvg-convert binary for AWS Lambda

A statically linked `rsvg-convert` binary utility from the [`librsvg`](http://live.gnome.org/LibRsvg) Linux package, allowing you to render SVG images to PDF and PNG on AWS Lambda using [Cairo](https://cairographics.org).

Compiled with AMI ami-60b6c60a, 29 October 2016, with the following library versions:

* `cairo`: 1.12.14
* `pango`: 1.28.4
* `libcroco`: 0.6.8
* `gdk-pixbuf`: 2.28.2
* `librsvg`: 2.26.3

These are all a bit old, but are compatible with the other libraries available through YUM for the Amazon Linux instance. To get a more recent version built, modify `compile-static.sh` to include the appropriate versions of dependencies.

## Download the binary

Grab the binary from the [vendor](/vendor) directory

## Creating a fresh compilation

1. Create an AMI
2. ssh to the AMI as `ec2-user`
3. on the VM, run `system_init.sh`
4. on the VM, run `compile-static.sh`

## Testing on a (non-Lambda) AWS Linux VM

The binary will work on a plain-vanilla AWS Linux VM, but needs some additional packages (these are already available on the VM used for Lambda functions).

```
sudo yum install cairo libtiff -y
```

### Copyright and license

GNU GENERAL PUBLIC LICENSE.  Copyright (C) 1989, 1991 Free Software Foundation, Inc. 
[Original LibRSVG license](https://git.gnome.org/browse/librsvg/tree/COPYING).
