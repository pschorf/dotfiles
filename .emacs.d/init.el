; Basic init config
(server-start)

(menu-bar-mode -1)
(tool-bar-mode -1)

; Add melpa
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

					; bootstrap straight
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


					; use-package
(unless (require 'use-package nil 'noerror)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

; custom file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

; basic config not in other files
(setq epa-pinentry-mode 'loopback)

; load remaining config files
(load "~/.emacs.d/org.el")
(load "~/.emacs.d/navigation.el")
(load "~/.emacs.d/math.el")
(load "~/.emacs.d/internet.el")
(load "~/.emacs.d/source.el")
(load "~/.emacs.d/programming.el")
(load "~/.emacs.d/mail.el")

(when (file-exists-p "~/.emacs.d/local.el")
  (load "~/.emacs.d/local.el"))
