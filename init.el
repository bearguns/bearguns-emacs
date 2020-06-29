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

(require 'bg-evil)
;; Make our Emacs more evil.

(require 'bg-complete)
;; DWIM and autocompletion

(require 'bg-org)

(require 'bg-markup)

(require 'bg-lint)

(require 'bg-git)
;;; init.el ends here.
