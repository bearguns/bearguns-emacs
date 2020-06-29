;;; bg-elpa --- Make Emacs fetch packages in a way befitting a Bearguns
;;; Commentary:
;; Elpa and Melpa combined provide Emacs with an unparalleled source of
;; excellent packages that extend the already-otherworldly capabilities
;; of Emacs. This uses them.
;;; Code:
(require 'package)
;; require the built-in "package" package

(defun bg-require-package (package)
  "Install PACKAGE if not found on startup."
  (if (package-installed-p package)
      t
    (progn
      (unless (assoc package package-archive-contents)
	(package-refresh-contents))
      (package-install package))))
;; helper function to install packages (can be reused!).

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("gnu" . "https://elpa.gnu.org/packages/"))
;; Make sure Melpa is our go-to package repository!

(package-initialize)

(provide 'bg-elpa)
;;; bg-elpa.el ends here.
