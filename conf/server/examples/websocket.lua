
-- Example: WebSocket
--
-- Nginx/Lua API: https://github.com/chaoslawful/lua-nginx-module
--

-- Source: https://github.com/agentzh/lua-resty-websocket
-- Debug: http://www.websocket.org/echo.html

ngx.log(ngx.OK, 'websocket.lua')

local WebSocket = require "resty.websocket.server"

local ws, err = WebSocket:new {
  timeout = 10 * 1000,
  max_payload_len = 65535,
}

if not ws then
  ngx.log(ngx.ERR, "failed to new websocket: ", err)
  return ngx.exit(444)
end

-- Send String

bytes, err = ws:send_text("Hello world")
if not bytes then
  ngx.log(ngx.ERR, "failed to send a text frame: ", err)
  return ngx.exit(444)
end

-- Send Binary

bytes, err = ws:send_binary("blah blah blah...")
if not bytes then
  ngx.log(ngx.ERR, "failed to send a binary frame: ", err)
  return ngx.exit(444)
end

-- Loop
while true do
  local data, typ, err = ws:recv_frame()

  ngx.log(ngx.ERR, typ, ' | ', data, ' | ', err)

  -- ngx.log(ngx.OK, "data", data)

  if ws.fatal then
    ngx.log(ngx.ERR, "failed to receive frame: ", err)
    return ngx.exit(444)
  end

  if not data then
    ngx.log(ngx.ERR, "failed to receive a frame: ", err)
    return ngx.exit(444)

  elseif typ == "close" then
    break

  elseif typ == "ping" then
    local bytes, err = ws:send_pong()
    if not bytes then
      ngx.log(ngx.ERR, "failed to send pong: ", err)
      return ngx.exit(444)
    end

  elseif typ == "pong" then
    ngx.log(ngx.INFO, "pong")

  elseif typ == "text" then
    local bytes, err = ws:send_text(data)
    if not bytes then
      ngx.log(ngx.ERR, "failed to send text: ", err)
      return ngx.exit(444)
    else
      ngx.log(ngx.ERR, "send_text", ' | ', data)
    end

  elseif typ == "binary" then
    local bytes, err = ws:send_binary(data)
    if not bytes then
      ngx.log(ngx.ERR, "failed to send binary: ", err)
      return ngx.exit(444)
    else
      ngx.log(ngx.ERR, "send_binary", ' | ', data)
    end

  elseif typ == "close" then
    local bytes, err = ws:send_close(1000, "close")
    if not bytes then
      ngx.log(ngx.ERR, "failed to send the close frame: ", err)
      return
    else
      ngx.log(ngx.ERR, "send_close", ' | ', data)
    end

    local code = err
    ngx.log(ngx.INFO, "closing with status code ", code, " and message ", data)
    return

  else
    -- local bytes, err = ws:send_text(data)
    -- if not bytes then
    --   ngx.log(ngx.ERR, "failed to send text: ", err)
    --   return ngx.exit(444)
    -- else
    --   ngx.log(ngx.ERR, "send_close", ' | ', data)
    -- end

  end

end

