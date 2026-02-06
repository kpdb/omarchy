echo "Migrate deprecated windowrulev2 to windowrule with match: syntax for Hyprland 0.53+"

# Skip if no windowrulev2 lines exist in user's hypr config (including commented-out lines)
if ! grep -rq "windowrulev2" ~/.config/hypr/ 2>/dev/null; then
  exit 0
fi

# Process each file under ~/.config/hypr/ that contains windowrulev2
for conf_file in $(grep -rl "windowrulev2" ~/.config/hypr/ 2>/dev/null); do
  # Step 1: Replace 'windowrulev2' keyword with 'windowrule' (including commented lines)
  sed -Ei 's/windowrulev2/windowrule/g' "$conf_file"

  # Step 2: Convert old matchers to match: syntax
  # Run anchor-stripping patterns first (^(...)$), then generic catch-alls

  # class: -> match:class (strip ^()$ anchors first, then handle bare class:)
  sed -Ei 's/,\s*class:\^\(([^)]+)\)\$/, match:class \1/g' "$conf_file"
  sed -Ei 's/,\s*class:([^,]+)/, match:class \1/g' "$conf_file"

  # title: -> match:title
  sed -Ei 's/,\s*title:\^\(([^)]+)\)\$/, match:title \1/g' "$conf_file"
  sed -Ei 's/,\s*title:([^,]+)/, match:title \1/g' "$conf_file"

  # initialClass: -> match:initial_class
  sed -Ei 's/,\s*initialClass:\^\(([^)]+)\)\$/, match:initial_class \1/g' "$conf_file"
  sed -Ei 's/,\s*initialClass:([^,]+)/, match:initial_class \1/g' "$conf_file"

  # initialTitle: -> match:initial_title
  sed -Ei 's/,\s*initialTitle:\^\(([^)]+)\)\$/, match:initial_title \1/g' "$conf_file"
  sed -Ei 's/,\s*initialTitle:([^,]+)/, match:initial_title \1/g' "$conf_file"

  # tag: -> match:tag
  sed -Ei 's/,\s*tag:([^,]+)/, match:tag \1/g' "$conf_file"

  # xwayland: -> match:xwayland
  sed -Ei 's/,\s*xwayland:([^,]+)/, match:xwayland \1/g' "$conf_file"

  # floating: -> match:float
  sed -Ei 's/,\s*floating:([^,]+)/, match:float \1/g' "$conf_file"

  # fullscreen: (as matcher) -> match:fullscreen
  sed -Ei 's/,\s*fullscreen:([^,]+)/, match:fullscreen \1/g' "$conf_file"

  # pinned: -> match:pin
  sed -Ei 's/,\s*pinned:([^,]+)/, match:pin \1/g' "$conf_file"

  # focus: -> match:focus
  sed -Ei 's/,\s*focus:([^,]+)/, match:focus \1/g' "$conf_file"

  # workspace: -> match:workspace
  sed -Ei 's/,\s*workspace:([^,]+)/, match:workspace \1/g' "$conf_file"

  # onworkspace: -> match:onworkspace
  sed -Ei 's/,\s*onworkspace:([^,]+)/, match:onworkspace \1/g' "$conf_file"

  # Step 3: Append "on" to bare boolean rules that require it in the new syntax
  # These rules had no arguments in old windowrulev2 and need "on" in the new format
  # Also match commented lines (# windowrule = ...)
  sed -Ei 's/^([[:space:]]*(#\s*)?windowrule = )(float)(,)/\1\3 on\4/' "$conf_file"
  sed -Ei 's/^([[:space:]]*(#\s*)?windowrule = )(tile)(,)/\1\3 on\4/' "$conf_file"
  sed -Ei 's/^([[:space:]]*(#\s*)?windowrule = )(center)(,)/\1\3 on\4/' "$conf_file"
  sed -Ei 's/^([[:space:]]*(#\s*)?windowrule = )(pin)(,)/\1\3 on\4/' "$conf_file"
  sed -Ei 's/^([[:space:]]*(#\s*)?windowrule = )(maximize)(,)/\1\3 on\4/' "$conf_file"
  sed -Ei 's/^([[:space:]]*(#\s*)?windowrule = )(fullscreen)(,)/\1\3 on\4/' "$conf_file"

  # Step 4: Rename deprecated rule names to their new equivalents
  # Also match commented lines (# windowrule = ...)
  sed -Ei 's/^([[:space:]]*(#\s*)?windowrule = )nofocus(,)/\1no_focus on\3/' "$conf_file"
  sed -Ei 's/^([[:space:]]*(#\s*)?windowrule = )noblur(,)/\1no_blur on\3/' "$conf_file"
  sed -Ei 's/^([[:space:]]*(#\s*)?windowrule = )noshadow(,)/\1no_shadow on\3/' "$conf_file"
  sed -Ei 's/^([[:space:]]*(#\s*)?windowrule = )noborder(,)/\1border_size 0\3/' "$conf_file"
  sed -Ei 's/^([[:space:]]*(#\s*)?windowrule = )noanim(,)/\1no_anim on\3/' "$conf_file"
  sed -Ei 's/^([[:space:]]*(#\s*)?windowrule = )nodim(,)/\1no_dim on\3/' "$conf_file"
  sed -Ei 's/^([[:space:]]*(#\s*)?windowrule = )dimaround(,)/\1dim_around on\3/' "$conf_file"
  sed -Ei 's/^([[:space:]]*(#\s*)?windowrule = )stayfocused(,)/\1stay_focused on\3/' "$conf_file"
  sed -Ei 's/^([[:space:]]*(#\s*)?windowrule = )keepaspectratio(,)/\1keep_aspect_ratio on\3/' "$conf_file"
  sed -Ei 's/^([[:space:]]*(#\s*)?windowrule = )forceinput(,)/\1force_input on\3/' "$conf_file"
  sed -Ei 's/^([[:space:]]*(#\s*)?windowrule = )suppressevent(,)/\1suppress_event\3/' "$conf_file"
  sed -Ei 's/^([[:space:]]*(#\s*)?windowrule = )idleinhibit(,)/\1idle_inhibit\3/' "$conf_file"

  # Step 5: Trim trailing whitespace from match values
  sed -Ei 's/[[:space:]]+$//' "$conf_file"
done
