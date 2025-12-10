.PHONY: generate-client
generate-client: openapi.json
	rm -rf ./src/libs/api-clients/generated/*
	npx openapi-generator-cli generate -i openapi.json -g typescript-fetch -o src/libs/api-clients/generated
	rm openapi.json

openapi.json:
	curl http://localhost:9999/api/openapi.json > openapi.json
