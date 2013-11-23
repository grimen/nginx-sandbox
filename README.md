# NGINX-SANDBOX

_Nginx/OpenResty sandbox/playground - for experiments with building Nginx apps using Lua._

![nginx sandbox](http://cl.ly/image/080y0T3Y3f1Q/Nginx%20Sandbox.png)


## Build

**Sandboxed Nginx/OpenResty:**

```bash
nginx-sandbox$ make build
```

...this will take a while because all dependencies (`pcre`, `openssl`, `zlib`) are being compiled into sandbox as well (`./vendor/*`) for isolation reasons.

## Usage: Run

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


## Usage: Run as deamon

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


## Notes

The build scripts may contain *OS X only* operations. Should be simple to port it to POSIX though.


## License

Released under the MIT license. Copyright © Jonas Grimfelt
