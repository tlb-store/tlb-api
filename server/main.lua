print("API launched")

SetHttpHandler(function(req, res)
    if req.method == "GET" then
        Router.handle(req, res)
    else
        req.setDataHandler(function(body)
            local status, result = pcall(json.decode, body)
            req.body = status and result or {}
            Router.handle(req, res)
        end)
    end
end)
