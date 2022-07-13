---@param path string
---@return any
local function load(path)
    return dofile(minetest.get_modpath('minetest_transfer_tokens')
            .. '/' .. path)
end

---@type HttpApiTable
local httpApiTable = minetest.request_http_api()
if httpApiTable == nil then
    minetest.log('error','error to loading minetest http api. please check your secure.http_mods')
end

---@type ChatCommandBuilder
local chatcmdbuilder = load('libs/ChatCmdBuilder/chatcmdbuilder.lua')

---@type Config
local config = load('config.lua')
minetest.log('apiHost: ' .. config.apiHost)

---@type Api
local Api = load('api.lua')
local api = Api:new(httpApiTable, config.apiHost)

----------------------------------------------------------------------

local builder = chatcmdbuilder.register('token', {
    description = "operations related to tokens",
    privs = { interact = true }
})
builder:sub('address :username', function(name, username)
    api:getBlockchainAddressByUsername(username, function(address)
        local player = minetest.get_player_by_name(name)
        if address then
            minetest.chat_send_player(name, username .. '\'s address is '
                    .. address)
        else
            minetest.chat_send_player(name,
                    username .. '\'s address has not been bound')
        end
    end)
    return true, 'Looking for blockchain address of ' .. username
end)

