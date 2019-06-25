STACK_NAME ?= rsvg-layer 
DOCKER_IMAGE ?= hansottowirtz/amazon-linux-librsvg:node

build result: 
	mkdir $@

clean:
	rm -rf build result

build/output.yaml: template.yaml build
	aws cloudformation package --template $< --s3-bucket $(DEPLOYMENT_BUCKET) --output-template-file $@

deploy: build/output.yaml
	aws cloudformation deploy --template $< --stack-name $(STACK_NAME)
	aws cloudformation describe-stacks --stack-name $(STACK_NAME) --query Stacks[].Outputs --output table

deploy-example:
	cd example && \
	make deploy DEPLOYMENT_BUCKET=$(DEPLOYMENT_BUCKET) RSVG_STACK_NAME=$(STACK_NAME)

copy-from-docker:
	rm -rf build result
	docker cp $$(docker run -d --entrypoint "" $(DOCKER_IMAGE) sleep 300):/opt ./result