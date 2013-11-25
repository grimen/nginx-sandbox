
-- Example: Hello
--
-- Nginx/Lua API: https://github.com/chaoslawful/lua-nginx-module
--

ngx.log(ngx.ERR, 'hello.lua')

local cjson = require "cjson"

local time = os.time()

local params = ngx.req.get_uri_args() or {}
local x = params['x'] or ''

ngx.log(ngx.OK, cjson.encode(params))

local data = '['..time..'/'..x..']: Hello world!'

ngx.header.content_type = 'text/plain';
ngx.status = 200

ngx.log(ngx.OK, data)

-- ngx.say(ngx.var.root)
-- ngx.say(ngx.var.prefix)
ngx.say(data)
-- ngx.flush(true)

ngx.exit(ngx.HTTP_OK)
