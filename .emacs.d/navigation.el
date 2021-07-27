(use-package winum
  :ensure t
  :bind (("s-1" . 'winum-select-window-1)
	 ("s-2" . 'winum-select-window-2)
	 ("s-3" . 'winum-select-window-3)
	 ("s-4" . 'winum-select-window-4))
  :config
  (winum-mode))

(global-set-key (kbd "M-i") 'imenu)

(use-package helm
  :straight t
  :bind (("M-x" . 'helm-M-x)
	 ("C-x C-f" . 'helm-find-files))
  :config
  (helm-mode 1))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))
