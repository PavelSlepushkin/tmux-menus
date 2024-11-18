#!/bin/sh

static_content() {
  # Be aware:
  #   'set -- \' creates a new set of parameters for menu_generate_part
  #   'set -- "$@" \' should be used when appending parameters

  set -- \
    0.0 M Left "Back to Main menu  <==" "main.sh" \
    0.0 S \
    0.0 C "t" "Toggle logging" "run-shell ~/.tmux/plugins/tmux-logging/scripts/toggle_logging.sh" \
    0.0 C "s" "Screen capture" "run-shell ~/.tmux/plugins/tmux-logging/scripts/screen_capture.sh" \
    0.0 C "a" "Save All history" "run-shell ~/.tmux/plugins/tmux-logging/scripts/save_complete_history.sh" \
    0.0 C "c" "Clear history" "run-shell ~/.tmux/plugins/tmux-logging/scripts/clear_history.sh" \

  menu_generate_part 1 "$@"

}

menu_name="tmux logging"

#  This script is assumed to have been placed in the items folder of
#  this repo, if not, you will need to change the path to dialog_handling.sh
#  below.

#  Full path to tmux-menux plugin
D_TM_BASE_PATH="$(realpath "$(dirname -- "$(dirname -- "$0")")")"
. "$D_TM_BASE_PATH"/scripts/dialog_handling.sh
