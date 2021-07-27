(use-package elfeed
  :ensure t
  :init
  (setq elfeed-feeds '("https://www.reddit.com/r/emacs/.rss" "https://www.bloomberg.com/opinion/authors/ARbTQlRLRjE/matthew-s-levine.rss" "https://www.reddit.com/r/apachespark/.rss" "https://www.reddit.com/r/haskell/.rss"))
  :commands elfeed)

(setq erc-autojoin-channels-alist
      '(("libera.chat" "#emacs" "#archlinux" "#python" "#haskell")))
(setq erc-track-position-in-mode-line t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT"))
(global-set-key (kbd "C-c C-SPC") 'erc-track-switch-buffer)
(setq erc-prompt-for-password nil)

  
