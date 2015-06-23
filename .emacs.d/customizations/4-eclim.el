(require 'eclim)
(global-eclim-mode)

(require 'eclimd)
(custom-set-variables
 '(eclim-eclipse-dirs '("~/tools/eclipse"))
 '(eclim-executable "~/tools/eclipse/eclim"))

(require 'company-emacs-eclim)
(company-emacs-eclim-setup)
(global-company-mode t)
