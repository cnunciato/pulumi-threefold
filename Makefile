GOPATH := $(shell go env GOPATH)

DIRS := . $(shell find tests examples -type d)
GARBAGE_PATTERNS := Pulumi.test.yaml state
GARBAGE := $(foreach DIR,$(DIRS),$(addprefix $(DIR)/,$(GARBAGE_PATTERNS)))


NAME            := threefold
PROJECT         := github.com/threefoldtech/pulumi-${NAME}
PROVIDER 				:= pulumi-resource-${NAME}
CODEGEN         := pulumi-gen-${NAME}

PROVIDER_PATH   := provider
VERSION_PATH    := ${PROVIDER_PATH}/pkg/version.Version
SCHEMA_PATH     := ${PROVIDER_PATH}/cmd/${PROVIDER}/schema.json
WORKING_DIR     := $(shell pwd)
VERSION         := $(shell pulumictl get version)
LATEST_VERSION  := $(shell git describe --tags  --abbrev=0 --match="v[0-9]*" HEAD)

all: prepare lint build schema test

prepare:
	go work sync
	for DIR in "provider" "sdk" "tests" "examples" ; do \
		cd $$DIR && go mod tidy && cd ../ ; \
	done

install_latest:
	pulumi plugin install resource ${NAME} ${LATEST_VERSION} --server github://api.github.com/threefoldtech/pulumi-threefold

build: gen
	(cd provider && go build -o $(WORKING_DIR)/bin/${PROVIDER} -ldflags "-X ${PROJECT}/${VERSION_PATH}=${VERSION}" $(PROJECT)/${PROVIDER_PATH}/cmd/$(PROVIDER))

gen::
	(cd provider && go build -o $(WORKING_DIR)/bin/${CODEGEN} -ldflags "-X ${PROJECT}/${VERSION_PATH}=${VERSION}" ${PROJECT}/${PROVIDER_PATH}/cmd/$(CODEGEN))

schema:
	pulumi package get-schema $(WORKING_DIR)/bin/${PROVIDER} > $(WORKING_DIR)/provider/cmd/${PROVIDER}/schema.json

pulumi:
	[ -x $(shell which pulumi) ] || curl -fsSL https://get.pulumi.com | sh
	
test: 
	@echo "Running Tests"
	cd provider && go test -v ./...

integration:
	@echo "Running integration tests"
	go test -v ./tests

release:
	@echo "Running release script..." 
	chmod +x release.sh 
	./release.sh
	
coverage: clean
	mkdir coverage && \
	cd provider && \
	echo "Installing gopherbadger" && go get -u github.com/jpoles1/gopherbadger && go install github.com/jpoles1/gopherbadger && \
	go test -v -vet=off ./... -coverprofile=../coverage/coverage.out && \
	go tool cover -html=../coverage/coverage.out -o ../coverage/coverage.html && \
	${GOPATH}/bin/gopherbadger -png=false -md=../README.md && \
	rm coverage.out && \
	go mod tidy

clean:
	rm ./coverage -rf
	rm -f ${PROVIDER}
	rm -rf $(GARBAGE)

lint:
	@echo "Installing golangci-lint" && go install github.com/golangci/golangci-lint/cmd/golangci-lint@v1.50.1
	for DIR in "provider" "sdk" "tests" "examples" ; do \
		cd $$DIR && golangci-lint run -c ../.golangci.yml --timeout 10m && cd ../ ; \
	done

go_sdk:: build
	rm -rf sdk/go
	pulumi package gen-sdk $(WORKING_DIR)/bin/$(PROVIDER) --language go

nodejs_sdk:: VERSION := $(shell pulumictl get version --language javascript)
nodejs_sdk:: build
	rm -rf sdk/nodejs
	pulumi package gen-sdk $(WORKING_DIR)/bin/$(PROVIDER) --language nodejs
	cd sdk/nodejs/ && \
		yarn install && \
		yarn run tsc && \
		cp ../../README.md ../../LICENSE package.json yarn.lock bin/ && \
		sed -i.bak 's/$${VERSION}/$(VERSION)/g' bin/package.json && \
		rm ./bin/package.json.bak

python_sdk:: PYPI_VERSION := $(shell pulumictl get version --language python)
python_sdk:: build
	rm -rf sdk/python
	pulumi package gen-sdk $(WORKING_DIR)/bin/$(PROVIDER) --language python
	cp README.md sdk/python/
	cd sdk/python/ && \
		python3 setup.py clean --all 2>/dev/null && \
		rm -rf ./bin/ ../python.bin/ && cp -R . ../python.bin && mv ../python.bin ./bin && \
		sed -i.bak -e 's/^VERSION = .*/VERSION = "$(PYPI_VERSION)"/g' -e 's/^PLUGIN_VERSION = .*/PLUGIN_VERSION = "$(VERSION)"/g' ./bin/setup.py && \
		rm ./bin/setup.py.bak && \
		cd ./bin && python3 setup.py build sdist


install:: install_nodejs_sdk
	cp $(WORKING_DIR)/bin/${PROVIDER} ${GOPATH}/bin

install_nodejs_sdk::
	-yarn unlink --cwd $(WORKING_DIR)/sdk/nodejs/bin
	yarn link --cwd $(WORKING_DIR)/sdk/nodejs/bin

install_python_sdk::
	cd sdk/python/bin && python3 setup.py install

install_go_sdk::
	#target intentionally blank
