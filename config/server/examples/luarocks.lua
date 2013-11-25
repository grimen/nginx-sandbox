
-- Example: LuaRocks
--
-- Nginx/Lua API: https://github.com/chaoslawful/lua-nginx-module
--

ngx.log(ngx.OK, 'luarocks.lua')

local rocks = require "luarocks.loader"
local md5 = require "md5"

local time = os.time()
local time_md5 = md5.sumhexa(time)

ngx.say(string.format("LuaRocks + md5 loaded. MD5('%s') = ", time), time_md5)

ngx.log(ngx.OK, data)
ngx.exit(ngx.HTTP_OK)
