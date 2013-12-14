
-- Example: Redis
--
-- Nginx/Lua API: https://github.com/chaoslawful/lua-nginx-module
-- Nginx/Redis API: https://github.com/agentzh/redis2-nginx-module
--

ngx.log(ngx.OK, 'redis.lua')

local Redis = require "resty.redis"
local redis = Redis:new()

redis:set_timeout(1000) -- 1 sec

-- or connect to a unix domain socket file listened
-- by a redis server:
--     local ok, err = redis:connect("unix:/path/to/redis.sock")

-- Docker env -> env -> defaults
local ADDR = os.getenv("REDIS_PORT_6379_TCP_ADDR") or os.getenv("REDIS_HOSTNAME") or '127.0.0.1'
local PORT = os.getenv("REDIS_PORT_6379_TCP_PORT") or os.getenv("REDIS_PORT") or 6379

local ok, err = redis:connect(ADDR, PORT)

if not ok then
  ngx.log(ngx.ERR, "failed to connect: ", err)
  ngx.log(ngx.ERR, "REDIS_PORT_6379_TCP_ADDR: ", os.getenv("REDIS_PORT_6379_TCP_ADDR"))
  ngx.log(ngx.ERR, "REDIS_PORT_6379_TCP_PORT: ", os.getenv("REDIS_PORT_6379_TCP_PORT"))
  ngx.log(ngx.ERR, "ADDR: ", ADDR)
  ngx.log(ngx.ERR, "PORT: ", PORT)
  ngx.say("failed to connect: ", err)
  return
end

ok, err = redis:set("dog", "an animal")
if not ok then
  ngx.log(ngx.ERR, "failed to set dog: ", err)
  ngx.say("failed to set dog: ", err)
  return
end

ngx.say("set result: ", ok)

local res, err = redis:get("dog")
if not res then
  ngx.log(ngx.ERR, "failed to get dog: ", err)
  ngx.say("failed to get dog: ", err)
  return
end

if res == ngx.null then
  ngx.log(ngx.OK, "dog not found.", err)
  ngx.say("dog not found.")
  return
end

ngx.log(ngx.OK, "dog: ", res)
ngx.say("dog: ", res)

redis:init_pipeline()
redis:set("cat", "Marry")
redis:set("horse", "Bob")
redis:get("cat")
redis:get("horse")

local results, err = redis:commit_pipeline()

if not results then
  ngx.log(ngx.ERR, "failed to commit the pipelined requests: ", err)
  ngx.say("failed to commit the pipelined requests: ", err)
  return
end

for i, res in ipairs(results) do
  if type(res) == "table" then
    if not res[1] then
      ngx.log(ngx.ERR, "failed to run command ", i, ": ", res[2])
      ngx.say("failed to run command ", i, ": ", res[2])
    else
      -- process the table value
    end
  else
    -- process the scalar value
  end
end

-- put it into the connection pool of size 100,
-- with 10 seconds max idle time
local ok, err = redis:set_keepalive(10000, 100)
if not ok then
  ngx.log(ngx.ERR, "failed to set keepalive: ", err)
  ngx.say("failed to set keepalive: ", err)
  return
end

-- or just close the connection right away:
local ok, err = redis:close()
-- if not ok then
--   ngx.log(ngx.ERR, "failed to close: ", err)
--   ngx.say("failed to close: ", err)
--   return
-- end
