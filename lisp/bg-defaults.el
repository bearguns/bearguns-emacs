;;; bg-defaults --- A better out-of-the-box experience for people named Bearguns.
;;; Commentary:
;; Things like autosave, customizations, backups, indentation can get hairy quickly.  Let's shave that bear.
;;; Code:
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

(require 'bg-elpa)
(bg-require-package 'exec-path-from-shell)
(exec-path-from-shell-initialize)

(provide 'bg-defaults)
;;; bg-defaults.el ends here
