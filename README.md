# LibRSVG for AWS Lambda

![Releases](https://img.shields.io/github/v/release/bubblydoo/librsvg-lambda-layer.svg)
![Build Docker Layer](https://github.com/bubblydoo/librsvg-lambda-layer/workflows/Build%20Docker%20Layer/badge.svg)

Scripts to statically compile LibRSVG for AWS Lambda instances powered by Amazon Linux 2.x.

## Usage

The `rsvg` binary will be in `/opt/bin/rsvg-convert` after linking the layer to a Lambda function.

## Download

The Lambda Layer ZIP can be found in [Releases](https://github.com/bubblydoo/librsvg-lambda-layer/releases).

## Prerequisites

* Docker
* AWS command line utilities (just for deployment)

## Compilation and deployment

* Clone the repository
```bash
git clone github.com/bubblydoo/librsvg-lambda-layer
cd librsvg-lambda-layer
```

* Start Docker services and build image (this might take a while)
```bash
docker build . --target librsvg-layer -t amazon-linux-librsvg-layer
# docker build . --target librsvg -t amazon-linux-librsvg
# docker build . --target builder -t amazon-linux-librsvg-builder
```

* Copy zip to ./dist
```bash
docker run -v "$PWD/dist":/dist amazon-linux-librsvg-layer
```

* Inspect layer content
```bash
unzip -l dist/librsvg-layer.zip
```

* Deploy to AWS
```bash
aws lambda publish-layer-version \
  --layer-name rsvg \
  --description "Librsvg layer" \
  --license-info "MIT License" \
  --zip-file fileb://dist/librsvg-layer.zip \
  --compatible-runtimes nodejs12.x
```

### Compiled info

`rsvg-convert`: version ![Version](https://img.shields.io/github/v/release/bubblydoo/librsvg-lambda-layer.svg?style=flat&label=)

### Caveats

* Images with `xlink:href="file://` do not load properly. You can inline the files as a `data://` uri as a workaround.
* Only jpeg and png builtin loaders are enabled (for usage with `data://`), but more can be enabled in `Dockerfile`

## More information

For more information, check out:

* https://github.com/GNOME/librsvg

## Author

Hans Otto Wirtz <https://github.com/hansottowirtz>
Gojko Adzic <https://gojko.net>

## License

* These scripts: [MIT](https://opensource.org/licenses/MIT)
* Rsvg: <https://github.com/GNOME/librsvg/blob/master/COPYING>
* Contained libraries all have separate licenses, check the respective web sites for more information
