function copyimage --description "Copy image file to clipboard"
    if test (count $argv) -ne 1
        echo "usage: copyimage <image-path>"
        return 1
    end

    set -l path $argv[1]

    if not test -f "$path"
        echo "copyimage: file not found: $path"
        return 1
    end

    osascript -l JavaScript -e '
      ObjC.import("AppKit")

      function run(argv) {
        const path = $.NSString.stringWithString(argv[0]).stringByStandardizingPath
        const image = $.NSImage.alloc.initWithContentsOfFile(path)

        if (!image) {
          throw new Error("failed to load image: " + argv[0])
        }

        const clipboard = $.NSPasteboard.generalPasteboard
        clipboard.clearContents

        if (!clipboard.writeObjects($.NSArray.arrayWithObject(image))) {
          throw new Error("failed to write image to clipboard")
        }
      }
' "$path"
end
