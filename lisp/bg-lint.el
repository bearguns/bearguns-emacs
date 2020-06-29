;;; bg-lint --- Linting and belly-button cleaning for Bearguns.
;;; Commentary:
;; Linting is a helpful way to identify and resolve both syntactical and stylistic errors while programming.
;;; Code:
(require 'bg-elpa)
(bg-require-package 'flycheck)
(bg-require-package 'prettier-js)
(bg-require-package 'editorconfig)

(require 'flycheck)
(setq-default flycheck-disabled-checkers
	      (append flycheck-disabled-checkers
  		      '(javascript-jshint)
		      flycheck-disabled-checkers
		      '(json-jsonlint)))
(setq-default flycheck-emacs-lisp-load-path 'inherit)
(setq-default flycheck-highlighting-mode 'lines)
(setq-default flycheck-indication-mode 'right-fringe)
(flycheck-add-mode 'javascript-eslint 'js-mode)
(add-hook 'prog-mode-hook 'flycheck-mode)

(require 'prettier-js)
(add-hook 'js-mode-hook 'prettier-js-mode)

(require 'editorconfig)
(add-hook 'prog-mode-hook 'editorconfig-mode)

(provide 'bg-lint)
;;; bg-lint.el ends here
