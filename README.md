# NGINX-SANDBOX

_Nginx sandbox/playground for experiments with extra addons/modules._

![nginx sandbox](http://cl.ly/image/080y0T3Y3f1Q/Nginx%20Sandbox.png)

## Setup

**Sandboxed Nginx:**

```bash
$ ./script/nginx-build/nginx
```

**Optional: Sandboxed Nginx/OpenResty:**

```bash
$ ./script/nginx-build/nginx-openresty
```

**Optional/WIP: Specified 3rd-party Nginx addons:**

```bash
$ ./script/nginx-build/addons/<addon>
```


## Usage

**Within this sandbox/path: Start/Restart Nginx:**

```bash
$ ./script/nginx-start
```

**Ta-ta!**

```bash
$ open http://localhost:8080
```

*"- Is this live? - Yes this is live. On localhost."*

**Within this sandbox/path: Stop Nginx:**

```bash
$ ./script/nginx-stop
```

## License

Released under the MIT license. Copyright © Jonas Grimfelt
