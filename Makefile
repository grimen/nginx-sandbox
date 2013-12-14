
ifeq (luarocks,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "luarocks"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

all: build

start:
	./script/local-openresty-start

server:
	make start

proxy:
	make start

stop:
	./script/local-openresty-stop

open:
	open http://localhost:8080

benchmark:
	ab -c10 -n50000 http://localhost:8080

build:
	make build-pcre \
	&& make build-zlib \
	&& make build-openssl \
	&& make build-openresty \
	&& make build-luarocks

build-openresty:
	make clean-openresty \
	&& ./script/local-openresty-build

build-pcre:
	make clean-pcre \
	&& ./script/local-pcre-build

build-zlib:
	make clean-zlib \
	&& ./script/local-zlib-build

build-openssl:
	make clean-openssl \
	&& ./script/local-openssl-build

build-luarocks:
	make clean-luarocks \
	&& ./script/local-luarocks-build

clean:
	rm -rf ./vendor

clean-openresty:
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
	./script/local-luarocks $(RUN_ARGS)

.PHONY: start stop open benchmark build clean log clear
