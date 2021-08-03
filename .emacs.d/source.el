(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (push 'company-capf company-backends))
