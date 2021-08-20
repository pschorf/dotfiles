(defvar pschorf/python-env nil)

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c C-l")
  :hook ((lsp-mode . lsp-enable-which-key-integration)
	 (haskell-mode . lsp)
	 (literate-haskell-mode . lsp)
	 (scala-mode . lsp)
	 (lsp-mode . lsp-lens-mode))
  :ensure t
  :commands lsp
  :config
  (setq gc-cons-threshold 100000000) ;; 100mb
  (setq read-process-output-max (* 1024 1024)) ;; 1mb
  (setq lsp-idle-delay 0.500)
  (setq lsp-log-io nil)
  (setq lsp-completion-provider :capf)
  (setq lsp-prefer-flymake nil))

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
  (setq lsp-enable-file-watchers nil)
  (add-to-list 'lsp-disabled-clients 'pylsp)
  (add-to-list 'exec-path "/usr/local/bin"))

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

(use-package projectile-ripgrep
  :commands (projectile-ripgrep)
  :ensure t)

(use-package ob-ipython
  :ensure t
  :config
  (add-to-list 'org-babel-load-languages '(ipython . t)))

(use-package rust-mode
  :ensure t
  :config
  (setq lsp-rust-server 'rls))

(use-package vterm
  :ensure t)

(use-package lsp-metals
  :ensure t)
(use-package lsp-ui
  :ensure t
  :config
  (setq lsp-ui-sideline-show-diagnostics t)
  (setq lsp-ui-sideline-show-code-actions t))
(use-package yasnippet
  :ensure t)
(use-package posframe
  :ensure t)
(use-package dap-mode
  :hook
  (lsp-mode . dap-mode)
  (lsp-mode . dap-ui-mode))

(define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
(define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)

(electric-pair-mode 1)

