
-- Example: Luarocks

local rocks = require "luarocks.loader"
local md5 = require "md5"

local time = os.time()
local time_md5 = md5.sumhexa(time)

ngx.say(string.format("Luarocks + md5 loaded. MD5('%s') = ", time), time_md5)

ngx.log(ngx.OK, data)
ngx.exit(ngx.HTTP_OK)
