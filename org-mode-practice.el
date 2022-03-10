;;;

;; ERT: Emacs Lisp Regression Testing
;; - https://www.gnu.org/software/emacs/manual/html_node/ert/

(require 'org)

(ert-deftest org-mode-practice-main ()
  (should (equal (org-mode-practice-main) "Hello" )))

(defun org-mode-practice-main ()
  "My first function"
  (interactive)
  (message "Hello"))

(ert-deftest my/temp-buffer ()
  (should (equal (my/temp-buffer) "* headline 1")))

(defun my/temp-buffer ()
  (with-temp-buffer
    (insert "* headline 1")
    (buffer-string)))


;; my/org-element
(ert-deftest my/org-element ()
  (should (equal
	   (format "%s" (my/org-element))
	   "(1 1 TODO nil headline 1 nil)"
	   )))

(defun my/org-element ()
  (with-temp-buffer
    (org-mode)
    (insert "* TODO headline 1\n")
    (insert "* TODO headline 2")
    (save-excursion
      (goto-char (point-min))
      (org-heading-components))))

;; my/org-map-entries
(ert-deftest my/org-map-entries ()
  (with-temp-buffer
    ;; test data
    (org-mode)
    (insert "* TODO [#A] h1\n")
    (insert "[[A][B]]\n")
    (insert "** TODO h1-1\n")
    (insert "* TODO h2")
    ;; test
    (should (equal
	     (format "%s" (my/org-map-entries))
	     "((h1 A) (h1-1 B) (h2 B))"))))

(defun my/org-map-entries ()
    (save-excursion
      (org-map-entries
       (lambda ()
	 (let ((i (org-entry-properties)))
	   (message "%s" i)
	   (let ((item (cdr (assoc "ITEM" i)))
		 (priority (cdr (assoc "PRIORITY" i))))
	     (list item priority))
	   )))))
