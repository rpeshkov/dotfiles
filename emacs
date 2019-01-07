;; Initializing package manager
(package-initialize)

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Disable Splash, Startup message
(setq inhibit-splash-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)

;; Disabling toolbar
(tool-bar-mode -1)

;; Disabling scrollbar
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Display line numbers
(global-display-line-numbers-mode)

;; Display column number in modeline
(column-number-mode)

;; Setting font
(add-to-list 'default-frame-alist '(font . "IBM Plex Mono-12"))

;; Shut the f*ck up!
(setq ring-bell-function 'ignore)

;; Show matching parens
(show-paren-mode 1)
(setq show-paren-style 'expression)

;; Tab width. Obsiously... Not exactly
(setq-default indent-tabs-mode nil)
(setq tab-width 4)
(setq-default c-basic-offset 4)
(setq-default standart-indent 4)

;; Set Cmd+left and Cmd+right to move beginning/end of line respectively
(global-set-key (kbd "<s-right>") 'move-end-of-line)
(global-set-key (kbd "<s-left>") 'move-beginning-of-line)

(global-set-key (kbd "C-c C-f") 'hs-toggle-hiding)


(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
	doom-themes-enable-italic t)
  (load-theme 'doom-one t))

(use-package visual-fill-column
  :ensure t)

;; Markdown stuff
(use-package markdown-mode
  :ensure t
  :mode "\\.md\\'"
  :commands (markdown-mode gfm-mode)
  :init (setq markdown-command "/usr/local/bin/pandoc"))

(add-hook 'markdown-mode-hook (lambda()
				(visual-fill-column-mode t)
				(set-fill-column 80)))

;; Modeline
(use-package smart-mode-line-atom-one-dark-theme
  :ensure t)

(use-package smart-mode-line
  :requires smart-mode-line-atom-one-dark-theme
  :ensure t
  :config
  (setq sml/theme 'atom-one-dark)
  (setq sml/no-confirm-load-theme t)
  (sml/setup))

;; TODO: Right margin is still subject to research. All the solutions I've seen
;; are work quite bad... I just want line on 80 column and that's it...


;; Start as a server if it's not running yet
(require 'server)
(unless (server-running-p)
  (server-start))

;; Draw empty lines indicator
(setq-default indicate-empty-lines t)

(setq require-final-newline t)
(setq next-line-add-newlines nil)

(global-set-key (kbd "C-c o")
                (lambda() (interactive) (find-file "~/organizer.org")))

(global-set-key (kbd "C-c C-e")
                (lambda() (interactive) (find-file "~/.emacs")))
