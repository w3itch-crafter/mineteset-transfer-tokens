---@class Api
---@field apiHost string
---@field httpApiTable HttpApiTable
local Api = {}

---@param httpApiTable HttpApiTable
---@param apiHost string
---@return Api
function Api:new(httpApiTable, apiHost)
    local o = { apiHost = apiHost, httpApiTable = httpApiTable }
    setmetatable(o, self)
    self.__index = self
    return o
end

---@param username string
---@param callback fun(address: string|nil): void
---@return void
function Api:getBlockchainAddressByUsername(username, callback)
    ---@type HttpRequestCallback
    local handler = function(response)
        if response.completed and response.succeeded then
            local parsed = minetest.parse_json(response.data)
            callback(parsed.address)
        else
            callback(nil)
        end
    end
    self.httpApiTable.fetch({
        url = self.apiHost .. '/users/get-blockchain-address-by-username',
        method = 'POST',
        data = minetest.write_json({
            username = username
        }),
        extra_headers = {"Content-Type: application/json"}
    }, handler)
end


return Api