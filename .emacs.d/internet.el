(use-package elfeed
  :ensure t
  :init
  (setq elfeed-feeds '(("ttrss+https://paul@rss.schorfheide.org/tt-rss" :use-authinfo t)))
  :bind (:map elfeed-search-mode-map
	      ("U" . elfeed-update))
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

  
(use-package smudge
  :ensure t)

(defhydra hydra-spotify (:hint nil)
    "
^Search^                  ^Control^               ^Manage^
^^^^^^^^-----------------------------------------------------------------
_t_: Track               _SPC_: Play/Pause        _+_: Volume up
_m_: My Playlists        _n_  : Next Track        _-_: Volume down
_f_: Featured Playlists  _p_  : Previous Track    _x_: Mute
_u_: User Playlists      _r_  : Repeat            _d_: Device
^^                       _s_  : Shuffle           _q_: Quit
"
    ("t" smudge-track-search :exit t)
    ("m" smudge-my-playlists :exit t)
    ("f" smudge-featured-playlists :exit t)
    ("u" smudge-user-playlists :exit t)
    ("SPC" smudge-controller-toggle-play :exit nil)
    ("n" smudge-controller-next-track :exit nil)
    ("p" smudge-controller-previous-track :exit nil)
    ("r" smudge-controller-toggle-repeat :exit nil)
    ("s" smudge-controller-toggle-shuffle :exit nil)
    ("+" smudge-controller-volume-up :exit nil)
    ("-" smudge-controller-volume-down :exit nil)
    ("x" smudge-controller-volume-mute-unmute :exit nil)
    ("d" smudge-select-device :exit nil)
    ("q" quit-window "quit" :color blue))

(bind-key "C-c C-. a" #'hydra-spotify/body)
