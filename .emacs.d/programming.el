(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
			 (require 'lsp-pyright)
			 (lsp)))
  :config
  (setq lsp-enable-file-watchers nil))

(use-package yaml-mode)

(use-package ansible
  :hook (yaml-mode . (lambda ()
		       (ansible 1))))
