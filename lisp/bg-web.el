;;; bg-web --- Better HTML/CSS/SASS and HTML/CSS/SASS accessories.
;;; Commentary:
;; The various markup and stylesheet languages in play on a given day is overwhelming. Let's get whelmed.
;;; Code:
(require 'bg-elpa)
(bg-require-package 'web-mode)
(bg-require-package 'emmet-mode)
(bg-require-package 'scss-mode)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

(require 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)

(require 'scss-mode)
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(add-to-list 'auto-mode-alist '("\\.sass\\'" . scss-mode))

(provide 'bg-web)
;;; bg-web.el ends here
