;;; init.el --- user-init-file                    -*- lexical-binding: t -*-

(setq gc-cons-threshold (* 50 1000 1000))

;; Beautify on macos
(when (equal system-type 'darwin)
  (setq ns-alternate-modifier 'meta
        ns-command-modifier 'super
        ns-use-proxy-icon nil
        initial-frame-alist
	(append
	 '((ns-transparent-titlebar . nil)
	   (ns-appearance . dark)
	   (vertical-scroll-bars . nil)
	   (internal-border-width . 0)))))

(unless (eq window-system 'ns)
  (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Package manager initialization
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package)
  (require 'use-package-ensure)
  (setq use-package-always-ensure t)
 )

(use-package custom
  :ensure nil
  :config
  (setq custom-file (expand-file-name "custom.el" user-emacs-directory))
  (when (file-exists-p custom-file)
    (load custom-file)))

(use-package exec-path-from-shell
  :if
  (memq window-system '(mac ns))
  :config
  (setq exec-path-from-shell-check-startup-files nil)
  (exec-path-from-shell-initialize))

(use-package diminish)

(use-package hl-line
  :ensure nil
  :hook
  ((prog-mode yaml-mode markdown-mode gitignore-mode conf-mode) . hl-line-mode))

(use-package display-line-numbers
  :ensure nil
  :hook
  ((prog-mode yaml-mode markdown-mode gitignore-mode conf-mode) . display-line-numbers-mode))

(use-package recentf
  :defer 2
  :ensure nil
  :config
  (recentf-mode 1))

(use-package which-key
  :defer 2
  :diminish
  :commands which-key-mode
  :config (which-key-mode))

(use-package editorconfig
  :defer 2
  :config
  (editorconfig-mode 1))

(use-package doom-themes
  :init
  (setq doom-one-brighter-modeline t
        doom-one-padded-modeline t
   doom-dracula-brighter-modeline t
	doom-dracula-padded-modeline t
	doom-dracula-colorful-headers t)
  :config
  (load-theme 'doom-one t))


(use-package multiple-cursors
  :bind
  (("C->" . mc/mark-next-like-this)
   ("M-I" . mc/edit-lines)))

(use-package org
  :defer t
  :init
  (setq org-agenda-files '("~/Documents/Notes")
	org-directory "~/Documents/Notes/"
	org-default-notes-file "~/Documents/Notes/tracker.org"
	org-fontify-whole-heading-line t
	org-pretty-entities t
        org-tags-column -97
        org-agenda-tags-column -100
        ;; org-startup-indented t
        )
  :config
  (use-package ob-applescript)
  (use-package ob-shell :ensure nil)

  )

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package ivy
  :demand t
  :diminish
  :bind (("C-c C-p" . ivy-resume)
         ("C-x b" . ivy-switch-buffer))
  :config
  (define-key ivy-minibuffer-map [escape] 'minibuffer-keyboard-quit)
  (setq ivy-re-builders-alist
      '((swiper . ivy--regex-plus)
	(t      . ivy--regex-plus)))
  (setq ivy-use-virtual-buffers t)
  (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :demand t
  :config
  (ivy-rich-mode 1)
  (setq ivy-virtual-abbreviate 'full
        ivy-rich-switch-buffer-align-virtual-buffer t
        ivy-rich-path-style 'abbrev
        ivy-rich-parse-remote-file-path nil
        ivy-rich-parse-remote-buffer nil))

(use-package hydra
  :defer t)

(use-package ivy-hydra
  :after (ivy hydra)
  :defer t)

(use-package counsel
  :demand t
  :after ivy
  :bind (("M-x" . counsel-M-x)
	 ("C-\\" . counsel-org-agenda-headlines)
	 ("C-x C-f" . counsel-find-file)
	 ("C-x r b" . counsel-bookmark)
         ("C-x B" . counsel-switch-buffer-other-window)
	 ("C-h f" . counsel-describe-function)))


(use-package counsel-projectile
  :after (counsel projectile)
  :config
  (defun counsel-open-in-idea (name)
    (shell-command (format "idea %s" name)))

  (counsel-projectile-modify-action
   'counsel-projectile-switch-project-action
   '((add ("Oi" counsel-open-in-idea "open project in idea"))))
  (counsel-projectile-mode 1))


(use-package swiper
  :after ivy
  :bind (("C-c C-s" . swiper-thing-at-point)
         ("C-*" . swiper-thing-at-point))
  :bind (:map isearch-mode-map
              ("C-o" . swiper-from-isearch)))

(use-package deft
  :bind ("C-, C-," . deft)
  :config (setq deft-directory "~/Documents/Notes/"
                deft-extensions '("md" "org")
                deft-default-extension "org"
                deft-use-filter-string-for-filename t
		deft-file-naming-rules '((noslash . "-")
					 (nospace . "-")
					 (case-fn . downcase))
		deft-org-mode-title-prefix t))

(use-package ediff
  :ensure nil
  :init (setq ediff-window-setup-function 'ediff-setup-windows-plain
	      ediff-split-window-function 'split-window-horizontally))

(use-package markdown-mode
  :defer t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc"))

(use-package ace-window
  :bind ("M-o" . ace-window))

(use-package company
  :defer 1
  :bind ("<help>" . company-complete)
  :config
  (setq company-idle-delay .3
	company-minimum-prefix-length 1
	company-tooltip-limit 10
	company-tooltip-align-annotations t
	company-selection-wrap-around t
	company-dabbrev-downcase nil
	company-require-match nil))
  ;; :hook (after-init . global-company-mode))

;; (use-package shell-pop
;;   :bind (("s-t" . shell-pop))
;;   :config
;;   (setq shell-pop-shell-type (quote ("vterm" "*vterm*" (lambda nil (vterm shell-pop-term-shell)))))
;;   (setq shell-pop-term-shell "/usr/local/bin/zsh")
;;   (shell-pop--set-shell-type 'shell-pop-shell-type shell-pop-shell-type))

(use-package elisp
  :ensure nil
  :bind ("s-r" . eval-buffer))

(use-package company
  :hook
  (emacs-lisp-mode
   . (lambda () (add-to-list (make-local-variable 'company-backends) '(company-elisp)))))


(use-package smartparens
  :defer 1
  :diminish
  :config
  (defun sp-newline (&rest _ignored)
    "Open a new brace or bracket expression, with relevant newlines and indent. "
    (newline)
    (indent-according-to-mode)
    (forward-line -1)
    (indent-according-to-mode))

  (let ((brackets (list "[" "(" "{"))
        (handlers '((sp-newline "RET") ("| " "SPC"))))
    (dolist (b brackets) (sp-pair b nil :post-handlers handlers)))
  (smartparens-global-mode))

(use-package projectile
  :defer 2
  :bind-keymap ("C-c p" . projectile-command-map)
  :init
  (setq projectile-completion-system 'ivy
        projectile-indexing-method 'alien)
  :config
  (setq projectile-project-search-path
        '("~/Developer/"))
  (setq projectile-completion-system 'ivy)
  (setq projectile-indexing-method 'alien)
  (projectile-register-project-type 'npm '("package.json")
                  :compile "npm install"
                  :test "npm test"
                  :run "npm start"
                  :test-suffix ".spec")
  (projectile-global-mode))


(use-package expand-region
  :bind
  ("M-<up>" . er/expand-region)
  ("M-<down>" . er/contract-region))

(use-package json-mode
  :mode "\\.json"
  :init
  (setq jsons-path-printer 'jsons-print-path-jq))

(use-package gitignore-mode
  :defer 2
  :config
  (add-to-list 'auto-mode-alist
             (cons "/.dockerignore\\'" 'gitignore-mode)))
(use-package groovy-mode :defer 2 :mode "Jenkinsfile")
(use-package yaml-mode :defer 2 :mode "\\.ya?ml\\'")

(setq-default kill-whole-line t)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "s-K") 'kill-whole-line)
(global-set-key (kbd "s-/") 'comment-line)
(global-set-key (kbd "s-,")
                (lambda()
                  (interactive)
                  (find-file-other-frame "~/.emacs.d/init.el")))

(global-set-key (kbd "<end>") 'move-end-of-line)
(defun back-to-indentation-or-beginning () (interactive)
       (if (= (point) (progn (back-to-indentation) (point)))
           (beginning-of-line)))
(global-set-key (kbd "<home>") 'back-to-indentation-or-beginning)

(use-package paren
  :defer 1
  :ensure nil
  :init (setq show-paren-delay 0)
  :config (show-paren-mode 1))

(use-package dired
  :defer 1
  :ensure nil
  :bind ("C-x C-d" . dired))

(use-package dired-x
  :ensure nil
  :after dired)

(use-package dockerfile-mode :defer 5 :mode "Dockerfile[a-zA-Z.-]*\\'")

(use-package docker
  :bind ("C-c d" . docker))

(setq initial-major-mode 'fundamental-mode)
(setq initial-scratch-message nil)

;; Font
(setq-default line-spacing .2)
(setq default-font-family "JetBrains Mono")
(set-face-attribute 'default nil
                    :family default-font-family
                    :weight 'normal
                    :width 'normal
                    :height 120)


(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "s-d") 'split-window-right)
(global-set-key (kbd "s-D") 'split-window-below)
(global-set-key (kbd "s-w") 'delete-window)
(global-set-key (kbd "s-W") 'delete-frame)
(global-set-key (kbd "C-s-w") 'delete-other-windows)

(setq eldoc-idle-delay 0.2)

(setq inhibit-startup-echo-area-message t
      inhibit-startup-screen t
      ring-bell-function 'ignore
      scroll-margin 3)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq-default indicate-empty-lines t)

(setq scroll-error-top-bottom t
      scroll-preserve-screen-position t
      cursor-in-non-selected-windows nil)

(setq backup-by-copying t
      backup-directory-alist '(("." . "~/.saves/"))
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(setq sentence-end-double-space nil)
(setq delete-by-moving-to-trash t)

(setq-default indent-tabs-mode nil)     ; Indent with spaces
(setq help-window-select t)             ; Automatically select help window

(setq column-number-mode t)             ; Show column number
(save-place-mode 1)                     ; Restore position when reopen file


(use-package helpful
  :defer 2
  :init
  (setq counsel-describe-function-function #'helpful-callable
        counsel-describe-variable-function #'helpful-variable))

(use-package restclient
  :defer t
  :mode ("\\.http\\'" . restclient-mode))

(use-package clojure-mode
  :ensure t
  :defer t
  :mode ("\\.edn\\'" . clojure-mode))

(use-package emmet-mode
  :defer t
  :hook ((sgml-mode css-mode) . emmet-mode))

(use-package avy
  :init
  (setq avy-keys '(?f ?j ?d ?k ?s ?l ?g ?h))
  :bind
  ("M-<next>" . avy-goto-char-timer)
  ;; ("C-l" . avy-goto-line)
  )

(use-package ispell
  :init (setq ispell-program-name "hunspell"
              ispell-dictionary "en_US"))


(defun mailit ()
  "Send org subtree through Apple Mail"
  (interactive)
  (kill-new (org-export-as 'html t nil t))
  (do-applescript
   (concat
    "set rawHtml to the clipboard\n"
    "set htmlData to do shell script \"echo \" & (quoted form of rawHTML) as «class HTML»\n"
    "set the clipboard to htmlData")
   )
  )

(global-set-key (kbd "C-c l") #'mailit)

(use-package ibuffer
  :bind ("C-x C-b" . ibuffer))

(use-package cargo
  :hook (rust-mode . cargo-minor-mode))

(use-package lsp-mode
  :defer t
  :commands lsp)

(use-package rust-mode
  :mode "\\.rs\\'"
  :hook (rust-mode . lsp))

(use-package company-lsp
  :defer t
  :after lsp-mode
  :config
  (require 'lsp-clients)
  (push 'company-lsp company-backends))

(use-package jq-mode :defer t)
(use-package ibuffer-vc :defer t)

(use-package visual-fill-column
  :init (setq visual-fill-column-width 100)
  :config (setq split-window-preferred-function 'visual-fill-column-split-window-sensibly)
  :hook
  (org-mode . visual-fill-column-mode)
  (visual-fill-column-mode . visual-line-mode)
  )

(use-package typescript-mode)

(use-package web-mode
  :ensure t
  :mode (("\\.html?\\'" . web-mode)
         ("\\.tsx\\'" . web-mode)
         ("\\.jsx\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-block-padding 2
        web-mode-comment-style 2

        web-mode-enable-css-colorization t
        web-mode-enable-auto-pairing t
        web-mode-enable-comment-keywords t
        web-mode-enable-current-element-highlight t
        ))

(use-package treemacs
  :ensure t
  :defer t
  :bind (:map global-map
              ("s-1" . treemacs-select-window))
  :config
  (treemacs-create-theme "City"
    :icon-directory (concat user-emacs-directory "/icons")
    :config
    (progn
      (treemacs-create-icon :file "dir-closed.png" :extensions (root))
      (treemacs-create-icon :file "dir-closed.png" :extensions (dir-closed))
      (treemacs-create-icon :file "dir-open.png" :extensions (dir-open))
      (treemacs-create-icon :file "txt.png" :extensions (fallback))))
  (treemacs-load-theme "City")
  (treemacs-fringe-indicator-mode nil)
  (treemacs-resize-icons 16))


(setq gc-cons-threshold (* 2 1000 1000))
