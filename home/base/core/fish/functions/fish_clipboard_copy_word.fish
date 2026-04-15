function fish_clipboard_copy_word
  set -l line (commandline)
  set -l cursor (commandline -C)

  set -l left (string sub -s 1 -l $cursor -- $line)
  set -l right (string sub -s (math $cursor + 1) -- $line)

  set -l left_word (string replace -r '^.*[[:space:]]' '' -- $left)
  set -l right_word (string replace -r '[[:space:]].*$' '' -- $right)

  printf '%s%s' $left_word $right_word | pbcopy
end
