;;; bg-complete --- Autocompletion and tab completion for Bearguns.
;;; Commentary:
;; Ivy, Counsel, Swiper, and Company provide the meat-n-potatoes of this endeavor.
;;; Code:
(bg-require-package 'ivy)
(bg-require-package 'counsel)
(bg-require-package 'company)

(require 'ivy)
(setq ivy-use-virtual-buffers t)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(ivy-mode 1)

(require 'counsel)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "\C-s") 'swiper)
(counsel-mode 1)

(require 'evil)
(evil-define-key 'normal 'global (kbd "<leader>SPC") 'counsel-M-x)

(require 'company)
(add-hook 'prog-mode-hook 'company-mode)
(setq company-idle-delay 0.1
      company-minimum-prefix-length 2)
(setq-default company-tooltip-align-annotations t)

(provide 'bg-complete)
;;; bg-complete.el ends here.
