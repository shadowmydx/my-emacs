(defun shadowmydx-get-word ()
  (let ((current-point (point)))
    (let ((start-point (+ current-point
			  (save-excursion
			    (skip-chars-backward "A-Za-z"))))
	  (end-point (+ current-point
			(save-excursion
			  (skip-chars-forward "A-Za-z")))))
      (buffer-substring start-point end-point))))

(defun shadowmydx-parse-word ()
  (interactive)
  (let ((current-word (shadowmydx-get-word))
	(load-pop (popup-tip "hello")))
    (popup-delete load-pop)
    (popup-tip current-word)))
sdfe sfefe sfsd
