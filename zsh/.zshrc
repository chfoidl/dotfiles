source /home/chfoidl/.config/zsh/zshrc

# pnpm
export PNPM_HOME="/home/chfoidl/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end