;;; init.el --- baseline configuration for a happy, healthy Emacs
;;; Commentary:
;; Establish some helper functions etc. and load our custom Elisp code
;;; Code:
;; Load files from our ~lisp~ directory:
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(require 'bg-defaults)

(require 'bg-elpa)
;; Load our Elpa configuration for fetching packages.

(require 'bg-ui)
;; Load our UI customizations.

;; (require 'bg-evil)
;; Make our Emacs more evil.

(require 'bg-complete)
;; DWIM and autocompletion

(require 'bg-org)

(require 'bg-markup)

(require 'bg-lint)

(require 'bg-git)

(require 'bg-web)
(require 'bg-javascript)
;;; init.el ends here.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(tide lsp-ivy lsp-ui lsp-mode go-mode scss-mode emmet-mode web-mode counsel-projectile projectile magit editorconfig prettier-js flycheck markdown-mode yaml-mode org-journal org-pomodoro company counsel ivy evil-escape evil rainbow-delimiters neotree spaceline all-the-icons nyan-mode rebecca-theme exec-path-from-shell)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
