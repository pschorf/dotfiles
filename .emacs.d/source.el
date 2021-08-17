(use-package company
  :ensure t
  :hook (scala-mode . company-mode)
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq lsp-completion-provider :capf)
  (push 'company-capf company-backends))
