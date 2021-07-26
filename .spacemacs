;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(ansible
     systemd
     yaml
     haskell
     finance
     (python :variables
             python-backend 'lsp
             python-lsp-server 'pyright
             python-pipenv-activate t
             python-test-runner 'pytest)
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     auto-completion
     themes-megapack
     ;; better-defaults
     emacs-lisp
     helm
     lsp
     ;; markdown
     multiple-cursors
     (org :variables
          org-directory "~/org"
          org-enable-roam-support t
          org-roam-directory "~/org/notes"
          org-roam-index-file "~/org/notes/index.org")
     git
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     ;; spell-checking
     ;; syntax-checking
     ;; version-control
     treemacs
     elfeed)

   ;; List of additional packages that will be installed without being wrapped
   ;; in a layer (generally the packages are installed only and should still be
   ;; loaded using load/require/use-package in the user-config section below in
   ;; this file). If you need some configuration for these packages, then
   ;; consider creating a layer. You can also put the configuration in
   ;; `dotspacemacs/user-config'. To use a local version of a package, use the
   ;; `:location' property: '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(gnu-apl-mode
                                      keychain-environment)

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only)

  (when (require 'mu4e nil 'noerror)
    (add-to-list 'dotspacemacs-configuration-layers 'mu4e)))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Name of executable file pointing to emacs 27+. This executable must be
   ;; in your PATH.
   ;; (default "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=$HOME/.emacs.d/.cache/dumps/spacemacs-27.1.pdmp
   ;; (default (format "spacemacs-%s.pdmp" emacs-version))
   dotspacemacs-emacs-dumper-dump-file (format "spacemacs-%s.pdmp" emacs-version)

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; Set `read-process-output-max' when startup finishes.
   ;; This defines how much data is read from a foreign process.
   ;; Setting this >= 1 MB should increase performance for lsp servers
   ;; in emacs 27.
   ;; (default (* 1024 1024))
   dotspacemacs-read-process-output-max (* 1024 1024)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. Spacelpa is currently in
   ;; experimental state please use only for testing purposes.
   ;; (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'emacs

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version t

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `recents-by-project' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   ;; The exceptional case is `recents-by-project', where list-type must be a
   ;; pair of numbers, e.g. `(recents-by-project . (7 .  5))', where the first
   ;; number is the project limit and the second the limit on the recent files
   ;; within a project.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Show numbers before the startup list lines. (default t)
   dotspacemacs-show-startup-list-numbers t

   ;; The minimum delay in seconds between number key presses. (default 0.4)
   dotspacemacs-startup-buffer-multi-digit-delay 0.4

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; If non-nil, *scratch* buffer will be persistent. Things you write down in
   ;; *scratch* buffer will be saved and restored automatically.
   dotspacemacs-scratch-buffer-persistent nil

   ;; If non-nil, `kill-buffer' on *scratch* buffer
   ;; will bury it instead of killing.
   dotspacemacs-scratch-buffer-unkillable nil

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(zenburn
                         spacemacs-dark
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font or prioritized list of fonts. The `:size' can be specified as
   ;; a non-negative integer (pixel size), or a floating-point (point size).
   ;; Point size is recommended, because it's device independent. (default 10.0)
   dotspacemacs-default-font '("Source Code Pro"
                               :size 10.0
                               :weight normal
                               :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m" for terminal mode, "<M-return>" for GUI mode).
   ;; Thus M-RET should work as leader key in both GUI and terminal modes.
   ;; C-M-m also should work in terminal mode, but not in GUI mode.
   dotspacemacs-major-mode-emacs-leader-key (if window-system "<M-return>" "C-M-m")

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' in OSX to obtain
   ;; borderless fullscreen. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Show the scroll bar while scrolling. The auto hide time can be configured
   ;; by setting this variable to a number. (default t)
   dotspacemacs-scroll-bar-while-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but lines are only visual lines are counted. For example, folded lines
   ;; will not be counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers 'relative

   ;; Code folding method. Possible values are `evil', `origami' and `vimish'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil and `dotspacemacs-activate-smartparens-mode' is also non-nil,
   ;; `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil smartparens-mode will be enabled in programming modes.
   ;; (default t)
   dotspacemacs-activate-smartparens-mode t

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; If nil then Spacemacs uses default `frame-title-format' to avoid
   ;; performance issues, instead of calculating the frame title by
   ;; `spacemacs/title-prepare' all the time.
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Show trailing whitespace (default t)
   dotspacemacs-show-trailing-whitespace t

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; If non nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfer with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode t

   ;; Accept SPC as y for prompts if non nil. (default nil)
   dotspacemacs-use-SPC-as-y nil

   ;; If non-nil shift your number row to match the entered keyboard layout
   ;; (only in insert state). Currently supported keyboard layouts are:
   ;; `qwerty-us', `qwertz-de' and `querty-ca-fr'.
   ;; New layouts can be added in `spacemacs-editing' layer.
   ;; (default nil)
   dotspacemacs-swap-number-row nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil

   ;; If nil the home buffer shows the full path of agenda items
   ;; and todos. If non nil only the file name is shown.
   dotspacemacs-home-shorten-agenda-source nil

   ;; If non-nil then byte-compile some of Spacemacs files.
   dotspacemacs-byte-compile nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  (setq org-roam-v2-ack t))


(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump.")


(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."
  (require 'org)
  (require 'org-protocol)
  (require 'org-agenda)
  (server-start)
  (setq pschorf/org-agenda-directory "~/org/gtd/")
  (setq pschorf/org-agenda-todo-view
        `(" " "Agenda"
          ((agenda ""
                   ((org-agenda-span 'day)
                    (org-deadline-warning-days 365)))
           (todo "TODO"
                 ((org-agenda-overriding-header "To Refile")
                  (org-agenda-files '(,(concat pschorf/org-agenda-directory "inbox.org")))))
           (todo "NEXT"
                 ((org-agenda-overriding-header "In Progress")
                  (org-agenda-files '(,(concat pschorf/org-agenda-directory "someday.org")
                                      ,(concat pschorf/org-agenda-directory "projects.org")
                                      ,(concat pschorf/org-agenda-directory "next.org")))
                  ))
           (todo "TODO|WAITING"
                 ((org-agenda-overriding-header "Projects")
                  (org-agenda-files '(,(concat pschorf/org-agenda-directory "projects.org")))
                  (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))
                  ))
           (todo "TODO"
                 ((org-agenda-overriding-header "One-off Tasks")
                  (org-agenda-files '(,(concat pschorf/org-agenda-directory "next.org")))
                  (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))))
           nil)
          ((org-agenda-start-with-log-mode t))))
  (setq pschorf/org-weekly-review
        '("W" "Weekly Review"
          agenda ""
          ((org-agenda-start-day "-7d")
           (org-agenda-span 7)
           (org-agenda-start-on-weekday 1)
           (org-agenda-start-with-log-mode t)
           (org-agenda-archives-mode t))))
  (add-to-list 'org-agenda-custom-commands `,pschorf/org-agenda-todo-view)
  (add-to-list 'org-agenda-custom-commands pschorf/org-weekly-review)

  (setq org-columns-default-format "%40ITEM(Task) %Effort(EE){:} %CLOCKSUM(Time Spent) %SCHEDULED(Scheduled) %DEADLINE(Deadline)")
  (defvar pschorf/org-current-effort "1:00"
    "Current effort for agenda items.")

  (defun pschorf/my-org-agenda-set-effort (effort)
    "Set the effort property for the current headline."
    (interactive
     (list (read-string (format "Effort [%s]: " pschorf/org-current-effort) nil nil pschorf/org-current-effort)))
    (setq pschorf/org-current-effort effort)
    (org-agenda-check-no-diary)
    (let* ((hdmarker (or (org-get-at-bol 'org-hd-marker)
                         (org-agenda-error)))
           (buffer (marker-buffer hdmarker))
           (pos (marker-position hdmarker))
           (inhibit-read-only t)
           newhead)
      (org-with-remote-undo buffer
        (with-current-buffer buffer
          (widen)
          (goto-char pos)
          (org-show-context 'agenda)
          (funcall-interactively 'org-set-effort nil pschorf/org-current-effort)
          (end-of-line 1)
          (setq newhead (org-get-heading)))
        (org-agenda-change-all-lines newhead hdmarker))))


  (setq org-agenda-files `("~/todo.org" ,pschorf/org-agenda-directory))
  (setq org-refile-targets `((,(concat pschorf/org-agenda-directory "next.org") :level . 1)
                             (,(concat pschorf/org-agenda-directory "projects.org") :maxlevel . 2)
                             ))

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d@/!)")
          (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")))
  (setq org-tag-alist (quote (("@errand" . ?e)
                              ("@work" . ?w)
                              ("@home" . ?h)
                              ("@cali" . ?c)
                              ("@support" . ?s)
                              ("@jira" . ?j)
                              (:newline)
                              ("WAITING" . ?W)
                              ("HOLD" . ?H)
                              ("CANCELLED" . ?C))))

  (defun pschorf/process-inbox-item ()
    "Process an inbox item"
    (interactive)
    (org-with-wide-buffer
     (org-agenda-set-tags)
     (org-agenda-priority)
     (call-interactively 'pschorf/my-org-agenda-set-effort)
                                        ;       (org-agenda-deadline nil)
     (org-agenda-refile nil nil t)))
  (defun pschorf/start-task ()
    "Start working on a task"
    (interactive)
    (org-agenda-todo "NEXT")
    (org-agenda-clock-in))

  (define-key org-agenda-mode-map "i" 'org-agenda-clock-in)
  (define-key org-agenda-mode-map "r" 'pschorf/process-inbox-item)
  (define-key org-agenda-mode-map "S" 'pschorf/start-task)

  (setq org-capture-templates
        `(("i" "inbox" entry (file ,(concat pschorf/org-agenda-directory "inbox.org"))
           "* TODO %?")
          ("l" "link" entry (file ,(concat pschorf/org-agenda-directory "link.org"))
           "* TODO %(org-cliplink-capture)" :immediate-finish t)
          ("c" "org-protocol-capture" entry (file ,(concat pschorf/org-agenda-directory "inbox.org"))
           "* TODO [[%:link][%:description]]\n\n" :immediate-finish t)
          ("t" "Todo" entry (file+headline "~/todo.org" "Tasks")
           "* TODO %?\n SCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n %a")
          ("m" "Meeting Notes" entry (file+olp+datetree ,(concat org-directory "/meeting_notes.org"))
           "* %?")))
  (defun pschorf/switch-to-agenda ()
    (interactive)
    (org-agenda nil " "))
  (bind-key "<f1>" 'pschorf/switch-to-agenda)

  (spacemacs/toggle-mode-line-org-clock-on)

  (setq jiralib-url "https://robinhood.atlassian.net")

  (defun pschorf/open-jira-ticket-from ()
    (interactive)
    (let ((jira (org-entry-get (point) "JIRA")))
      (if jira
          (let ((jira-url (concat jiralib-url "/browse/" jira)))
            (browse-url-default-macosx-browser jira-url))
        (message "No JIRA property!"))))

  (defun pschorf/set-org-jira-ticket (id)
    (interactive "sJIRA:")
    (let* ((tags (org-get-tags))
           (tags-with-jira (or (member "@jira" tags)
                               (cons "@jira" tags))))
      (org-set-tags tags-with-jira))
    (org-entry-put (point) "JIRA" id))

  (defun pschorf/create-org-helper (id)
    (let* ((jira-summary (shell-command-to-string (concat "jira view -t summary " id))))
      (org-insert-heading-after-current)
      (save-excursion
        (insert jira-summary)
        (org-demote)
        (org-todo "TODO"))
      (save-excursion
        (pschorf/set-org-jira-ticket id))
      (org-priority)))

  (defun pschorf/org-jira-count (key)
    (setq jira-count 0)
    (let ((buffer (current-buffer)))
      (set-buffer (find-file "~/org/gtd/projects.org"))
      (setq jira-count (length (org-map-entries t (concat "JIRA=\"" key "\"") 'file-with-archives)))
      (set-buffer buffer))
    jira-count)

  (defun pschorf/create-org-jira-entry (id)
    (interactive "sJIRA:")
    (with-current-buffer (find-file "~/org/gtd/projects.org")
      (if (= 0 (pschorf/org-jira-count id))
        (org-map-entries (lambda () (pschorf/create-org-helper id)) "ITEM=\"JIRAs\"" 'file))))

  (defun pschorf/create-all-open-jiras ()
    (interactive)
    (let* ((keys-string (shell-command-to-string "jira ls -t key -q \"assignee = 60b03cdbcbc3aa0068e6b233 AND resolution is EMPTY\""))
           (keys (split-string keys-string)))
      (dolist (key keys)
        (pschorf/create-org-jira-entry key))))


  (defvar jira-mode-map (make-sparse-keymap))

  (define-derived-mode jira-mode
    special-mode "JIRA"
    "Jira issue details"
    (use-local-map jira-mode-map)
    (evil-define-key 'normal jira-mode-map
      "q" 'kill-buffer-and-window)
    (evil-define-key 'normal jira-mode-map
      "t" 'pschorf/jira-transition))

  (defun pschorf/jira-transition ()
    (interactive)
    (let* ((transitions-string (shell-command-to-string (concat "jira transitions " issuekey)))
           (transition-lines (seq-filter (lambda (s) (not (string= s ""))) (split-string transitions-string "\n")))
           (choices (mapcar (lambda (s)
                              (let ((pair (split-string s ":")))
                                (list (string-trim (cadr pair))
                                      (string-to-number (string-trim (car pair))))))
                            transition-lines))
           (choice (completing-read "Transition" choices)))
      (shell-command (concat "jira transition --noedit \"" choice "\" " issuekey))
      (pschorf/draw-jira-details-buffer)))

  (defun pschorf/draw-jira-details-buffer ()
    (let ((buffer-read-only nil)
          (jira-details (shell-command-to-string (concat "jira view " issuekey))))
      (erase-buffer)
      (insert jira-details)))

  (defun pschorf/jira-details ()
    (interactive)
    (setq issuekey (org-entry-get (point) "JIRA"))
      (split-window-below-and-focus)
      (switch-to-buffer (get-buffer-create "*JIRA Issue Details*"))
      (make-local-variable 'issuekey)
      (pschorf/draw-jira-details-buffer)
      (jira-mode))

  (spacemacs/declare-prefix-for-mode 'org-mode "mmp" "pschorf")
  (spacemacs/set-leader-keys-for-major-mode 'org-mode "mps" 'pschorf/set-org-jira-ticket)
  (spacemacs/set-leader-keys-for-major-mode 'org-mode "mpo" 'pschorf/open-jira-ticket-from)
  (spacemacs/set-leader-keys "aoj" 'pschorf/jira-details)
  (spacemacs/set-leader-keys "aoJ" 'pschorf/create-all-open-jiras)

  (setq browse-url-browser-function 'browse-url-default-browser)

  (setq epa-pinentry-mode 'loopback)

  (setq lsp-enable-file-watchers nil)
  (use-package org-roam
    :ensure t
    :after org
    :custom
    (org-roam-directory (file-truename "~/org/notes/"))
    (org-roam-db-location (concat org-roam-directory "org-roam.db"))
    :bind (("C-c n l" . org-roam-buffer-toggle)
           ("C-c n f" . org-roam-node-find)
           ("C-c n g" . org-roam-graph)
           ("C-c n i" . org-roam-node-insert)
           ("C-c n c" . org-roam-capture)
           ("C-c n t" . org-roam-dailies-goto-today)
           ("C-c n a" . org-roam-tag-add)
           ;; Dailies
           ("C-c n j" . org-roam-dailies-capture-today))
    :config
    (org-roam-setup))
  (keychain-refresh-environment)
  (setq ledger-post-amount-alignment-at :decimal)
  (when (require 'mu4e nil 'noerror)

    (setq mu4e-maildir (expand-file-name "~/Maildir"))
    (setq mu4e-contexts
          `( ,(make-mu4e-context
               :name "Gmail"
               :vars '((mu4e-drafts-folder . "/Gmail/[Gmail].Drafts")
                       (mu4e-sent-folder . "/Gmail/[Gmail].Sent Mail")
                       (mu4e-trash-folder . "/Gmail/[Gmail].Trash")
                       (mu4e-sent-messages-behavior . 'delete)
                       (mu4e-maildir-shortcuts . (("/Gmail/INBOX" . ?i)
                                                   ("/Gmail/[Gmail].Sent Mail" . ?s)
                                                   ("/Gmail/[Gmail].Trash" . ?t)))
                       (user-mail-address . "pschorf2@gmail.com")))

              ,(make-mu4e-context
               :name "Schorfheide"
               :vars '((mu4e-drafts-folder . "/Schorfheide/Drafts")
                       (mu4e-sent-folder . "/Schorfheide/Sent")
                       (mu4e-trash-folder . "/Schorfheide/Trash")
                       (mu4e-maildir-shortcuts . (("/Schorfheide/INBOX" . ?i)
                                                   ("/Schorfheide/Sent" . ?s)
                                                   ("/Schorfheide/Trash" . ?s)))
                       (user-mail-address . "paul@schorfheide.org")))))

    (setq mu4e-get-mail-command "offlineimap")
    (require 'smtpmail)
    (setq user-full-name "Paul Schorfheide")

    (setq message-send-mail-function 'smtpmail-send-it
          starttls-use-gnutls t
          smtpmail-starttls-credentials
          '(("smtp.gmail.com" 587 nil nil))
          smtpmail-auth-credentials
          (expand-file-name "~/.authinfo.gpg")
          smtpmail-default-smtp-server "smtp.gmail.com"
          smtpmail-smtp-server "smtp.gmail.com"
          smtpmail-smtp-service 587
          smtpmail-debug-info t)
    (defun mu4e-maybe-fetch-mail (prefix)
      (interactive "P")
      (if prefix
          (mu4e-update-mail-and-index nil)
        (mu4e-update-index)))
    (define-key mu4e-main-mode-map (kbd "U") 'mu4e-maybe-fetch-mail)
    ))


;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elfeed-feeds
   '("https://www.reddit.com/r/emacs/.rss" "https://www.bloomberg.com/opinion/authors/ARbTQlRLRjE/matthew-s-levine.rss" "https://www.reddit.com/r/apachespark/.rss"))
 '(evil-want-Y-yank-to-eol nil)
 '(ledger-reports
   '(("mkt" "ledger -V -f ~/budget.ledger --price-db ~/prices.db balance")
     ("bal" "%(binary) -f %(ledger-file) bal")
     ("reg" "%(binary) -f %(ledger-file) reg")
     ("payee" "%(binary) -f %(ledger-file) reg @%(payee)")
     ("account" "%(binary) -f %(ledger-file) reg %(account)")))
 '(package-selected-packages
   '(jinja2-mode company-ansible ansible-doc ansible systemd flycheck-ledger evil-ledger ledger-mode keychain-environment gnu-apl-mode zenburn-theme zen-and-art-theme yasnippet-snippets yapfify yaml-mode xterm-color ws-butler writeroom-mode winum white-sand-theme which-key vterm volatile-highlights vi-tilde-fringe uuidgen use-package undo-tree underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme treemacs-projectile treemacs-persp treemacs-magit treemacs-icons-dired treemacs-evil toxi-theme toc-org terminal-here tao-theme tangotango-theme tango-plus-theme tango-2-theme symon symbol-overlay sunny-day-theme sublime-themes subatomic256-theme subatomic-theme string-inflection string-edit sphinx-doc spaceline-all-the-icons spacegray-theme soothe-theme solarized-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme smeargle shell-pop seti-theme reverse-theme restart-emacs rebecca-theme rainbow-delimiters railscasts-theme quickrun pytest pyenv-mode py-isort purple-haze-theme professional-theme poetry planet-theme pippel pipenv pip-requirements phoenix-dark-pink-theme phoenix-dark-mono-theme pcre2el password-generator paradox overseer orgit-forge organic-green-theme org-superstar org-roam org-rich-yank org-projectile org-present org-pomodoro org-mime org-download org-contrib org-cliplink org-brain open-junk-file omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme nose noctilux-theme naquadah-theme nameless mustang-theme multi-term multi-line monokai-theme monochrome-theme molokai-theme moe-theme modus-vivendi-theme modus-operandi-theme minimal-theme material-theme majapahit-theme madhat2r-theme macrostep lush-theme lsp-ui lsp-python-ms lsp-pyright lsp-origami lorem-ipsum live-py-mode link-hint light-soap-theme kaolin-themes jbeans-theme jazz-theme ir-black-theme inkpot-theme indent-guide importmagic hybrid-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers highlight-indentation heroku-theme hemisu-theme helm-xref helm-themes helm-swoop helm-pydoc helm-purpose helm-projectile helm-org-rifle helm-org helm-mode-manager helm-make helm-lsp helm-ls-git helm-gitignore helm-git-grep helm-flx helm-descbinds helm-company helm-c-yasnippet helm-ag hc-zenburn-theme gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme google-translate golden-ratio gnuplot gitignore-templates gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gandalf-theme fuzzy font-lock+ flycheck-pos-tip flycheck-package flycheck-elsa flx-ido flatui-theme flatland-theme farmhouse-theme fancy-battery eziam-theme eyebrowse expand-region exotica-theme evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-textobj-line evil-surround evil-org evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-escape evil-ediff evil-easymotion evil-collection evil-cleverparens evil-args evil-anzu eval-sexp-fu espresso-theme eshell-z eshell-prompt-extras esh-help emr elisp-slime-nav elfeed-org elfeed-goodies editorconfig dumb-jump drag-stuff dracula-theme dotenv-mode doom-themes django-theme dired-quick-sort diminish define-word darktooth-theme darkokai-theme darkmine-theme darkburn-theme dap-mode dakrone-theme cython-mode cyberpunk-theme company-anaconda column-enforce-mode color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized clues-theme clean-aindent-mode chocolate-theme cherry-blossom-theme centered-cursor-mode busybee-theme bubbleberry-theme blacken birds-of-paradise-plus-theme badwolf-theme auto-yasnippet auto-highlight-symbol auto-compile apropospriate-theme anti-zenburn-theme ample-zen-theme ample-theme alect-themes aggressive-indent afternoon-theme ace-link ace-jump-helm-line ac-ispell)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
