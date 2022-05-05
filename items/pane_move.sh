#!/bin/sh
#
#   Copyright (c) 2022: Jacob.Lundqvist@gmail.com
#   License: MIT
#
#   Part of https://github.com/jaclu/tmux-menus
#
#   Version: 1.2.10 2022-04-21
#
#   Move a pane
#
#   Types of menu item lines.
#
#   1) An item leading to an action
#          "Description" "In-menu key" "Action taken when it is triggered"
#
#   2) Just a line of text
#      You must supply two empty strings, in order for the
#      menu logic to interpret it as a full menu line item.
#          "Some text to display" "" ""
#
#   3) Separator line
#      This is a proper graphical separator line, without any label.
#          ""
#
#   4) Labeled separator line
#      Not perfect, since you will have at least one space on each side of
#      the labeled separator line, but using something like this and carefully
#      increase the dashes until you are just below forcing the menu to just
#      grow wider, seems to be as close as it gets.
#          "#[align=centre]-----  Other stuff  -----" "" ""
#
#
#   All but the last line in the menu, needs to end with a continuation \
#   White space after this \ will cause the menu to fail!
#   For any field containing no spaces, quotes are optional.
#

# shellcheck disable=SC1007
CURRENT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
SCRIPT_DIR="$(dirname "$CURRENT_DIR")/scripts"

# shellcheck disable=SC1091
. "$SCRIPT_DIR/utils.sh"


# shellcheck disable=SC2154
tmux display-menu  \
     -T "#[align=centre] Move Pane "  \
     -x "$menu_location_x" -y "$menu_location_y"  \
     \
     "Main menu      -->"  Home  "run-shell $CURRENT_DIR/main.sh"  \
     "Handling Pane  -->"  Left  "run-shell $CURRENT_DIR/panes.sh" \
     "" \
     "    Move to other win/ses"  m  "choose-tree -Gw 'run-shell \"$SCRIPT_DIR/relocate_pane.sh  P M %%\"'" \
     "#{?pane_marked_set,,-}    Swap current pane with marked"  s  swap-pane  \
     "<P> Swap pane with prev"        \{  "swap-pane -U ; run-shell \"$CURRENT_DIR/pane_move.sh\"" \
     "<P> Swap pane with next"        \}  "swap-pane -D ; run-shell \"$CURRENT_DIR/pane_move.sh\"" \
     "" \
     "<P> Break pane to a new window"  ! "run-shell $SCRIPT_DIR/break_pane.sh" \
    "" \
     "Help  -->"  H  "run-shell \"$CURRENT_DIR/help.sh $CURRENT_DIR/pane_move.sh\""
