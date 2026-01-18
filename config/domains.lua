local platform = require('utils.platform')

local options = {
   -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
   ssh_domains = {},

   -- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
   unix_domains = {},

   -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
   wsl_domains = {},
}

if platform.is_win then
   options.ssh_domains = {
      {
         name = 'ssh:wsl',
         remote_address = '127.0.0.1:2222',
         username = 'liuliang',
         multiplexing = 'None',
         default_prog = { 'bash', '-l' },
         assume_shell = 'Posix',
      },
   }

   options.wsl_domains = {
      {
         name = 'wsl:ubuntu-bash',
         distribution = 'Ubuntu',
         username = 'liuliang',
         default_cwd = '/home/liuliang',
         default_prog = { 'bash', '-l' },
      },
   }
end

return options
