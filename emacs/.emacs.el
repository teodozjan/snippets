
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)


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
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
  (require 'diminish)
  (require 'bind-key)


;; Install additinal themes from melpa
;; make sure to use :defer keyword
(use-package hemera-theme :ensure :defer)
(use-package nyx-theme :ensure :defer)


(use-package circadian
  :ensure t
  :config
  (setq calendar-latitude 54.5)
  (setq calendar-longitude 18.5)
  (setq circadian-themes '((:sunrise . hemera)
                           (:sunset  . nyx)))
  (circadian-setup))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("2e1e2657303116350fe764484e8300ca2e4cf45a73cdbd879bc0ca29cb337147" "3c06231f8aa4ad2ebc07d70ade7a1d310cc2adab02251c77a1882787e30f8394" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
