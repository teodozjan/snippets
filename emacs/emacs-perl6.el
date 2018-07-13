
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
                                        ;

(column-number-mode t)
(show-paren-mode t)

; Lets disable some things that limits 
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(setq-default indent-tabs-mode nil)

; begin POD
;(if (eq system-type 'windows-nt)
  ; On unix like OS'es it's better to install 
  ; emacs-goodies-el
;;    (add-to-list 'load-path "C:/noinst/emacs-el")
;;  (require 'pod-mode)
;)

;;(add-to-list 'auto-mode-alist '("\\.pod$" . pod-mode))
;;(add-to-list 'auto-mode-alist '("\\.t$" . perl-mode))

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (leuven-theme intellij-theme perl6-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(load-theme 'leuven t)

