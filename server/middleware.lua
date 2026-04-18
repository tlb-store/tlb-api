Middleware = {}

function Middleware.auth(req, res)
    local token = req.headers["authorization"]

    if token ~= Api.Config.Token then
        res.writeHead(401, { ["Content-Type"] = "application/json" })
        res.send(json.encode({ error = "unauthorized" }))
        return false
    end

    return true
end
