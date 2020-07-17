;; Adjusts the Emacs garbage collector
(setq gc-cons-threshold most-positive-fixnum)

;; Delays enabling Emacs' package manager
(setq package-enable-at-startup nil)
(advice-add #'package--ensure-init-file :override #'ignore)

;; Delay rendering certain (unwanted) UI elements
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
;; Delay resizing the Emacs frame
(setq frame-inhibit-implied-resize t)
