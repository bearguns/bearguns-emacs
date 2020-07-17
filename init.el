(defun bg-backup-file-name (fpath)
  "Return a new file path of FPATH.  If the new path's directories does not exist, create them."
  (let* (
        (backupRootDir "~/.emacs.d/backup/")
        (filePath (replace-regexp-in-string "[A-Za-z]:" "" fpath )) ; remove Windows driver letter in path, for example, “C:”
        (backupFilePath (replace-regexp-in-string "//" "/" (concat backupRootDir filePath "~") ))
        )
    (make-directory (file-name-directory backupFilePath) (file-name-directory backupFilePath))
    backupFilePath
  )
)
(setq make-backup-file-name-function 'bg-backup-file-name)
;; make backup to a designated dir, mirroring the full path

(setq auto-save-default nil)
(setq create-lockfiles nil)
;; don't pollute the waters with these special files.

(setq tramp-default-remote-shell "/bin/sh")

(require 'package)
;; require the built-in "package" package
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("gnu" . "https://elpa.gnu.org/packages/"))
;; Make sure Melpa is our go-to package repository!
(package-initialize)

(defun bg-require-package (package)
  "Install PACKAGE if not found on startup."
  (if (package-installed-p package)
      t
    (progn
      (unless (assoc package package-archive-contents)
	(package-refresh-contents))
        (package-install package)
        (require package))))
;; helper function to install packages (can be reused!).

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

(nyan-mode 1)
(setq nyan-animate-nyancat t)
;; Nyancat. Bearguns approves.

(when window-system
  (if (> (x-display-pixel-width) 1080)
      (set-face-attribute 'default nil
			  :family "Iosevka Nerd Font"
			  :height 130
			  :weight 'normal
			  :width 'normal)
    (set-face-attribute 'default nil
			:family "Iosevka Nerd Font"
			:height 100
			:weight 'normal
			:width 'normal)))
;; Set font face and appropriate size based on display size.

(unless (member "all-the-icons" (font-family-list))
  (all-the-icons-install-fonts t))
;; Install...well, all of the icons.

(spaceline-emacs-theme)
;; Pretty modelines can actually be HELPFUL, not just eye candy.

(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
;; Add a safety net tree browser.

(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(bg-require-package 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(add-hook 'org-mode-hook 'auto-fill-mode)
(add-hook 'org-mode-hook 'visual-line-mode)

(bg-require-package 'org-pomodoro)

(bg-require-package 'org-journal)
(setq org-journal-dir "~/org/journal/")

(bg-require-package 'ivy)
(bg-require-package 'counsel)
(bg-require-package 'company)

(setq ivy-use-virtual-buffers t)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(ivy-mode 1)

(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "\C-s") 'swiper)
(counsel-mode 1)

(add-hook 'prog-mode-hook 'company-mode)
(setq company-idle-delay 0.1
      company-minimum-prefix-length 2)
(setq-default company-tooltip-align-annotations t)

(bg-require-package 'magit)
(bg-require-package 'projectile)
(bg-require-package 'counsel-projectile)

;; Magit configuration
(setq magit-refresh-status-buffer nil)
(setq vc-handled-backends nil)
(global-set-key (kbd "C-x g") 'magit)

;; Projectile configuration
(projectile-mode 1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Counsel configuration
(counsel-projectile-mode 1)

(bg-require-package 'flycheck)
(bg-require-package 'editorconfig)

(setq-default flycheck-emacs-lisp-load-path 'inherit)
(setq-default flycheck-highlighting-mode 'lines)
(setq-default flycheck-indication-mode 'right-fringe)

(add-hook 'prog-mode-hook 'flycheck-mode)
(add-hook 'prog-mode-hook 'editorconfig-mode)

(bg-require-package 'web-mode)
(bg-require-package 'emmet-mode)
(bg-require-package 'scss-mode)

(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

(add-hook 'web-mode-hook 'emmet-mode)

(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(add-to-list 'auto-mode-alist '("\\.sass\\'" . scss-mode))

(bg-require-package 'tide)

(defun setup-tide-mode ()
  "Setup function for tide."
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(setq company-tooltip-align-annotations t)

(add-hook 'js-mode-hook 'setup-tide-mode)

(setq js-indent-level 2)

(add-to-list 'auto-mode-alist '("\\.jsx\\'") 'emmet-mode)

(bg-require-package 'yaml-mode)
(bg-require-package 'markdown-mode)

(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
