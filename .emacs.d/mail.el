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
    (define-key mu4e-main-mode-map (kbd "U") 'mu4e-maybe-fetch-mail))
