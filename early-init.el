;; configure Emacs garbage collector, which is somewhat famous for
;; possibly slowing down your editor
(setq gc-cons-threshold most-positive-fixnum)
(setq gc-cons-percentage 0.6)

;; Don't enable Emacs' package system yet!
;; We will do that later at a more optimal time.
(setq package-enable-at-startup nil)
(setq package-quickstart nil)

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

;; Minimize compilation of packages and core
(setq comp-deferred-compilation nil)
