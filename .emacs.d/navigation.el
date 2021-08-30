(use-package winum
  :ensure t
  :bind (("s-1" . 'winum-select-window-1)
	 ("s-2" . 'winum-select-window-2)
	 ("s-3" . 'winum-select-window-3)
	 ("s-4" . 'winum-select-window-4))
  :config
  (winum-mode))

(global-set-key (kbd "M-i") 'imenu)

(use-package ivy
  :ensure t
  :config
  (ivy-mode))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package hydra
  :ensure t)

(setq-default abbrev-mode t)
