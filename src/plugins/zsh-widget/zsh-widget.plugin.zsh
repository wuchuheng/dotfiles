#!/usr/bin/env zsh

# 1. Define Docker proxy configuration directory
DOCKER_CONFIG_DIR="$HOME/.docker"
DOCKER_CONFIG_FILE="$DOCKER_CONFIG_DIR/config.json"

# 2. Define the function to set Docker proxy
function docker_set_proxy() {
    # 2.1 Handle input validation
    if [[ $# -ne 1 ]]; then
        echo "Usage: docker_set_proxy <proxy_url>"
        echo "Example: docker_set_proxy http://127.0.0.1:7890"
        return 1
    }

    # 2.2 Create Docker config directory if it doesn't exist
    mkdir -p "$DOCKER_CONFIG_DIR"

    # 2.3 Create or update Docker config with proxy settings
    local proxy_url="$1"
    local config_content='{
  "proxies": {
    "default": {
      "httpProxy": "'$proxy_url'",
      "httpsProxy": "'$proxy_url'",
      "noProxy": "localhost,127.0.0.1"
    }
  }
}'
    echo $config_content > "$DOCKER_CONFIG_FILE"
    echo "Docker proxy set to: $proxy_url"
    
    # 2.4 Restart Docker daemon if running
    if command -v docker &> /dev/null; then
        if [[ "$(uname)" == "Darwin" ]]; then
            echo "Please restart Docker Desktop for changes to take effect"
        else
            echo "Restarting Docker daemon..."
            sudo systemctl restart docker
        fi
    fi
}

# 3. Define function to remove Docker proxy
function docker_remove_proxy() {
    # 3.1 Remove proxy settings from config
    if [[ -f "$DOCKER_CONFIG_FILE" ]]; then
        echo '{}' > "$DOCKER_CONFIG_FILE"
        echo "Docker proxy settings removed"
        
        # 3.2 Restart Docker daemon if running
        if command -v docker &> /dev/null; then
            if [[ "$(uname)" == "Darwin" ]]; then
                echo "Please restart Docker Desktop for changes to take effect"
            else
                echo "Restarting Docker daemon..."
                sudo systemctl restart docker
            fi
        fi
    else
        echo "No Docker proxy settings found"
    fi
}

# 4. Define function to show current Docker proxy settings
function docker_show_proxy() {
    if [[ -f "$DOCKER_CONFIG_FILE" ]]; then
        echo "Current Docker proxy settings:"
        cat "$DOCKER_CONFIG_FILE"
    else
        echo "No Docker proxy settings found"
    fi
}