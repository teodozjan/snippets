(server-start)
(defalias 'perl-mode 'cperl-mode)
(column-number-mode t)
(show-paren-mode t)
;(desktop-save-mode 1)
(global-hl-line-mode 1)
(setq c-auto-newline 1)
(setq cperl-auto-newline t)
(load-theme 'tango t)

(add-hook 'text-mode-hook (lambda () (setq truncate-lines t)))
(set-face-foreground 'font-lock-comment-face "slate gray")
