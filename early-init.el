;; Hide UI elements early, don't flash vanilla Emacs at me
;; and make me think something's broken.
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(verical-scroll-bars) default-frame-alist)

;; Don't resize the frame at startup when rendering fonts.
(setq frame-inhibit-implied-resize t)

;; Now hide the default chrome
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-splash-screen 1)
(setq use-file-dialog nil)
