#! /usr/bin/env bash

left_pane_id=$(wezterm cli get-pane-direction left)
if [ -z $left_pane_id ]; then
  left_pane_id=$(wezterm cli split-pane --left --cells 30)
fi

left_program=$(wezterm cli list | awk -v pane_id=$left_pane_id '$3==pane_id { print $6 }')
if [[ ${left_program,,} != *"yazi"* ]]; then
  rm -r /tmp/yazi_tree;
  cp -r $HOME/.config/yazi /tmp/yazi_tree;
  echo -e "\n[manager]\nratio = [ 0, 8, 0 ]\n" >> /tmp/yazi_tree/yazi.toml;
  echo -e "\nfunction Status:render() return {} end\nlocal old_manager_render = Manager.render\nfunction Manager:render(area)\n\treturn old_manager_render(self, ui.Rect { x = area.x, y = area.y, w = area.w, h = area.h + 1 })\nend\n" >> /tmp/yazi_tree/init.lua;

  echo "echo \"chosen_file=\\\$(YAZI_CONFIG_HOME=/tmp/yazi_tree yazi --chooser-file /dev/stdout); if [ -n \\\$chosen_file ]; then printf \\\"%s %s %s\\\" \\\$'\e :o' \\\"\\\$chosen_file\\\" \\\$'\r' | wezterm cli send-text --pane-id $WEZTERM_PANE --no-paste; fi\" | bash; exit" | wezterm cli send-text --pane-id $left_pane_id --no-paste
fi

wezterm cli activate-pane-direction left

