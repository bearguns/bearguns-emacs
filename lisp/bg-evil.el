;;; bg-evil --- Modal editing for the lawful evil Bearguns
;;; Commentary:
;; Vim (shudder) provides a wonderful system for jumping and moving in an ergonomic way.
;; However, it's not Emacs. Double-however, we can utilize some Vim-like behavior to the glory of God.
(require 'bg-elpa)

(bg-require-package 'evil)
(bg-require-package 'evil-escape)

(require 'evil)
(evil-mode 1)

(evil-set-leader 'normal (kbd "SPC") nil)
(evil-define-key 'normal 'global (kbd "<leader>fs") 'save-buffer)
(evil-define-key 'normal 'global (kbd "<leader>h") 'windmove-left)
(evil-define-key 'normal 'global (kbd "<leader>j") 'windmove-down)
(evil-define-key 'normal 'global (kbd "<leader>k") 'windmove-up)
(evil-define-key 'normal 'global (kbd "<leader>l") 'windmove-right)
(evil-define-key 'normal 'global (kbd "<leader>0") 'delete-window)
(evil-define-key 'normal 'global (kbd "<leader>1") 'delete-other-windows)
(evil-define-key 'normal 'global (kbd "<leader>2") 'bg-split-v)
(evil-define-key 'normal 'global (kbd "<leader>3") 'bg-split-h)
(evil-define-key 'normal 'global (kbd "<leader>pv") 'neotree-toggle)
(require 'evil-escape)
(evil-escape-mode)
(setq-default evil-escape-key-sequence "jk")

(provide 'bg-evil)
;;; bg-evil.el ends here.
