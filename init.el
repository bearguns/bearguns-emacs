;;; init.el --- baseline configuration for a happy, healthy Emacs
;;; Commentary:
;; Establish some helper functions etc. and load our custom Elisp code
;;; Code:
;; Load files from our ~lisp~ directory:
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(require 'bg-elpa)
;; Load our Elpa configuration for fetching packages.

(require 'bg-ui)
;; Load our UI customizations.

(require 'bg-evil)
;; Make our Emacs more evil.

(require 'bg-complete)
;; DWIM and autocompletion

(require 'bg-org)
;;; init.el ends here.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-escape-mode t)
 '(global-display-line-numbers-mode t)
 '(package-selected-packages
   '(markdown-mode yaml-mode editorconfig prettier-js flycheck rainbow-delimiters org-journal org-pomodoro company counsel ivy neotree evil-escape evil spaceline all-the-icons nyan-mode golden-ratio rebecca-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
