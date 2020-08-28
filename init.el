(defun bg-backup-file-name (fpath)
  "Return a new file path of FPATH.  If the new path's directories does not exist, create them."
  (let* (
        (backupRootDir "~/.emacs.d/backup/")
        (filePath (replace-regexp-in-string "[A-Za-z]:" "" fpath )) ; remove Windows driver letter in path, for example, “C:”
        (backupFilePath (replace-regexp-in-string "//" "/" (concat backupRootDir filePath "~") ))
        )
    (make-directory (file-name-directory backupFilePath) (file-name-directory backupFilePath))
    backupFilePath
  )
)
(setq make-backup-file-name-function 'bg-backup-file-name)
;; make backup to a designated dir, mirroring the full path

(setq auto-save-default nil)
(setq create-lockfiles nil)
;; don't pollute the waters with these special files.

(setq tramp-default-remote-shell "/bin/sh")

(require 'package)
;; require the built-in "package" package
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("gnu" . "https://elpa.gnu.org/packages/"))
;; Make sure Melpa is our go-to package repository!
(package-initialize)

(defun bg-require-package (package)
  "Install PACKAGE if not found on startup."
  (if (package-installed-p package)
      t
    (progn
      (unless (assoc package package-archive-contents)
	(package-refresh-contents))
        (package-install package)
        (require package))))
;; helper function to install packages (can be reused!).
(setq use-package-always-ensure t)
(bg-require-package 'use-package)

(global-display-line-numbers-mode)
;; always display line numbers with the new fast way

(require 'misc)
;; load some improvements to how cursor movements etc. work.

(electric-pair-mode 1)
;; Auto-close delimiters like (,",{,etc.

(add-hook 'prog-mode-hook 'electric-indent-mode)
(setq-default tab-always-indent 'complete)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
;; Fixes for indentation behaviors when coding

(setq-default cursor-type 'box)
;; Improve cursor visibility in buffers.

;;(setq-default evil-want-C-u-delete t)
;;(setq-default evil-want-C-u-scroll t)
;;(setq-default evil-want-C-d-scroll t)
;;(setq-default evil-respect-visual-line-mode t)
;;(setq-default evil-show-paren-range 1)
;;(setq-default evil-escape-key-sequence "jk")
;;(bg-require-package 'evil)
;;(bg-require-package 'evil-leader)
;;(bg-require-package 'evil-escape)
;;
;;(evil-mode 1)
;;
;;;; Undotree is poop and crashes Emacs every time I try to use it
;;(global-undo-tree-mode -1)
;;(global-evil-leader-mode)
;;(evil-escape-mode 1)
;;
;;(evil-leader/set-leader "<SPC>")
;;(evil-leader/set-key
;;  "wo" 'other-window
;;  "w0" 'delete-window
;;  "w1" 'delete-other-windows
;;  "w2" 'bg-split-v
;;  "w3" 'bg-split-h)
;;  
;;  
;;(evil-leader/set-key "fs" 'save-buffer)

(use-package yasnippet
  :config (yas-global-mode))

(show-paren-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; Hide the default UI chrome.

(setq ring-bell-function 'ignore)
;; LEAVE ME ALONE EMACS I GET IT I MADE A MISTAKE.

(setq inhibit-startup-message t
    inhibit-startup-echo-area-message user-login-name
    inhibit-default-init t
    initial-major-mode 'fundamental-mode
    initial-scratch-message nil)

(use-package dashboard
  :ensure t
  :init
  (setq dashboard-center-content t)
  (setq dashboard-items '((recents . 5)
                          (projects . 5)
                          (bookmarks . 5)))
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq-default dashboard-startup-banner "~/.emacs.d/logo-sm.png")
  :config 
  (dashboard-setup-startup-hook))

(setq-default cursor-in-non-selected-windows nil)
;; hide point in non-selected windows to make it easier to find active window
(setq highlight-nonselected-windows nil)
;; don't highlight nonselected windows for visual clarity
(setq fast-but-imprecise-scrolling t)
;; scroll faster!
(setq scroll-conservatively 25)
;; when moving cursor to bottom of screen, start scrolling at 25 lines away from bottom

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(use-package night-owl-theme
  :config (load-theme 'night-owl t))
;;(load-theme 'misterioso)

(use-package nyan-mode
  :init
  (setq nyan-animate-nyancat t)
  :config
  (nyan-mode 1))

(use-package all-the-icons)

(use-package spaceline
  :config
  (spaceline-emacs-theme))

(use-package spaceline-all-the-icons 
  :after spaceline
  :config (spaceline-all-the-icons-theme))

(use-package neotree
  :init
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
  (global-set-key (kbd "C-c t") 'neotree-toggle))

(use-package rainbow-delimiters
  :mode "\\.pco\\'"
  :hook ((prog-mode . rainbow-delimiters-mode)
         (conf-mode . rainbow-delimiters-mode)))

(use-package rainbow-mode
  :hook ((prog-mode . rainbow-mode)
         (conf-mode . rainbow-mode)
         (css-mode  . rainbow-mode)
         (web-mode  . rainbow-mode)))

(defun bg-split-h ()
  "Split window right"
  (interactive)
  (split-window-right)
  (other-window 1))
(defun bg-split-v ()
  "Split window below"
  (interactive)
  (split-window-below)
  (other-window 1))
;; Functions to split window and move focus to new windows

(global-set-key (kbd "C-x 2") 'bg-split-v)
(global-set-key (kbd "C-x 3") 'bg-split-h)
;; Override default split bindings with split-and-follow functions

(when window-system
  (if (> (x-display-pixel-width) 2560)
      (set-face-attribute 'default nil
			  :family "JetBrains Mono"
			  :height 160
			  :weight 'normal
			  :width 'normal)
    (set-face-attribute 'default nil
			:family "JetBrains Mono"
			:height 130
			:weight 'normal
			:width 'normal)))
;; Set font face and appropriate size based on display size.

(unless (member "all-the-icons" (font-family-list))
  (all-the-icons-install-fonts t))
;; Install...well, all of the icons.

(use-package exec-path-from-shell
  :config (exec-path-from-shell-initialize))

(use-package add-node-modules-path
  :hook ((js-mode . add-node-modules-path)
         (typescript-mode . add-node-modules-path)
         (prettier-js-mode . add-node-modules-path)))

(add-hook 'org-mode-hook 'auto-fill-mode)
(add-hook 'org-mode-hook 'visual-line-mode)

(use-package org-pomodoro)

(use-package org-journal)
(setq org-journal-dir "~/org/journal/")

(use-package ivy
  :init (setq ivy-use-virtual-buffers t)
  :config
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (ivy-mode 1))
(use-package counsel
  :config
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "\C-s") 'swiper)
  (counsel-mode 1))

(use-package company
  :hook ((prog-mode . company-mode)
         (conf-mode . company-mode)
         (web-mode  . company-mode)
         (lsp-mode  . company-mode))
  :init
  (setq company-idle-delay 0.1
        company-minimum-prefix-length 2)
  (setq-default company-tooltip-align-annotations t))
  
(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package magit
  :config
  (setq magit-refresh-status-buffer nil)
  (setq vc-handled-backends nil)
  (global-set-key (kbd "C-x g") 'magit))

(use-package projectile
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode 1))

(use-package counsel-projectile
  :config (counsel-projectile-mode 1))

(use-package flycheck
  :hook ((prog-mode . flycheck-mode)
         (conf-mode . flycheck-mode)
         (web-mode  . flycheck-mode)
         (css-mode  . flycheck-mode))
  :config
  (setq-default flycheck-emacs-lisp-load-path 'inherit)
  (setq-default flycheck-highlighting-mode 'lines)
  (setq-default flycheck-indication-mode 'right-fringe))

(use-package editorconfig
  :config (editorconfig-mode 1))

(defun bg-vue-mode ()   
    (when (and (stringp buffer-file-name)   
           (string-match "\\.vue\\'" buffer-file-name))
           (lsp)
           (prettier-js-mode 1)
           (setq web-mode-script-padding 0)
           (setq web-mode-style-padding 0)
           (setq web-mode-markup-indent-offset 2)
           (setq web-mode-css-indent-offset 2)
           (setq web-mode-code-indent-offset 2)))

(use-package web-mode
  :mode (("\\.html\\'" . web-mode)
         ("\\.hbs\\'" . web-mode)
         ("\\.vue\\'" . web-mode)
         ("\\.erb\\'" . web-mode))
  :hook (web-mode . bg-vue-mode))

(use-package emmet-mode
  :hook web-mode)

(use-package scss-mode
  :mode "\\.scss\\'")

(use-package lsp
  :hook ((ruby-mode . lsp)
         (js-mode . lsp)
         (typescript-mode . lsp)))

(setq js-offset-indent 2)

(use-package prettier-js
  :hook (js-mode . prettier-js-mode))

(use-package yaml-mode)
(use-package markdown-mode)

(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(lsp spaceline-all-the-icons yasnippet yaml-mode web-mode use-package tide spaceline scss-mode rainbow-mode rainbow-delimiters prettier-js org-pomodoro org-journal nyan-mode nord-theme night-owl-theme neotree magit lsp-mode gruvbox-theme exec-path-from-shell evil-leader evil-escape emmet-mode editorconfig dashboard counsel-projectile company-box all-the-icons add-node-modules-path)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
