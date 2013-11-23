
all: build

build:
	make build-pcre && make build-zlib && make build-openssl && make build-nginx

build-nginx:
	./script/nginx-build

build-pcre:
	./script/pcre-build

build-zlib:
	./script/zlib-build

build-openssl:
	./script/openssl-build

build-luarocks:
	./script/luarocks-build

start:
	./script/nginx-start

stop:
	./script/nginx-stop

open:
	open http://localhost:8080

clean:
	rm -rf ./vendor

clean-nginx:
	rm -rf ./vendor/ngx*

clean-pcre:
	rm -rf ./vendor/pcre*

clean-zlib:
	rm -rf ./vendor/zlib*

clean-openssl:
	rm -rf ./vendor/openssl*

clean-luarocks:
	rm -rf ./vendor/luarocks*

benchmark:
	ab -c10 -n50000 http://127.0.0.1:8080/
