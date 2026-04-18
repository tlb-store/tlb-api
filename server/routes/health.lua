Router.register("GET", "/health", function(req, res)

    if not Middleware.auth(req, res) then return end

    Handler.Health(req, res)
end)
