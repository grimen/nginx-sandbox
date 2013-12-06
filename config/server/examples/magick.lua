
-- Source: http://leafo.net/posts/creating_an_image_server.html

-- Install deps (make luarocks don't work with `--` arguments):
--    ./script/luarocks-local install --server=http://rocks.moonscript.org magick

local secret = ngx.var.secret
local signature = ngx.var.signature
local size = ngx.var.size
local path = ngx.var.path
local ext = ngx.var.ext

local images_dir = 'images/' -- where images come from

local function return_not_found(msg)
  ngx.status = ngx.HTTP_NOT_FOUND
  ngx.header['Content-type'] = 'text/html'
  ngx.say(msg or 'not found')
  ngx.exit(0)
end

local function calculate_signature(str)
  return ngx.encode_base64(ngx.hmac_sha1(secret, str))
    :gsub('[+/=]', {['+'] = '-', ['/'] = '_', ['='] = ','})
    :sub(1,12)
end

local function assert_file_exists(filename)
  local file = io.open(filename)
  if not file then
    return_not_found('file not found: ' .. filename)
  end
  file:close()
end

local function assert_signature(signature, size, path)
  if signature == "nosignature" then
    return
  end

  if calculate_signature(size .. '/' .. path) ~= signature then
    return_not_found('invalid signature')
  end
end

-- ngx.say('<signature> = '..signature)
-- ngx.say('<size> = '..size)
-- ngx.say('<path> = '..path)

-- make sure url signature is valid
assert_signature(signature, size, path)

local src_filename = ngx.var.root .. '/' .. images_dir .. path
local dest_filename = ngx.var.cache .. '/' .. ngx.md5(size .. '/' .. path) .. '.' .. ext

-- make sure the file exists
assert_file_exists(src_filename)

-- ngx.say(src_filename)
-- ngx.say(dest_filename)
-- ngx.say(ngx.var.request_uri)

-- resize the image
local magick = require('magick')

magick.thumb(src_filename, size, dest_filename)

ngx.exec(ngx.var.request_uri)
