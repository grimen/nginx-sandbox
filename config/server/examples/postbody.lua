local json = require 'cjson'
local Redis = require 'resty.redis'
local redis = Redis:new()

redis:set_timeout(1000) -- 1 sec

local ok, err = redis:connect('127.0.0.1', 6379)
if not ok then
  ngx.say('failed to connect: ', err)
  return
end

-- read POST body
ngx.req.read_body()

local args = ngx.req.get_post_args()
if not args then
  ngx.say('failed to get post args: ', err)
  return
end

local serialized_args = json.encode(args)

-- record it to redis
local res, err = redis:lpush('examples:postbody.lua', serialized_args)
if not res then
  ngx.say('failed to run rpush: ', err)
  return
else
  ngx.log(ngx.OK, 'redis:lpush ', 'examples:postbody.lua ', serialized_args)
  ngx.say('redis:lpush ', 'examples:postbody.lua ', serialized_args)
end

redis:close()

-- Test:
-- curl -v -XPOST -d "foo=1&bar=2" "http://localhost:8080/examples/postbody.lua"
