local wezterm = require('wezterm')

---@class Config
---@field options table
---@field _seen table
local Config = {}
Config.__index = Config

---Initialize Config
---@return Config
function Config:init()
   local options = {}
   if wezterm.config_builder then
      options = wezterm.config_builder()
      if options.set_strict_mode then
         options:set_strict_mode(true)
      end
   end
   local config = setmetatable({ options = options, _seen = {} }, self)
   return config
end

---Append to `Config.options`
---@param new_options table new options to append
---@return Config
function Config:append(new_options)
   for k, v in pairs(new_options) do
      if self._seen[k] then
         wezterm.log_warn(
            'Duplicate config option detected: ',
            { old = self.options[k], new = new_options[k] }
         )
         goto continue
      end
      self._seen[k] = true
      self.options[k] = v
      ::continue::
   end
   return self
end

return Config
