;;; bg-javascript --- JS Editing for Modern Bears
;;; Commentary:
;; I use JS for most of my professional work and I want it to not suck.
;;; Code:
(require 'bg-elpa)
(bg-require-package 'tide)

(defun setup-tide-mode ()
  "Setup function for tide."
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(setq company-tooltip-align-annotations t)

(add-hook 'js-mode-hook #'setup-tide-mode)

(setq js-indent-level 2)

(require 'emmet-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'") 'emmet-mode)
(provide 'bg-javascript)
;;; bg-javascript.el ends here
