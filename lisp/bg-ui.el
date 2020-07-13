;;; bg-ui --- Visual enhancements for the discerning Bearguns
;;; Commentary:
;; While not unattractive, the default Emacs UI lacks a certain flair that
;; I desire and require.
;;; Code:
(require 'bg-elpa)
;; provide our package install function.

(bg-require-package 'rebecca-theme)
(bg-require-package 'nyan-mode)
(bg-require-package 'all-the-icons)
(bg-require-package 'spaceline)
(bg-require-package 'neotree)
(bg-require-package 'rainbow-delimiters)
;; install packages for configuration further down this file.

(setq inhibit-startup-message t
    inhibit-startup-echo-area-message user-login-name
    inhibit-default-init t
    initial-major-mode 'fundamental-mode
    initial-scratch-message nil)


(setq idle-update-delay 1.0)

(setq-default bidi-display-reordering 'left-to-right
              bidi-paragraph-direction 'left-to-right)

(setq-default cursor-in-non-selected-windows nil)
(setq highlight-nonselected-windows nil)
(setq fast-but-imprecise-scrolling t)
(setq ffap-machine-p-known 'reject)

(setq gcmh-idle-delay 5
      gcmh-high-cons-threshold (* 16 1024 1024))

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

(global-set-key (kbd "C-x 2") 'bg-split-v)
(global-set-key (kbd "C-x 3") 'bg-split-h)

(show-paren-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; Hide the default UI chrome.

(electric-pair-mode 1)
;; Auto-close delimiters like (,",{,etc.

(add-hook 'prog-mode-hook 'electric-indent-mode)
(setq-default tab-always-indent 'complete)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
;; Fixes for indentation behaviors when coding

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)
;; Show line numbers as relative to current line for Evil jumps/motions.
(global-hl-line-mode 1)
;; Highlight current line (useful for quickly finding point).

(blink-cursor-mode 0)
(setq-default cursor-type 'box)
(set-cursor-color "#cccccc")
;; Improve cursor visibility in buffers.

(setq ring-bell-function 'ignore)
;; LEAVE ME ALONE EMACS I GET IT I MADE A MISTAKE.

(load-theme 'rebecca t)
;; Load our colorscheme of choice and set as "safe" for future sessions.

(require 'nyan-mode)
(nyan-mode 1)
(setq nyan-animate-nyancat t)
;; Nyancat. Bearguns approves.

(set-face-attribute 'default nil
			        :family "Iosevka"
			        :height 100
			        :weight 'normal
			        :width 'normal)


(require 'all-the-icons)
(unless (member "all-the-icons" (font-family-list))
  (all-the-icons-install-fonts t))
;; Install...well, all of the icons.

(require 'spaceline-config)
(spaceline-emacs-theme)
;; Pretty modelines can actually be HELPFUL, not just eye candy.

(require 'neotree)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
;; Add a safety net tree browser.

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(provide 'bg-ui)
;;; bg-ui.el ends here.
