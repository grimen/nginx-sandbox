# NGINX-SANDBOX

_[`Nginx/OpenResty`](http://openresty.org) sandbox/playground - for experiments with building [`Nginx`](http://nginx.org) apps using [`Lua`](http://lua.org)._

![nginx sandbox](http://cl.ly/image/080y0T3Y3f1Q/Nginx%20Sandbox.png)


## Features

The build script will install local/sandboxed versions of:

* `ngx_openresty`
    * `lua` - via openresty
    * `pcre`
    * `zlib`
    * `openssl`
* `luarocks` - optional

The default Nginx setup contains mainly:

* Default Nginx configs - with comments/documentation
* Example code:
    * Lua basic demo
    * Lua/LuaRocks module demo
    * Lua/WebSockets ping/pong demo - incl. client HTML page
    * Lua/Redis read/write demo


## Build

**Sandboxed Nginx/OpenResty:**

```bash
nginx-sandbox$ make build
```

...this will take a while because all dependencies (`pcre`, `openssl`, `zlib`, ...) are being compiled into sandbox as well (`./vendor/*`) for isolation reasons.


## Usage: Run Nginx

If `nginx.conf` contains directive `daemon off;`.

**Start Nginx/OpenResty:**

```bash
nginx-sandbox$ make start
```

**Ta-ta!**

```bash
nginx-sandbox$ open http://localhost:8080
```

*"- Is this live? - Yes this is live. On localhost."*

**Stop Nginx/OpenResty:**

`CTRL + C` / `SIGINT`


## Usage: Run Nginx as daemon

If `nginx.conf` contains directive `daemon on;`.

**Start/Restart Nginx:**

```bash
nginx-sandbox$ make start
```

**Ta-ta!**

```bash
nginx-sandbox$ open http://localhost:8080
```

**Stop Nginx/OpenResty:**

```bash
nginx-sandbox$ make stop
```


## Advanced: Install additional Lua modules

Install additional local/sandboxed *Lua modules* via local/sandboxed [`LuaRocks`](http://luarocks.org):

```bash
nginx-sandbox$ make luarocks install md5
...
nginx-sandbox$ make luarocks list
...
```

*NOTE: `make luarocks` is passing any succeding arguments to the sandboxed `luarocks` binary, so all arguments that work with the original will work here too.*


## Notes

The build scripts may contain *OS X only* operations. Should be simple to port it to POSIX though.

Find development notes in [`NOTES`](https://github.com/grimen/nginx-sandbox/blob/master/NOTES).


## Todo

See [`TODO`](https://github.com/grimen/nginx-sandbox/blob/master/TODO).


## License

Released under the MIT license. Copyright © [Jonas Grimfelt](https://github.com/grimen)

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/grimen/nginx-sandbox/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
