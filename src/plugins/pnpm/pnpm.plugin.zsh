function load_pnpm_config() {
    export PNPM_HOME="${XDG_CACHE_HOME}/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
}

load_pnpm_config