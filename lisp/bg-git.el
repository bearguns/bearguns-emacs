;;; bg-git.el --- Make Git Great
;;; Commentary:
;; Provide a useful framework for working in Git-controlled projects.
;;; Code:
(require 'bg-elpa)
(bg-require-package 'magit)
(bg-require-package 'projectile)
(bg-require-package 'counsel-projectile)

(require 'magit)
(setq magit-refresh-status-buffer nil)
(setq vc-handled-backends nil)
(global-set-key (kbd "C-x g") 'magit)
(require 'evil)
(evil-define-key 'normal 'global (kbd "<leader>xg") 'magit)

(require 'projectile)
(projectile-mode 1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(require 'counsel-projectile)
(counsel-projectile-mode 1)

(provide 'bg-git)
;;; bg-git.el ends here.
