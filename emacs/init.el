;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
;;(setenv "TZ" "Europe/Warsaw")


(column-number-mode t)
(show-paren-mode t)

; Lets disable some things that limits
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(setq-default indent-tabs-mode nil)

; Get rid of eggdrop
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))


(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))



;; Install additinal themes from melpa
;; make sure to use :defer keyword
(use-package hemera-theme :ensure :defer)
(use-package logview :ensure :defer
  :init
  (add-hook #'log4j-mode-hook #'view-mode)
  (add-hook #'log4j-mode-hook #'read-only-mode)
  (add-hook #'log4j-mode-hook 'eos/turn-on-hl-line))

(setq-default logview-additional-submodes
              '(("NoClassnameLog4j"
                 (format . "TIMESTAMP [THREAD] LEVEL -")
                 (levels . "SLF4J")
                 (timestamp)
                 (aliases))))
              

;;(logview-additional-submodes
;;  '(("ADVALog4j"
;;    (format . "TIMESTAMP [THREAD] LEVEL -")
;;     (levels . "SLF4J")
;;     (timestamp)
;;     (aliases))))
;;(logview-auto-revert-mode 'auto-revert-tail-mode)
;;(package-selected-packages '(circadian nyx-theme hemera-theme use-package)))


(use-package vlf :ensure :defer)
(use-package nyx-theme :ensure :defer)
(use-package circadian :ensure :defer)
(use-package perl6-mode
  :ensure t
  :defer t)

(use-package circadian
  :ensure t
  :config
  (setq calendar-latitude 54.5)
  (setq calendar-longitude 18.5)
  (setq circadian-themes '((:sunrise . hemera)
                           (:sunset  . nyx)))
  (circadian-setup))

(require 'server)
(unless (server-running-p)
  (server-start)) 

(desktop-save-mode 1)

