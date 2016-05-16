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

;(shadowmydx-search-pair-pare 902 1 0 1)
;(buffer-substring 902 909)


(defun shadowmydx-change-pare-style (start-pos end-pos style)
  (let ((inhibit-modification-hooks t))
    (make-face 'temp-face)
    (set-face-background 'temp-face style)
    (put-text-property start-pos end-pos 'face 'temp-face)))
;(shadowmydx-change-pare-style 1519 1520 "cyan")
;(shadowmydx-change-pare-style 1500 1512 shadowmydx-current-background)

(setq shadowmydx-current-pos (point))
(setq shadowmydx-colored-point ())
(defmacro shadowmydx-append-to (target-list target-item)
  (if (not (eval target-list))
      (list 'setq target-list (list 'cons target-item ()))
    (list 'setq target-list (list 'cons target-item target-list))))
(defmacro shadowmydx-pop-item (target-list)
  (list 'let (list (list 'head (list 'car target-list)))(list 'setq target-list (list 'cdr target-list)) 'head))

(defun shadowmydx-detect-if-a-pare ()
  (interactive)
  (if (not (= shadowmydx-current-pos (point)))
      (progn
	(setq shadowmydx-current-pos (point))
	(let ((delete-pos (shadowmydx-pop-item shadowmydx-colored-point)))
	   (if delete-pos
	       (shadowmydx-change-pare-style delete-pos (+ 1 delete-pos) shadowmydx-current-background)))
	(cond ((equal "(" (buffer-substring (point) (+ 1 (point))))
	       (let ((right-pare-pos (shadowmydx-search-pair-pare (point) 1 0 1)))
		 (if (and (> right-pare-pos (point-min)) (< right-pare-pos (point-max)))
		     (progn
		       (shadowmydx-change-pare-style right-pare-pos (+ 1 right-pare-pos) shadowmydx-align-pare-background)
		       (shadowmydx-append-to shadowmydx-colored-point right-pare-pos)))))
	      ((equal ")" (buffer-substring (point) (+ 1 (point))))
	       (let ((left-pare-pos (shadowmydx-search-pair-pare (point) 1 1 0)))
		 (if (and (> left-pare-pos (point-min)) (< left-pare-pos (point-max)))
		     (progn
		       (shadowmydx-change-pare-style left-pare-pos (+ 1 left-pare-pos) shadowmydx-align-pare-background)
		       (shadowmydx-append-to shadowmydx-colored-point left-pare-pos)))))))))

shadowmydx-colored-point
(setq tmp-delete (shadowmydx-pop-item shadowmydx-colored-point))
tmp-delete
(shadowmydx-change-pare-style 2062 2063 shadowmydx-current-background)
;(if tmp-delete
;    (shadowmydx-change-pare-style tmp-delete (+ 1 tmp-delete) shadowmydx-current-background)
;  (+ 1 2))
shadowmydx-current-background

