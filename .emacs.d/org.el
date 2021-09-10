(require 'org)
(require 'org-protocol)
(require 'org-agenda)

(setq org-directory "~/org")

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c a") 'org-agenda)


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
				   ,(concat pschorf/org-agenda-directory "next.org")
				   "~/org/notes"))
	       ))
	(todo "TODO|WAITING"
	      ((org-agenda-overriding-header "Projects")
	       (org-agenda-files '(,(concat pschorf/org-agenda-directory "projects.org")))
	       (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))
	       ))
	(todo "TODO|WAITING"
	      ((org-agenda-overriding-header "One-off Tasks")
	       (org-agenda-files '(,(concat pschorf/org-agenda-directory "next.org")))
	       (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))))
	(todo "TODO"
	      ((org-agenda-overriding-header "Roam")
	       (org-agenda-files '("~/org/notes"))
	       (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))))
	(todo "CODE REVIEW"
	      ((org-agenda-overriding-header "Code Reviews")
	       (org-agenda-files '("~/org/notes" "~/org/gtd"))))
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
(setq pschorf/active-threads
      '("A" "Active/Blocked Tasks"
	tags-todo "@Active|@Blocked/!TODO|NEXT"))
(setq pschorf/goals-for-week
      '("G" "Goals for the week"
	tags-todo "@gftw/!TODO|NEXT"))

(add-to-list 'org-agenda-custom-commands `,pschorf/org-agenda-todo-view)
(add-to-list 'org-agenda-custom-commands pschorf/org-weekly-review)
(add-to-list 'org-agenda-custom-commands pschorf/active-threads)
(add-to-list 'org-agenda-custom-commands pschorf/goals-for-week)


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


(setq org-agenda-files `("~/org/meeting_notes.org"
			 ,pschorf/org-agenda-directory
			 "~/org/notes"
			 "~/org/notes/daily"))
(setq org-refile-targets `((,(concat pschorf/org-agenda-directory "next.org") :level . 1)
			  (,(concat pschorf/org-agenda-directory "projects.org") :maxlevel . 2)
			  ))

(setq org-todo-keywords
     '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d@/!)")
       (sequence "WAITING(w@/!)" "CODE REVIEW(r@/!)" "|" "CANCELLED(c@/!)")))
(setq org-tag-alist (quote (("@errand" . ?e)
			   ("@work" . ?w)
			   ("@home" . ?h)
			   ("@cali" . ?c)
			   ("@support" . ?s)
			   ("@jira" . ?j)
			   ("@gftw" . ?g)
			   (:newline)
			   (:startgroup . nil)
			   ("@Active" . ?a)
			   ("@Blocked" . ?B)
			   ("@Backburner" . ?b)
			   (:endgroup . nil)
			   (:newline)
			   ("WAITING" . ?W)
			   ("HOLD" . ?H)
			   ("CANCELLED" . ?C))))
(setq org-tag-persistent-alist org-tag-alist)

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


(defun pschorf/switch-to-agenda ()
 (interactive)
 (org-agenda nil " "))
(bind-key "<f1>" 'pschorf/switch-to-agenda)

(use-package org-roam
  :ensure t
  :after org
  :init
  (setq org-roam-v2-ack t)
  (setq org-roam-directory (file-truename "~/org/notes/"))
  (setq org-roam-db-location (concat org-roam-directory "org-roam.db"))
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
	 ("C-c n r" . org-roam-ref-add)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  (org-roam-setup)
  (add-to-list 'org-roam-capture-templates
	     '("p" "project" plain "%?"         
               :if-new (file+head "%<%Y%m%d%H%M%S>-project-${slug}.org"                                                   
				  "#+title: Project ${title}

Description

- Tags ::  
  - [[file:projects.org][Projects]]

,* Setup :ignore:
,* Resources and other Materials :ignore:
,* Development Process
,* Tasks Table :ignore:

,#+COLUMNS: \\\\\\%ITEM \\\\\\%TAGS %PRIORITY \\\\\\%TODO(STATUS) \\\\\\%CREATED \\\\\\%CLOCKSUM %SCHEDULED %DEADLINE %STARTED \\\\\\%CLOSED
,#+BEGIN: columnview :hlines 2 :indent t :id global :exclude-tags (\"ignore\")
,#+END:
")
:unnarrowed t)))
(define-key org-mode-map (kbd "C-c C-w") 'org-refile)


(use-package ox-gemini
  :ensure t)


(setq org-roam-completion-everywhere t)


(defun org-babel-execute:presto (body params)
  "Execute a presto query"
  (let ((in-file (org-babel-temp-file "p" ".presto")))
    (with-temp-file in-file
      (insert body))
    (org-babel-eval
     (format "~/scripts/presto-query %s"
	     (org-babel-process-file-name in-file))
     "")))

     

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

(setq org-log-done 'time)
