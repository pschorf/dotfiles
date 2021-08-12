(setq jiralib-url "https://robinhood.atlassian.net")
(setq jira-binary "/usr/local/bin/jira")


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
    (let* ((jira-summary (shell-command-to-string (concat jira-binary " view -t summary " id))))
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
    (let* ((keys-string (shell-command-to-string (concat jira-binary " ls -t key -q \"assignee = 60b03cdbcbc3aa0068e6b233 AND resolution is EMPTY\"")))
           (keys (split-string keys-string)))
      (dolist (key keys)
        (pschorf/create-org-jira-entry key))))


  (defvar jira-mode-map (make-sparse-keymap))

  (define-derived-mode jira-mode
    special-mode "JIRA"
    "Jira issue details"
    (use-local-map jira-mode-map)
    (bind-key (kbd "q") 'kill-buffer-and-window jira-mode-map)
    (bind-key (kbd "t") 'pschorf/jira-transition jira-mode-map))

  (defun pschorf/jira-transition ()
    (interactive)
    (let* ((transitions-string (shell-command-to-string (concat jira-binary " transitions " issuekey)))
           (transition-lines (seq-filter (lambda (s) (not (string= s ""))) (split-string transitions-string "\n")))
           (choices (mapcar (lambda (s)
                              (let ((pair (split-string s ":")))
                                (list (string-trim (cadr pair))
                                      (string-to-number (string-trim (car pair))))))
                            transition-lines))
           (choice (completing-read "Transition" choices)))
      (shell-command (concat jira-binary " transition --noedit \"" choice "\" " issuekey))
      (pschorf/draw-jira-details-buffer)))

  (defun pschorf/draw-jira-details-buffer ()
    (let ((buffer-read-only nil)
          (jira-details (shell-command-to-string (concat jira-binary " view " issuekey))))
      (erase-buffer)
      (insert jira-details)))

  (defun pschorf/jira-details ()
    (interactive)
    (setq issuekey (org-entry-get (point) "JIRA"))
    (split-window-below)
    (select-window (window-in-direction 'below))
    (switch-to-buffer (get-buffer-create "*JIRA Issue Details*"))
    (make-local-variable 'issuekey)
    (pschorf/draw-jira-details-buffer)
    (jira-mode))
