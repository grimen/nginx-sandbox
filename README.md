# NGINX-SANDBOX

_Nginx sandbox/playground for experiments with extra addons/modules._


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

**Within this sandbox/path: Stop Nginx:**

```bash
$ ./script/nginx-stop
```

**Ta-ta!**

```bash
$ open http://localhost:8080
```

QUOTE: "- Is this live? - Yes this is live. On localhost."


## License

Released under the MIT license. Copyright © Jonas Grimfelt
