;; Initializing package manager
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" default)))
 '(package-selected-packages
   (quote
    (markdown-mode use-package doom-themes atom-one-dark-theme))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 
;; Disable Splash, Startup message
(setq inhibit-splash-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;; I don't disable menubar, since I'm on MacOS and it
;; doesn't waste Emacs' window space

;; Disabling toolbar
(tool-bar-mode -1)

;; Disabling scrollbar
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(global-display-line-numbers-mode)

(require 'doom-themes)

(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
(load-theme 'doom-molokai t)

;; Setting font
(add-to-list 'default-frame-alist '(font . "IBM Plex Mono-12"))

;; Shut the f*ck up!
(setq ring-bell-function 'ignore)

;; Markdown stuff
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :init (setq markdown-command "/usr/local/bin/pandoc"))
