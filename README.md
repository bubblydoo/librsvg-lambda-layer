# LibRSVG for AWS Lambda with Node module

Scripts to compile LibRSVG for AWS Lambda instances powered by Amazon Linux 2.x, such as the `nodejs10.x` runtime. Also includes the `librsvg-prebuilt` Node module which is compiled with `gyp` on Amazon Linux.

## Usage

Absolutely the easiest way of using this is to pull it directly from the AWS Serverless Application repository into a CloudFormation/SAM application, or deploy directly from the Serverless Application Repository into your account, and then link as a layer. 

The `rsvg` binary will be in `/opt/bin/rsvg-convert` after linking the layer to a Lambda function.
The `librsvg-prebuilt` npm package will be installed in `/opt/nodejs/node_modules`, which is in the default `NODE_PATH`

For more information, check out the [rsvg-convert-lambda-layer](https://serverlessrepo.aws.amazon.com/applications/arn:aws:serverlessrepo:us-east-1:145266761615:applications~rsvg-convert-lambda-layer) application in the Serverless App Repository.

For manual deployments and custom builds, read below...

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

`librsvg-convert`: version 2.40.16

### Configuring the deployment

By default, this uses `rsvg-layer` as the stack name. Provide a `STACK_NAME` variable when
calling `make deploy` to use an alternative name.

### example usage

An example project is in the [example](example) directory. It sets up two buckets, and listens to file uploads on the first bucket to convert and generate PDF files from SVG images. You can deploy it from the root Makefile using:

```
make deploy-example DEPLOYMENT_BUCKET=<YOUR BUCKET NAME>
```

For more information, check out:

* https://github.com/GNOME/librsvg

## Author

Gojko Adzic <https://gojko.net>
Hans Otto Wirtz <https://github.com/hansottowirtz>

## License

* These scripts: [MIT](https://opensource.org/licenses/MIT)
* Rsvg: <https://github.com/GNOME/librsvg/blob/master/COPYING>
* Contained libraries all have separate licenses, check the respective web sites for more information
