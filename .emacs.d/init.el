(if (getenv "http_proxy")
  (setq url-proxy-services
        '(("http" . "127.0.0.1:3000")
          ("https" . "127.0.0.1:3000"))))

(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
(load-theme 'zenburn t)
(add-hook 'haskell-mode-hook 'haskell-indent-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

(setq jiralib-url "https://jira.twosigma.com:10101/jira")
(require 'org-jira)

(require 'org-install)

(require 'org-trello)


(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

(define-key mode-specific-map [?a] 'org-agenda)
(require 'org-agenda)

(eval-after-load "org-agenda"
  '(progn
     (define-prefix-command 'org-todo-state-map)

     (define-key org-mode-map "\C-cx" 'org-todo-state-map)

     (define-key org-todo-state-map "x"
       #'(lambda nil (interactive) (org-todo "CANCELLED")))
     (define-key org-todo-state-map "d"
       #'(lambda nil (interactive) (org-todo "DONE")))
     (define-key org-todo-state-map "f"
       #'(lambda nil (interactive) (org-todo "DEFERRED")))
     (define-key org-todo-state-map "l"
       #'(lambda nil (interactive) (org-todo "DELEGATED")))
     (define-key org-todo-state-map "s"
       #'(lambda nil (interactive) (org-todo "STARTED")))
     (define-key org-todo-state-map "w"
       #'(lambda nil (interactive) (org-todo "WAITING")))

     (define-key org-agenda-mode-map "\C-n" 'next-line)
     (define-key org-agenda-keymap "\C-n" 'next-line)
     (define-key org-agenda-mode-map "\C-p" 'previous-line)
     (define-key org-agenda-keymap "\C-p" 'previous-line)))

;(add-hook 'remember-mode-hook 'org-remember-apply-template)

(define-key global-map "\C-cc" 'org-capture)

(custom-set-variables
 '(org-agenda-files (quote ("~/todo.org")))
 '(org-default-notes-file "~/notes.org")
 '(org-agenda-ndays 7)
 '(org-deadline-warning-days 14)
 '(org-agenda-show-all-dates t)
 '(org-agenda-skip-deadline-if-done t)
 '(org-agenda-skip-scheduled-if-done t)
 '(org-agenda-start-on-weekday nil)
 '(org-reverse-note-order t)
 '(org-fast-tag-selection-single-key (quote expert))
 '(org-agenda-custom-commands
   (quote (("d" todo "DELEGATED" nil)
	   ("c" todo "DONE|DEFERRED|CANCELLED" nil)
	   ("w" todo "WAITING" nil)
	   ("W" agenda "" ((org-agenda-ndays 21)))
	   ("A" agenda ""
	    ((org-agenda-skip-function
	      (lambda nil
		(org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]")))
	     (org-agenda-ndays 1)
	     (org-agenda-overriding-header "Today's Priority #A tasks: ")))
	   ("u" alltodo ""
	    ((org-agenda-skip-function
	      (lambda nil
		(org-agenda-skip-entry-if (quote scheduled) (quote deadline)
					  (quote regexp) "\n]+>")))
	     (org-agenda-overriding-header "Unscheduled TODO entries: "))))))
; '(org-remember-store-without-prompt t)
 '(org-capture-templates
   '(("t" "Todo" entry (file+headline "~/todo.org" "tasks") "** TODO %?\n %u\n")
     ("r" "Trello note" entry (file "~/org/paul.trello") "* To-Do %?\n %u\n"))))
; '(remember-annotation-functions (quote (org-remember-annotation)))
; '(remember-handler-functions (quote (org-remember-handler))))

(require 'monky)

(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

(setq magit-last-seen-setup-instructions "1.4.0")

(add-to-list 'auto-mode-alist '("\\.trello$" . org-mode))

(add-hook 'org-mode-hook
         (lambda ()
          (let ((filename (buffer-file-name (current-buffer))))
              (when (and filename (string= "trello" (file-name-extension filename)))
               (org-trello-mode)))))

(mapc 'load (directory-files "~/.emacs.d/customizations" t "^[0-9]+.*\.el$"))

(global-set-key (kbd "M-i") 'imenu)

(require 'helm-config)

(global-set-key [remap dabbrev-expand] 'hippie-expand)

(require 'ein)
