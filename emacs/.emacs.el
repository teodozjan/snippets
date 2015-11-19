; View
(column-number-mode t)
(show-paren-mode t)
(load-theme 'leuven t)

; Lets disable some things that limits 
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(setq-default indent-tabs-mode nil)

; begin POD
(if (eq system-type 'windows-nt)
  ; On unix like OS'es it's better to install 
  ; emacs-goodies-el
  (add-to-list 'load-path "C:/noinst/emacs-el")
  (require 'pod-mode)
)

(add-to-list 'auto-mode-alist '("\\.pod$" . pod-mode))
(add-to-list 'auto-mode-alist '("\\.t$" . perl-mode))

    (setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))
