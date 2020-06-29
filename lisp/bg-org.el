;;; bg-org.el --- Org Mode enhancements for the productive Bearguns.
;;; Commentary:
;; Org-mode provides immeasurable value to the Emacs user. The following extensions augment the experience.
;;; Code:
(require 'bg-elpa)
(bg-require-package 'org-pomodoro)
(bg-require-package 'org-journal)

(add-hook 'org-mode-hook 'auto-fill-mode)
(add-hook 'org-mode-hook 'visual-line-mode)

(require 'org-pomodoro)
(require 'org-journal)
(setq org-journal-dir "~/org/journal/")

(provide 'bg-org)
;;; bg-org.el ends here
