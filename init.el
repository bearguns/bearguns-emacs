;; According to smart people, `file-name-handler-alist` is
;; consulted a LOT during the Emacs lifecycle. We can adjust this to improve
;; startup times.
(unless (daemonp)
  (defvar bg--initial-file-name-handler-alist file-name-handler-alist)
  (setq file-name-handler-alist nil)
  ;; helper to restore the original alist once we are done
  (defun bg-reset-file-handler-alist-h ()
  (dolist (handler file-name-handler-alist)
    (add-to-list 'bg--initial-file-name-handler-alist handler))
  (setq file-namde-handler-alist bg--initial-file-name-handler-alist))
  (add-hook 'emacs-startup-hook #'bg-reset-file-handler-alist-h)
  (add-hook 'after-init-hook '(lambda ()
    ;; restore original GC settings
    (setq gc-cons-threshold 16777216
          gc-cons-percentage 0.1)))
)
;; Set our working directory here
(setq user-emacs-directory (file-truename (file-name-directory load-file-name)))

(setq straight-check-for-modifications '(check-on-save find-when-checking))
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(setq use-package-compute-statistics t)

(use-package emacs
  :init
  (setq inhibit-startup-screen t
        initial-scratch-message nil
        sentence-end-double-space nil
        ring-bell-function 'ignore
        frame-resize-pixelwise t)
  (setq user-full-name "Sean Brage"
        user-mail-address "seanmbrage@me.com")
        
  (setq read-process-output-max (* 1024 1024))
  
  ;; utf-8 please and thanks
  (set-charset-priority 'unicode)
  (setq locale-coding-system 'utf-8
        coding-system-for-read 'utf-8
        coding-system-for-write 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)
  (setq default-process-coding-system '(utf-8-unix . utf-8-unix))

  ;; Recent files -- yay!
  (recentf-mode t)
  (setq recentf-exclude `(,(expand-file-name "straight/build/" user-emacs-directory)
                          ,(expand-file-name "eln-cache/" user-emacs-directory)
                          ,(expand-file-name "etc/" user-emacs-directory)
                          ,(expand-file-name "var/")))

  ;; Don't keep a custom file, this just messes things up especially with VC
  (setq custom-file (make-temp-file ""))
  (setq custom-safe-themes t)
  (setq enable-local-variables :all)

  ;; No backup files!
  (setq make-backup-files nil
        auto-save-default nil
        create-lockfiles nil)

  ;; follow symlinks
  (setq vc-follow-symlinks t)

  ;; clean UI
  (when (window-system)
    (tool-bar-mode -1)
    (toggle-scroll-bar -1))
    
  ;; winner mode for window layout management (YES)
  (winner-mode t)

  ;; highlight matching parens
  (show-paren-mode t)

  ;; autopairs
  (electric-pair-mode +1)

  ;; sshh
  (setq byte-compile-warnings '(not free-vars unresolved noruntime lexical make-local))
  
  ;; cleanup modeline
  (display-time-mode -1)
  (setq column-number-mode t)
  
  ;; do some indentation normalization
  (setq-default tab-width 2)
  (setq-default indent-tabs-mode nil)
  (setq-default tab-always-indent 'complete)
  (electric-indent-mode 1)
  
  (global-display-line-numbers-mode 1)
  (add-hook 'prog-mode-hook (lambda () 
    (setq display-line-numbers-type 'relative)))

  (add-hook 'org-mode-hook (lambda ()
    (setq display-line-numbers-type 'relative)))

  (if (> (display-pixel-width) 2560)
    (set-frame-font "JetBrains Mono-14")
    (set-frame-font "JetBrains Mono-11"))
)

(use-package emacs
  :init
  (when (eq system-type 'darwin)
    (setq mac-command-modifier 'super)
    (setq mac-option-modifier 'meta)
    (setq mac-control-modifier 'control)
    (global-set-key [(s c)] 'kill-ring-save)
    (global-set-key [(s v)] 'yank)
    (global-set-key [(s x)] 'kill-region)
    (global-set-key [(s q)] 'kill-emacs)))

(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :hook (emacs-startup . (lambda ()
                           (setq exec-path-from-shell-arguments '("-l"))
                           (exec-path-from-shell-initialize))))

(use-package emacs
  :init
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
  (add-to-list 'default-frame-alist '(ns-appearance . dark))
  (setq ns-use-proxy-icon  nil)
  (setq frame-title-format nil)
)

(use-package general
  :demand t
  :config 
  (general-evil-setup)
  
  (general-create-definer bg/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")

  (general-create-definer bg/local-leader-keys
    :states '(normal visual)
    :keymaps 'override
    :prefix ","
    :global-prefix "SPC m")

  (bg/leader-keys
    "SPC" '(execute-extended-command :which-key "execute command")
    "b" '(:ignore t :which-key "buffer")
    "bb" 'ibuffer
    "br" 'revert-buffer
    "bd" 'kill-current-buffer
    "bn" 'next-buffer
    "bp" 'previous-buffer

    "c" '(:ignore t :which-key "code")
    "d" '(:ignore t :whick-key "dired")
    "dd" 'dired
    "f" '(:ignore t :which-key "file")
    "ff" 'find-file
    "fs" 'save-buffer
    "fr" 'recentf-open-files
    
    "p" '(:ignore t :which-key "project")
    "pp" 'project-switch-project
    "pf" 'project-find-file
    "pg" 'project-find-regexp
    
    "w" '(:ignore t :whick-key "window")
    "wl" 'windmove-right
    "wh" 'windmove-left
    "wj" 'windmove-down
    "wk" 'windmove-up
    "wr" 'winner-redo
    "wd" 'delete-window
    "w3" 'split-window-right
    "w2" 'split-window-below
    "w=" 'balance-windows-area
    "wD" 'kill-buffer-and-window
    "wu" 'winner-undo
    "wr" 'winner-redo
    "wm" '(delete-other-windows :wk "maximize")

    "l" '(:ignore t :which-key "lsp")
    "gd" 'lsp-goto-type-definition
    "gi" 'lsp-goto-implementation))

(use-package evil
    :demand
    :general
    (lc/leader-keys
      "wv" 'evil-window-vsplit
      "ws" 'evil-window-split)
    :init
    (setq evil-want-C-u-scroll t)
    (setq evil-want-C-i-jump nil)
    (setq evil-respect-visual-line-mode t)
    (setq evil-undo-system 'undo-fu)
    (setq evil-split-window-below t)
    (setq evil-vsplit-window-right t)
    :config
    (setq-default display-line-numbers 'relative)
    (evil-mode 1))

  (use-package evil-escape
    :demand
    :init (setq-default evil-escape-key-sequence "jk")
    :config (evil-escape-mode 1))
  
;; (use-package evil-collection
;;   :after evil
;;   :demand
;;   :init (setq evil-collection-magit-use-z-for-folds nil)
;;   :config (evil-collection-init))

  (use-package evil-goggles
    :after evil
    :demand
    :init (setq evil-goggles-duration 0.05)
    :config
    (push '(evil-operator-eval
            :face evil-goggles-yank-face
            :switch evil-goggles-enable-yank
            :advice evil-goggles--generic-async-advice)
            evil-goggles--commands)
    (evil-goggles-mode)
    (evil-goggles-use-diff-faces))

  (use-package evil-surround
    :general
    (:states 'operator
      "s" 'evil-surround-edit
      "S" 'evil-Surround-edit)
    (:states 'visual
      "S" 'evil-surround-region
      "gS" 'evil-Surround-region))

(use-package which-key
  :demand t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config (which-key-mode))

;; (use-package modus-themes
;;   :demand
;;   :init (modus-themes-load-themes)
;;   :config (modus-themes-load-vivendi))

(use-package dracula-theme
  :demand
  :config (load-theme 'dracula t))

(use-package doom-modeline
  :demand
  :init
  (setq doom-modeline-height 30)
  (setq doom-modeline-icon (display-graphic-p))
  (setq doom-modeline-major-mode-icon t)
  (doom-modeline-mode 1))

(use-package all-the-icons)
;; it's all the icons

(unless (member "all-the-icons" (font-family-list))
    (all-the-icons-install-fonts t))
;; Install...well, all of the fonts for all-the-icons

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

(use-package project)

(use-package yasnippet
    :bind (("C-," . yas-expand))
    :config (yas-global-mode))
;; snippets for expanding common code blocks etc.

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
;; awesome auto-completion

(use-package magit
    :config
    (setq magit-refresh-status-buffer nil)
    (global-set-key (kbd "C-x g") 'magit))
;; oh baby. git has never been this fun to use.

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

(defun bg-vue-mode-setup ()
    (superword-mode)
    (subword-mode)
    (lsp)
    (setq-default web-mode-script-padding 0)
    (setq-default web-mode-style-padding 0)
    (setq-default web-mode-markup-indent-offset 2)
    (setq-default web-mode-css-indent-offset 2)
    (setq-default web-mode-code-indent-offset 2))

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
              (typescript-mode . prettier-mode)
              (js-mode . prettier-mode)))

(use-package emmet-mode
    :hook web-mode)
;; expand html elements

(use-package scss-mode
    :mode "\\.scss\\'")
;; make sass more better

(use-package go-mode
    :mode "\\.go\\'")

(use-package yaml-mode
    :mode "\\.yml\\'")

(use-package markdown-mode
    :mode (("\\.markdown\\'" . markdown-mode)
              ("\\.md\\'" . markdown-mode)))

(use-package typescript-mode
  :mode "\\.ts\\'")

(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (bg-vue-mode . lsp)
         (typescript-mode . lsp)
         (js-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)
