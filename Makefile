PROTO_DIR = ./proto/*

.PHONY: protos proto

legacy-protos: $(PROTO_DIR)
	for dir in $^ ; do mkdir -p go/$$(echo $${dir}pb | sed 's/proto\///') ; protoc \
		-I ${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
		-I ${GOPATH}/src/github.com/golang/protobuf/ptypes/struct \
		-I $${dir} \
		--proto_path=. \
		--go_out=plugins=grpc,paths=source_relative:./go/$$(echo $${dir}pb | sed 's/proto\///') \
		--csharp_out=./csharp/$$(echo $${dir}pb | sed 's/proto\///') \
		--python_out=./python/$$(echo $${dir}pb | sed 's/proto\///') \
		--cpp_out=./cpp/$$(echo $${dir}pb | sed 's/proto\///') \
		--js_out=./javascript/$$(echo $${dir}pb | sed 's/proto\///') \
		$${dir}/*.proto \
		--grpc-gateway_out=paths=source_relative:./go/$$(echo $${dir}pb | sed 's/proto\///') ; done

# protos: bin/protoc bin/protoc-gen-go bin/protobuf
# 	@./scripts/gen-proto-stubs walk_files "proto"

# Generates all protobuf helper files then generates code from proto file passed in
proto: go.mod bin/protoc bin/protoc-gen-go bin/protobuf
	@./scripts/gen-proto-stubs gen_proto_stubs $(dir) $(file)

# make a stubbed go.mod
bin/go.mod:
	@echo "// Hey, go mod, keep out!" > bin/go.mod

# download protoc
bin/protoc: bin/go.mod scripts/get-protoc 
	@./scripts/get-protoc bin/protoc

# install protoc
bin/protoc-gen-go:
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest

# Unzip protobuf helper files to bin
bin/protobuf: bin/go.mod scripts/get-protoc-extras
	@./scripts/get-protoc-extras bin/protobuf


# for dir in $^ ;do mkdir -p go/$$(echo $${dir}pb | sed 's/proto\///') ; protoc \
# 	-I ${GOPATH}/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
# 	-I ${GOPATH}/src/github.com/golang/protobuf/ptypes/struct \
# 	-I $${dir} \
# 	--proto_path=. \
# 	--go-grpc_out=grpc,paths=source_relative:./go/$$(echo $${dir}pb | sed 's/proto\///') \
# 	--csharp_out=./csharp/$$(echo $${dir}pb | sed 's/proto\///') \
# 	--python_out=./python/$$(echo $${dir}pb | sed 's/proto\///') \
# 	--cpp_out=./cpp/$$(echo $${dir}pb | sed 's/proto\///') \
# 	--js_out=./javascript/$$(echo $${dir}pb | sed 's/proto\///') \
# 	$${dir}/*.proto \
# 	--grpc-gateway_out=paths=source_relative:./go/$$(echo $${dir}pb | sed 's/proto\///') ; done

