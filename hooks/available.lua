local http = require("http")
local json = require("json")
local semver = require("semver")

function PLUGIN:Available(ctx)
    local versions = {}
    local page = 1

    while true do
        local resp = http.get({
            url = "https://api.github.com/repos/canonical/spread/tags?per_page=100&page=" .. page,
            headers = { Accept = "application/vnd.github+json" },
        })
        if resp.status_code ~= 200 then
            error("fetching tags failed: HTTP " .. resp.status_code)
        end

        local tags = json.decode(resp.body)
        for _, tag in ipairs(tags) do
            if tag.name:match("^%d") then
                table.insert(versions, { version = tag.name })
            end
        end

        if #tags < 100 then
            break
        end
        page = page + 1
    end

    table.sort(versions, function(a, b)
        return semver.compare(a.version, b.version) > 0
    end)

    return versions
end
