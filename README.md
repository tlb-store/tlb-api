# TLB API

Standalone API resource with routes.

## Features

- Lightweight HTTP routing.
- Token-based authentication.
- Health check endpoint.
- Support for GET, POST, PUT, PATCH, DELETE.

## Configuration

The API configuration is located in `server/config.lua`.

```lua
Api.Config.Token = "your-secure-token"
```

## Authentication

All requests (except those specifically made public in routes) require an `Authorization` header matching the configured token.

**Header:** `Authorization: <token>`

## Endpoints

### Health Check

- **URL:** `/tlb-api/health`
- **Method:** `GET`
- **Auth required:** Yes
- **Success Response:**
  - **Code:** 200
  - **Content:** `{ "status" : "ok", "message" : "API FiveM running" }`

## Developer Guide

### 1. Registering a Route

Routes should be defined in the `server/routes/` directory. You can use any standard HTTP method.

```lua
-- Simple GET route
Router.register("GET", "/ping", function(req, res)
    res.send(json.encode({ message = "pong" }))
end)

-- POST route with data
Router.register("POST", "/data", function(req, res)
    -- Your logic here
end)
```

### 2. Handling Request Data

#### Authentication
To protect a route, check the `Middleware.auth` status:

```lua
Router.register("GET", "/protected", function(req, res)
    if not Middleware.auth(req, res) then 
        return -- auth helper already sends 401 response
    end
    
    res.send(json.encode({ data = "Secret stuff" }))
end)
```

#### JSON Body (POST/PUT)
Request bodies are automatically decoded and available in `req.body`:

```lua
Router.register("POST", "/user", function(req, res)
    local username = req.body.username
    local age = req.body.age
    
    print("Creating user: " .. username)
    res.send(json.encode({ status = "created" }))
end)
```

#### Headers
Access any standard or custom header via `req.headers`:

```lua
local userAgent = req.headers["user-agent"]
```

### 3. Organizing with Handlers

For complex logic, keep your routes clean by using the `Handler` table.

1. Define the logic in `server/handler/user.lua`:
```lua
Handler = Handler or {}

function Handler.GetUser(req, res)
    -- Database fetch logic...
    res.send(json.encode({ id = 1, name = "Ryan" }))
end
```

2. Register the route in `server/routes/user.lua`:
```lua
Router.register("GET", "/user", function(req, res)
    if not Middleware.auth(req, res) then return end
    Handler.GetUser(req, res)
end)
```

## Project Structure

- `fxmanifest.lua`: Resource metadata and file loading order.
- `server/config.lua`: API tokens and settings.
- `server/main.lua`: Entry point and HTTP server event handling.
- `server/router.lua`: The routing engine.
- `server/middleware.lua`: Authentication and security layers.
- `server/handler/`: Logic controllers for your endpoints.
- `server/routes/`: Route definitions connecting paths to handlers.

