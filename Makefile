all: test

build:
	go build ./...
	cd ./examples; \
	go build ./...

lint:
	@cd /tmp; \
	go get -v golang.org/x/lint/golint
	for file in $$(find . -name '*.go' | grep -v '\.pb\.go\|\.pb\.gw\.go\|examples\|pubsub\/aws\/awssub_test\.go' | grep -v 'server\/kit\/kitserver_pb_test\.go'); do \
		golint $${file}; \
		if [ -n "$$(golint $${file})" ]; then \
			exit 1; \
		fi; \
	done

vet:
	go vet ./...

test: lint vet
	go test -v ./...
	cd ./examples; \
	go test -v ./...

clean:
	go clean -i ./...

coverage:
	./coverage.sh --coveralls

.PHONY: \
	all \
	build \
	lint \
	vet \
	errcheck \
	test \
	clean \
	coverage
