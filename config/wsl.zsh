# WSL-specific configuration

# Check if running on WSL
if [[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
  # WSL2 Display settings for X11 forwarding
  export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
  export LIBGL_ALWAYS_INDIRECT=1
  
  # Use Windows SSH and SSH-add for 1Password integration
  alias ssh='ssh.exe'
  alias ssh-add='ssh-add.exe'
  
  # VS Code IPC socket
  socket=$(ls -1t /run/user/$UID/vscode-ipc-*.sock 2> /dev/null | head -1)
  [[ -n "$socket" ]] && export VSCODE_IPC_HOOK_CLI=${socket}
  
  # Windows interop settings
  export BROWSER='/mnt/c/Program Files/Google/Chrome/Application/chrome.exe'
  
  # Path to Windows home directory
  export WINHOME="/mnt/c/Users/$(cmd.exe /c 'echo %USERNAME% 2> /dev/null' | tr -d '\r')"
  
  # Useful aliases for WSL
  alias explorer='explorer.exe'
  alias code='code.exe'
  alias open='explorer.exe'
  
  # Copy/paste integration
  alias pbcopy='clip.exe'
  alias pbpaste='powershell.exe Get-Clipboard'
fi