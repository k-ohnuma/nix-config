function fish_clipboard_copy_word
  set -l line (commandline)
  set -l cursor (commandline -C)

  set -l left (string sub -s 1 -l $cursor -- $line)
  set -l right (string sub -s (math $cursor + 1) -- $line)

  set -l left_word (string replace -r '^.*[[:space:]]' '' -- $left)
  set -l right_word (string replace -r '[[:space:]].*$' '' -- $right)
  set -l text "$left_word$right_word"

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
