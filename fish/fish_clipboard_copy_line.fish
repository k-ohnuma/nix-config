function fish_clipboard_copy_line
  set -l text (commandline)

  if type -q pbcopy
    printf '%s' "$text" | pbcopy
  else if type -q wl-copy
    printf '%s' "$text" | wl-copy
  else if type -q xclip
    printf '%s' "$text" | xclip -selection clipboard
  else if type -q xsel
    printf '%s' "$text" | xsel --clipboard --input
  else
    echo "clipboard command not found: pbcopy, wl-copy, xclip, or xsel" >&2
    return 1
  end
end
