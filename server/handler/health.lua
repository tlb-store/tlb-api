Handler = Handler or {}

function Handler.Health(req, res)
    res.writeHead(200, { ["Content-Type"] = "application/json" })
    res.send(json.encode({
        status = "ok",
        message = "API FiveM running"
    }))
end
