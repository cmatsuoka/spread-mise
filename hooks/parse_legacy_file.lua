local file = require("file")

function PLUGIN:ParseLegacyFile(ctx)
    local line = file.read(ctx.filepath):match("^%s*([^\r\n]+)")
    return { version = line and line:match("^(.-)%s*$") }
end
