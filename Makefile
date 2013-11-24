
ifeq (luarocks,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "luarocks"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

all: build

start:
	./script/openresty-nginx-start

server:
	make start

proxy:
	make start

stop:
	./script/openresty-nginx-stop

open:
	open http://localhost:8080

benchmark:
	ab -c10 -n50000 http://localhost:8080

build:
	make build-pcre \
	&& make build-zlib \
	&& make build-openssl \
	&& make build-openresty-nginx \
	&& make build-luarocks

build-openresty-nginx:
	make clean-openresty-nginx \
	&& ./script/openresty-nginx-build

build-pcre:
	make clean-pcre \
	&& ./script/pcre-build

build-zlib:
	make clean-zlib \
	&& ./script/zlib-build

build-openssl:
	make clean-openssl \
	&& ./script/openssl-build

build-luarocks:
	make clean-luarocks \
	&& ./script/luarocks-build

clean:
	rm -rf ./vendor

clean-openresty-nginx:
	rm -rf ./vendor/ngx*

clean-pcre:
	rm -rf ./vendor/pcre*

clean-zlib:
	rm -rf ./vendor/zlib*

clean-openssl:
	rm -rf ./vendor/openssl*

clean-luarocks:
	rm -rf ./vendor/luarocks*

log:
	tail -f ./logs/*.log

log-access:
	tail -f ./logs/*access*.log

log-error:
	tail -f ./logs/*error*.log

clear:
	rm -f ./logs/* \
	&& rm -f ./cache/*

luarocks:
	./script/luarocks-local $(RUN_ARGS)

.PHONY: start stop open benchmark build clean log clear
