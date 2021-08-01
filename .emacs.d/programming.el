(defvar pschorf/python-env nil)

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c C-l")
  :hook ((lsp-mode . lsp-enable-which-key-integration)
	 (haskell-mode . lsp)
	 (literate-haskell-mode . lsp))
  :ensure t
  :commands lsp)

(use-package python
  :mode ("\\.py\\'" . python-mode)
  :ensure t)

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
			 (when 'pschorf/python-env
			   (pyvenv-workon pschorf/python-env))
			 (require 'lsp-pyright)
			 (lsp)))
  :config
  (setq lsp-enable-file-watchers nil))

(use-package pyvenv
  :ensure t
  :commands (pyvenv-workon))

(use-package haskell-mode
  :ensure t)

(use-package lsp-haskell
  :ensure t)

(use-package yaml-mode
  :ensure t)

(use-package ansible
  :ensure t
  :hook (yaml-mode . (lambda ()
		       (ansible 1))))

(use-package projectile
  :ensure t
  :bind-keymap  ("C-c p" . projectile-command-map)
  :config
  (projectile-mode +1))
