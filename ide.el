(defun goto-window (target-buffer)
  (interactive
   (list (read-buffer-to-switch "Target buffer name: ")))
  (let
      ((cur-buf (buffer-name)))
    (message target-buffer)
    (other-window 1)
    (while (and
	    (not (equal target-buffer (buffer-name)))
	    (not (equal cur-buf (buffer-name))))
      (other-window 1))))


