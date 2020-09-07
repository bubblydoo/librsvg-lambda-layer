# LibRSVG for AWS Lambda

Scripts to compile LibRSVG for AWS Lambda instances powered by Amazon Linux 2.x.

## Usage

The `rsvg` binary will be in `/opt/bin/rsvg-convert` after linking the layer to a Lambda function.

## Prerequisites

* Docker desktop
* Unix Make environment
* AWS command line utilities (just for deployment)

## Compiling the code

* start Docker services
* `docker build . --target librsvg -t amazon-linux-librsvg`
* (`docker build . --target builder -t amazon-linux-librsvg-builder`)

* [`Dockerfile`](Dockerfile) is used to download all the libraries.
* [`Makefile`](Makefile) is used to copy the built binary from docker and to deploy the layer with CloudFormation.

The output will be in the `result` dir.

## Deploying to AWS as a layer

Run the following command to deploy the compiled result as a layer in your AWS account.

```
make copy-from-docker DOCKER_IMAGE=amazon-linux-librsvg
make deploy DEPLOYMENT_BUCKET=<YOUR BUCKET NAME>
```

### Compiled info

`librsvg-convert`: version 2.49.5

### Configuring the deployment

By default, this uses `rsvg-layer` as the stack name. Provide a `STACK_NAME` variable when
calling `make deploy` to use an alternative name.

For more information, check out:

* https://github.com/GNOME/librsvg

## Author

Hans Otto Wirtz <https://github.com/hansottowirtz>
Gojko Adzic <https://gojko.net>

## License

* These scripts: [MIT](https://opensource.org/licenses/MIT)
* Rsvg: <https://github.com/GNOME/librsvg/blob/master/COPYING>
* Contained libraries all have separate licenses, check the respective web sites for more information
