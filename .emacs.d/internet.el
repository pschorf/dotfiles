(use-package elfeed
  :ensure t
  :init
  (setq elfeed-feeds '(("ttrss+https://paul@rss.schorfheide.org/tt-rss" :use-authinfo t)))
  :bind (:map elfeed-search-mode-map
	      ("U" . elfeed-protocol-ttrss-update))
  :commands elfeed)

(use-package elfeed-protocol
  :ensure t
  :init
  (setq elfeed-protocol-ttrss-maxsize 200)
  :config
  (elfeed-protocol-enable))

(use-package elpher
  :ensure t
  :commands elpher)

(setq erc-autojoin-channels-alist
      '(("libera.chat" "#emacs" "#archlinux" "#python" "#haskell" "##rust")
	("irc.oftc.net" "#kernelnewbies")))
(setq erc-track-position-in-mode-line t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT"))
(setq erc-prompt-for-password nil)
(setq erc-nick "pschorf")
(setq erc-default-server "irc.libera.chat")
