
-- http://hveem.no/about

local data = '[app.lua]: Hello world!'

ngx.header.content_type = 'text/html';
ngx.status = 200

ngx.log(ngx.OK, data)

-- ngx.say(ngx.var.root)
ngx.say(data)

ngx.exit(ngx.HTTP_OK)
