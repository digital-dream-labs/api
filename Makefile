PROTO_DIR = ./proto/*

protos: $(PROTO_DIR)
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