Router = {}
Router.routes = {}

function Router.register(method, path, handler)
    Router.routes[method .. ":" .. path] = handler
end

function Router.handle(req, res)
    local key = req.method .. ":" .. req.path
    local handler = Router.routes[key]

    if handler then
        handler(req, res)
    else
        res.writeHead(404, { ["Content-Type"] = "application/json" })
        res.send(json.encode({ error = "not found" }))
    end
end
