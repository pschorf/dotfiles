(when (require 'mu4e nil 'noerror)
  
  (setq mu4e-maildir (expand-file-name "~/Maildir"))
  (setq mu4e-drafts-folder "/Drafts")
  (setq mu4e-sent-folder "/Sent")
  (setq mu4e-trash-folder "/Trash")
  (setq mu4e-maildir-shortcuts '(("/INBOX" . ?i)
				 ("/Sent" . ?s)
				 ("/Trash" . ?t)))
  (setq user-mail-address "paul@schorfheide.org")
  
  (setq mu4e-get-mail-command "offlineimap")
  (require 'smtpmail)
  (setq user-full-name "Paul Schorfheide")
  (setq mu4e-attachment-dir "~/Downloads")
  (setq mu4e-sent-messages-behavior (lambda ()
                                      (if (string= (message-sendmail-envelope-from) "pschorf2@gmail.com")
                                          'delete 'sent)))
  (setq message-send-mail-function 'smtpmail-send-it
        starttls-use-gnutls t
        smtpmail-starttls-credentials
        '(("mail.schorfheide.org" 2525 nil nil))
        smtpmail-auth-credentials
        (expand-file-name "~/.authinfo.gpg")
        smtpmail-default-smtp-server "mail.schorfheide.org"
        smtpmail-smtp-server "mail.schorfheide.org"
        smtpmail-smtp-service 2525
        smtpmail-debug-info t)
  (defun mu4e-maybe-fetch-mail (prefix)
    (interactive "P")
    (if prefix
        (mu4e-update-mail-and-index nil)
      (mu4e-update-index))))

(setq mml-smime-use 'epg)
(setq mml-default-encrypt-method "smime")
(setq mml-default-sign-method "smime")
