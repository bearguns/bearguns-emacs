;;; bg-golang --- Gophers and Bears living together
;;; Commentary:
;; Golang is a cool language, and Emacs is a cool editor.
;;; Code:
(require 'bg-elpa)
(bg-require-package 'go-mode)

(require 'go-mode)
(defun bg-go-mode-hook ()
    "Configure hooks to run in go mode"
    (add-hook 'before-save-hook 'gofmt-before-save))

(add-hook 'go-mode-hook 'bg-go-mode-hook)

(provide 'bg-golang)
;;; bg-golang.el ends here
