;;; bg-markup --- Better handling of markup languages like JSON, YML, Markdown.
;;; Commentary:
;; Honestly,  The variety of markup languages in use today is a PITA.  This tries to make it less so.
;;; Code:
(require 'bg-elpa)
(bg-require-package 'yaml-mode)
(bg-require-package 'markdown-mode)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

(provide 'bg-markup)
;;; bg-markup.el ends here
