(use-package literate-calc-mode
  :ensure t
  :commands (literate-calc-mode literate-calc-minor-mode)
  :bind (:map calc-dispatch-map
	      ("l" . 'literate-calc-minor-mode)))

(use-package ledger-mode
  :ensure t
  :commands (ledger-mode)
  :config
  (setq ledger-post-amount-alignment-at :decimal))
