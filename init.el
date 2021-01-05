;;; init.el --- bearguns Emacs config rerevisited
;;; Commentary:
;; Emacs 27+ is pretty fast, so I'm not too concerned about startup times.  Mainly,
;; I'm concerned with an Emacs I can live in for most of my workday and get things done.

;;; Code:
;;;;;;;;;;;;;;;;; PACKAGE MANAGER ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; require the built-in "package" package
(require 'package)
;; enable package repositories for installing packages
(setq package-archives
    '(("org" . "https://orgmode.org/elpa/")
         ("gnu" . "https://elpa.gnu.org/packages/")
         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; update package list on fresh install
(unless package-archive-contents
    (package-refresh-contents))
;; Install the use-package package manager
(unless (package-installed-p 'use-package)
    (package-install 'use-package))

(setq-default use-package-always-ensure t)

;;;;;;;;;;;;;;;; DEFAULTS ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq make-backup-files nil)
;; Emacs creates a lot of "helpful" files (backups, autosaves, lockfiles)
;; I don't want any of them.

(use-package exec-path-from-shell
    :config (exec-path-from-shell-initialize))
;; make sure Emacs sees tools in our $PATH like grep, rg, etc.

;;;;;;;;;;;;;;;; EDITING ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; When using tramp to login to remote filesystems, make sure we use that system's shell instead of our own fish shell.
(setq-default tramp-default-remote-shell "/bin/sh")

(electric-pair-mode 1)
;; Auto-close delimiters like (,",{,etc.

(add-hook 'prog-mode-hook 'electric-indent-mode)
(setq-default tab-always-indent 'complete)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
;; Fixes for indentation behaviors when coding

(show-paren-mode 1)
;; highlight matching parens and brackets

(use-package yasnippet
    :bind (("C-," . yas-expand))
    :config (yas-global-mode))
;; snippets for expanding common code blocks etc.

(use-package expand-region
    :config (global-set-key (kbd "C-;") 'er/expand-region))

;; EVIL - uncomment if you want Vim-keysystem
;;(use-package evil
;;    :config
;;    (global-display-line-numbers-mode)
;;    (setq display-line-numbers 'relative)
;;    (setq-default evil-want-C-u-delete t)
;;    (setq-default evil-want-C-u-scroll t)
;;    (setq-default evil-want-C-d-scroll t)
;;    (setq-default evil-respect-visual-line-mode t)
;;    (setq-default evil-show-paren-range 1)
;;    (evil-mode 1))
;;
;;(use-package evil-escape
;;  :config
;;  (setq-default evil-escape-key-sequence "jk")
;;  (evil-escape-mode 1))
;;
;;(use-package evil-leader
;;  :config
;;  (evil-leader/set-leader "<SPC>")
;;  (evil-leader/set-key
;;   "w" 'save-buffer
;;   "q" 'delete-window
;;   "1" 'delete-other-windows
;;   "2" 'bg-split-v
;;   "3" 'bg-split-h
;;   "h" 'windmove-left
;;   "j" 'windmove-down
;;   "k" 'windmove-up
;;   "l" 'windmove-right)
;;   (global-evil-leader-mode))

;;;;;;;;;;;;;;;; UI ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; Hide the default UI chrome.

(setq ring-bell-function 'ignore)
;; LEAVE ME ALONE EMACS I GET IT I MADE A MISTAKE.

(setq-default cursor-type 'box)
;; Improve cursor visibility in buffers.
(setq-default cursor-in-non-selected-windows nil)
;; Don't show the cursor in "other" windows, makes it easier to find active window.
(blink-cursor-mode 0)
;; Don't blink the cursor. Makes it easier to find in windows.
(setq highlight-nonselected-windows nil)
;; don't highlight nonselected windows for visual clarity
(setq scroll-conservatively 25)
;; Scroll line-by-line when point reaches bottom of buffer, rather than scrolling by "page"

(setq inhibit-startup-message t
    inhibit-startup-echo-area-message user-login-name
    inhibit-default-init t
    initial-major-mode 'fundamental-mode
    initial-scratch-message nil)
;; get rid of all the stuff on startup

(use-package doom-themes
    :config (load-theme 'doom-gruvbox t))
;; nice collection of color themes

(use-package doom-modeline
    :init (doom-modeline-mode 1))

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
;; nice startup dashboard with recents, bookmarks, etc.

(use-package all-the-icons)
;; it's all the icons

(unless (member "all-the-icons" (font-family-list))
    (all-the-icons-install-fonts t))
;; Install...well, all of the fonts for all-the-icons

(use-package neotree
    :init
    (setq neo-theme (if (display-graphic-p) 'icons 'arrow))
    (global-set-key (kbd "C-c t") 'neotree-toggle)
    :config
    (setq neo-smart-open t)
    (setq projectile-switch-project-action 'neotree-projectile-action))

;; file tree, still helpful sometimes even though dired is baller

(use-package rainbow-delimiters
    :mode "\\.pco\\'"
    :hook ((prog-mode . rainbow-delimiters-mode)
              (conf-mode . rainbow-delimiters-mode)))
;; colorize nested brackets and parens, helpful to determine scope

(use-package rainbow-mode
    :hook ((prog-mode . rainbow-mode)
              (conf-mode . rainbow-mode)
              (css-mode  . rainbow-mode)
              (web-mode  . rainbow-mode)))
;; highlight color values i.e. hex codes with the actual color

(if (> (x-display-pixel-width) 2560)
    (set-face-attribute 'default nil
		:family "UbuntuMono Nerd Font Mono"
		:height 160
		:weight 'normal
		:width 'normal)
    (set-face-attribute 'default nil
		:family "UbuntuMono Nerd Font Mono"
		:height 130
		:weight 'normal
		:width 'normal))
;; Set font face and appropriate size based on display size.

;;;;;;;;;;;;;;;; CODING ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'js-mode-hook 'subword-mode)
(add-hook 'js-mode-hook 'superword-mode)

(defun bg-build-ivy (project)
    (let ((project-path
              (concat "~/code/ivy/frontend/ivy_" project)))
        (async-shell-command (concat "cd " project-path " && nvm use 6 && yarn build && nvm use 14"))))

(use-package add-node-modules-path
    :hook ((js-mode . add-node-modules-path)
              (typescript-mode . add-node-modules-path)))

(use-package editorconfig
    :config (editorconfig-mode 1))
;; ensure editor settings are consistent between developers

(use-package flycheck
    :hook ((prog-mode . flycheck-mode)
              (conf-mode . flycheck-mode)
              (web-mode  . flycheck-mode)
              (css-mode  . flycheck-mode))
    :config
    (add-to-list 'flycheck-enabled-checkers 'javascript-eslint)
    (setq-default flycheck-emacs-lisp-load-path 'inherit)
    (setq-default flycheck-highlighting-mode 'lines))
;; check syntax!

(use-package company
    :hook ((prog-mode . company-mode)
              (conf-mode . company-mode)
              (web-mode  . company-mode))
    :init
    (setq company-idle-delay 0.1
        company-minimum-prefix-length 2)
    (setq-default company-tooltip-align-annotations t)
    :config
    (setq company-dabbrev-downcase nil))

(use-package company-box
    :hook (company-mode . company-box-mode))
;; awesome auto-completion

(use-package ivy
    :init (setq ivy-use-virtual-buffers t)
    :config
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (ivy-mode 1))
;; replace Emacs' built-in completion engine with something a bit more...great.

(use-package counsel
    :config
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "\C-s") 'swiper)
    (counsel-mode 1))
;; find stuff!

(use-package projectile
    :config
    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
    (projectile-mode 1))

(use-package counsel-projectile
    :config (counsel-projectile-mode 1))
;; work with git projects like a pro!

(use-package magit
    :config
    (setq magit-refresh-status-buffer nil)
    (setq vc-handled-backends nil)
    (global-set-key (kbd "C-x g") 'magit))
;; oh baby. git has never been this fun to use.

(defun bg-vue-mode-setup ()
    (superword-mode)
    (subword-mode)
    (setq web-mode-script-padding 0)
    (setq web-mode-style-padding 0)
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-css-indent-offset 2)
    (setq web-mode-code-indent-offset 2))

(define-derived-mode bg-vue-mode web-mode "bg-vue-mode"
    "Major mode derived from web-mode, tailored for VueJS development")
(add-to-list 'auto-mode-alist '("\\.vue\\'" . bg-vue-mode))
(add-hook 'bg-vue-mode-hook #'add-node-modules-path)
(add-hook 'bg-vue-mode-hook #'bg-vue-mode-setup)
;; configuration to make web-mode play better with .vue files

(use-package web-mode
    :mode (("\\.html\\'" . web-mode)
              ("\\.hbs\\'" . web-mode)
              ("\\.erb\\'" . web-mode)))
;; all the html, hbs, ejs, erb, vue, etc.

(use-package prettier
    :hook ((bg-vue-mode . prettier-mode)
              (js-mode . prettier-mode)))

(use-package emmet-mode
    :hook web-mode)
;; expand html elements

(use-package scss-mode
    :mode "\\.scss\\'")
;; make sass more better

(use-package go-mode
    :mode "\\.go\\'")
;;;;;;;;;;;;;;;; ORG MODE ;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'org-mode-hook 'auto-fill-mode)
(add-hook 'org-mode-hook 'visual-line-mode)

(use-package org-pomodoro)

(use-package org-journal)
(setq org-journal-dir "~/org/journal/")


(use-package yaml-mode
    :mode "\\.yml\\'")

(use-package markdown-mode
    :mode (("\\.markdown\\'" . markdown-mode)
              ("\\.md\\'" . markdown-mode)))
