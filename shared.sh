#!/bin/bash

# Colors
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
BLUE="\033[1;34m"
RESET="\033[0m"

linebreak() {
  local char="${1:-'-'}"
  local length="${2:-80}"

  # Use printf with seq for dynamic repetition
  printf -- "${char}%.0s" $(seq 1 "$length")
  echo
}

print_title() {
  local title="${1:-PVE script}"
  local longtitle="🚀  Welcome to the $title – Automated container/VM provisioning for Proxmox"
  local underline=$(linebreak "─" 100)

  echo -e "
    
██████╗ ██╗   ██╗███████╗                           
██╔══██╗██║   ██║██╔════╝                           
██████╔╝██║   ██║█████╗                             
██╔═══╝ ╚██╗ ██╔╝██╔══╝                             
██║      ╚████╔╝ ███████╗                           
╚═╝       ╚═══╝  ╚══════╝                           
                                                    
███████╗ ██████╗██████╗ ██╗██████╗ ████████╗███████╗
██╔════╝██╔════╝██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝
███████╗██║     ██████╔╝██║██████╔╝   ██║   ███████╗
╚════██║██║     ██╔══██╗██║██╔═══╝    ██║   ╚════██║
███████║╚██████╗██║  ██║██║██║        ██║   ███████║
╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝╚═╝        ╚═╝   ╚══════╝

$longtitle
$underline
"
}

log_step() {
  echo -e "${BLUE}$1  $2${RESET}"
}

log_success() {
  echo -e "${GREEN}✅  $1${RESET}"
}

log_warn() {
  echo -e "${YELLOW}⚠️  $1${RESET}"
}

fatal_error() {
  echo -e "${RED}❌  $1${RESET}"
  exit 1
}

ask_to_proceed() {
  local step_name="$1"
  read -rp "❓  Do you want to configure $step_name? [y/N]: " CONFIRM
  if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
    return 0  # Yes
  else
    log_warn "Skipped $step_name setup."
    return 1  # No
  fi
}
