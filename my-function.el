(defun shadowmydx-double-pare ()
  (interactive)
  (insert "()")
  (goto-char (- (point) 1)))
(global-set-key (kbd "(") 'shadowmydx-double-pare)

(defun shadowmydx-double-quote ()
  (interactive)
  (insert "\"\"")
  (goto-char (- (point) 1)))
(global-set-key (kbd "\"") 'shadowmydx-double-quote)


;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.

(setq shadowmydx-current-background (face-attribute 'default :background))
(setq shadowmydx-align-pare-background "cyan")
(defmacro shadowmydx-move (move-motion target)
  (cond ((= 1 (eval move-motion))
	 (list 'decf target))
	(t (list 'incf target))))

(defun shadowmydx-search-pair-pare (cur-pos start-count move-1 move-2)
  (shadowmydx-move move-1 cur-pos)
  (while (and (> start-count 0) (> cur-pos 0) (< cur-pos (point-max)))
    (cond ((equal "(" (buffer-substring cur-pos (+ 1 cur-pos)))
	   (shadowmydx-move move-1 start-count))
	  ((equal ")" (buffer-substring cur-pos (+ 1 cur-pos)))
	   (shadowmydx-move move-2 start-count)))
    (shadowmydx-move move-1 cur-pos))
  (shadowmydx-move move-2 cur-pos))(point)

(shadowmydx-search-pair-pare 902 1 0 1)
(buffer-substring 902 909)


(defun shadowmydx-change-pare-style (start-pos end-pos style)
  (let ((inhibit-modification-hooks t))
    (make-face 'temp-face)
    (set-face-background 'temp-face style)
    (put-text-property start-pos end-pos 'face 'temp-face)))

(defun shadowmydx-detect-if-a-right-pare ()
  )


