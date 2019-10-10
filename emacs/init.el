(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "org"  (concat proto "://orgmode.org/elpa/")) t)

  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flycheck evil-commentary evil-leader evil-surround zenburn-theme evil org-plus-contrib magit helm))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; enable vim leader key
(global-evil-leader-mode)
;; set leader key to space
(evil-leader/set-leader "<SPC>")

;; enable vim keybindings
(evil-mode 1)

;; enable commentary
(evil-commentary-mode)
;; enable surround
(global-evil-surround-mode 1)

;; enable line numbers
(global-display-line-numbers-mode t)

;; enable flycheck
(global-flycheck-mode t)

;; set theme
(load-theme 'zenburn t)

;; set font
(add-to-list 'default-frame-alist '(font . "Fantasque Sans Mono-14"))

;; turn on bracket match highlight
(show-paren-mode 1)

;; UTF-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; stop creating those backup~ files
(setq-default make-backup-files nil)

;; stop creating those #auto-save# files
(setq-default auto-save-default nil)

;; when a file is updated outside emacs, make it update if it's already opened in emacs
(global-auto-revert-mode 1)

;; add new line at end of file when saved
(setq-default require-final-newline t)

;; show trailing whitespace
(setq-default show-trailing-whitespace t)
