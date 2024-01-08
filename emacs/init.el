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
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
;(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown"))



(eval-when-compile
  (require 'use-package))

(use-package csv-mode :ensure :defer)

(use-package logview :ensure :defer
  :init
  (add-hook #'log4j-mode-hook #'view-mode)
  (add-hook #'log4j-mode-hook #'read-only-mode)
  (add-hook #'log4j-mode-hook 'eos/turn-on-hl-line))

(setq-default logview-additional-submodes
              '(("ADVALog4j"
                 (format . "TIMESTAMP [THREAD] LEVEL -")
                 (levels . "SLF4J")
                 (timestamp)
                 (aliases))))
              

(use-package vlf :ensure :defer)
(use-package yaml-mode :ensure :defer)
;(use-package circadian :ensure :defer)
;(use-package cloud-theme :ensure :defer)
;(use-package monokai-pro-theme :ensure :defer)
(use-package nyx-theme :ensure :defer)
;(use-package nord-theme :ensure :defer)

(use-package raku-mode
  :ensure t
  :defer t)
 
;(use-package circadian
;  :ensure t
;  :config
;  (setq calendar-latitude 54.5)
;  (setq calendar-longitude 18.5)
;  (setq circadian-themes '((:sunrise . spacemacs)
;                           (:sunset  . nyx)))
;  (circadian-setup))
(load-theme 'nyx t)
;(when (display-graphic-p)
;  (invert-face 'default)
;)
;(set-variable 'frame-background-mode 'dark)
(require 'server)
(unless (server-running-p)
  (server-start)) 

(use-package dired-sidebar
  :ensure t
  :commands (dired-sidebar-toggle-sidebar))

(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :init
  (add-hook 'dired-sidebar-mode-hook
            (lambda ()
              (unless (file-remote-p default-directory)
                (auto-revert-mode))))
  :config
  (push 'toggle-window-split dired-sidebar-toggle-hidden-commands)
  (push 'rotate-windows dired-sidebar-toggle-hidden-commands)

  (setq dired-sidebar-subtree-line-prefix "__")
  (setq dired-sidebar-theme 'vscode)
  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t))

(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(use-package dashboard
    :ensure t
    :diminish dashboard-mode
    :config
    (setq dashboard-banner-logo-title "C-xC-r recentf-open-file|C-x C-n dired-sidebar ")
    ;;(setq dashboard-startup-banner "/path/to/image")
    (setq dashboard-items '((recents  . 10)
                            (bookmarks . 10)))
    (dashboard-setup-startup-hook))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(dired-sidebar vlf use-package persistent-scratch raku-mode nyx-theme monokai-pro-theme logview hemera-theme circadian)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
