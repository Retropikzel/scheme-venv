(import (scheme base)
        (scheme write)
        (scheme process-context)
        (retropikzel hello)
        (srfi :64))

(display "Compile test: ")
(hello)
(exit 0)
