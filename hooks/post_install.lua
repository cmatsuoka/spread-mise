local cmd = require("cmd")
local file = require("file")
local log = require("log")

function PLUGIN:PostInstall(ctx)
    local bin = file.join_path(ctx.rootPath, "spread")
    local version = ctx.runtimeVersion

    if not version:match("^[%w%._%-]+$") then
        error("refusing to build unexpected version: " .. version)
    end

    log.info("building spread", version)
    cmd.exec("go install github.com/canonical/spread/cmd/spread@" .. version, {
        env = {
            GOBIN = ctx.rootPath,
            CGO_ENABLED = "0",
        },
        timeout = 600,
    })

    if not file.exists(bin) then
        error("spread was not installed to " .. bin)
    end
end
