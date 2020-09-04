;;; init.el --- user-init-file                    -*- lexical-binding: t; -*-

(setq gc-cons-threshold (* 256 1024 1024))

(setq frame-inhibit-implied-resize t)
(setq package-enable-at-startup nil)

;; Beautify on macos
(when (equal system-type 'darwin)
  (setq ns-alternate-modifier 'meta
        ns-command-modifier 'super
        default-frame-alist '((width . 101)
                              (height . 100)
                              (ns-appearance . dark)
                              (ns-transparent-titlebar . t))))

(unless (display-graphic-p)
  (menu-bar-mode -1))

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el"
                         user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;;;;  Effectively replace use-package with straight-use-package
;;; https://github.com/raxod502/straight.el/blob/develop/README.md#integration-with-use-package
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(use-package exec-path-from-shell
  :init (setq exec-path-from-shell-check-startup-files t)
  :config (when (memq window-system '(mac ns x))
            (exec-path-from-shell-initialize)))

(use-package pass)

(use-package projectile
  :config
  (setq projectile-completion-system 'ivy)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1))

(use-package yaml-mode
  :mode "\\.ya?ml\\'")

(use-package json-mode
  :mode "\\.json\\'")

(use-package flycheck
  :bind (("M-n" . flycheck-next-error)
         ("M-p" . flycheck-previous-error)))

(use-package flycheck-vale
  :config (flycheck-vale-setup))

(use-package org
  :hook (org-mode . visual-line-mode)
  :config
  (org-crypt-use-before-save-magic)
  (org-link-set-parameters "message" :follow 'org-open-mail-message)
  (defun org-open-mail-message (path arg)
    (shell-command (concat "open message:" path))))

(use-package epa-file
  :straight nil
  :config (epa-file-enable))

(use-package magit
  :bind (("C-x g" . magit-status)))

(use-package ctrlf
  :config (ctrlf-mode +1))

(use-package minions
  :config (minions-mode 1))

(use-package org-superstar
  :init
  (setq org-superstar-remove-leading-stars nil)
  (setq org-superstar-leading-bullet ?\s)
  (setq org-superstar-headline-bullets-list '("⁖")) ;; '("⁖" "◉" "○" "▷")
  (setq org-superstar-item-bullet-alist
        '((?+ . ?•)
          (?* . ?•)
          (?- . ?•)))
  :hook (org-mode . org-superstar-mode))

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t)
  (load-theme 'doom-one t)
  (doom-themes-org-config))

(use-package vterm)

(use-package beacon
  :init
  (setq beacon-color "light green"
        beacon-blink-delay 0.1
        beacon-blink-when-window-scrolls nil
        beacon-blink-duration 0.1)
  :config (beacon-mode))

;; (set-fontset-font
;;  t 'symbol (font-spec :family "Apple Color Emoji") nil 'prepend)

(use-package ace-window
  :bind ("M-o" . ace-window)
  :init (ace-window-display-mode 1))

(use-package dired
  :straight nil
  :hook (dired-mode . dired-hide-details-mode)
  :ensure nil
  :config
  (use-package dired-git-info
    :bind (:map dired-mode-map (")" . dired-git-info-mode)))
  (use-package diredfl
    :config (diredfl-global-mode 1)))

(use-package paredit
  :hook ((lisp-mode emacs-lisp-mode) . paredit-mode))

(use-package ivy
  :init (setq ivy-use-virtual-buffers t)
  :config (ivy-mode 1))

(use-package counsel
  :after ivy
  :config (counsel-mode))

(use-package ivy-bibtex
  :after ivy
  :commands ivy-bibtex
  :bind ("C-c n b" . ivy-bibtex))

(use-package org-journal
  :bind ("C-c n j" . org-journal-new-entry)
  :init (setq org-journal-date-prefix "#+title: "
              org-journal-time-prefix "* "
              org-journal-file-format "%Y-%m-%d.org"
              org-journal-dir "~/Sync/Notes"
              org-journal-date-format "%A, %d %B %Y")
  )

(defun org-journal-find-location ()
  ;; Open today's journal, but specify a non-nil prefix argument in order to
  ;; inhibit inserting the heading; org-capture will insert the heading.
  (org-journal-new-entry t)
  ;; Position point on the journal's top-level heading so that org-capture
  ;; will add the new entry as a child entry.
  (goto-char (point-min)))

(setq org-directory "~/Sync/Notes/")

(setq org-capture-templates
      `(
        ("j" "Journal entry" entry (function org-journal-find-location)
         "** %(format-time-string org-journal-time-format)%?")
        ("t" "Task" entry (file+headline ,(concat org-directory "tracker.org") "Inbox")
         "* TODO %?" :prepend t)
        ("v" "Vocabulary" entry (file+headline ,(concat org-directory "vocabulary.org") "Vocabulary")
         "* %^{The word}\n %?")
        ("p" "Protocol" entry (file+headline ,(concat org-directory "tracker.org") "Inbox")
        "* %^{Title}\nSource: %u, %c\n #+begin_quote\n%i\n#+end_quote\n\n\n%?")
	("L" "Protocol Link" entry (file+headline ,(concat org-directory "tracker.org") "Inbox")
        "* %? [[%:link][%:description]] \nCaptured On: %U")
        ))

(use-package org-roam
  :init (setq org-roam-directory "~/Sync/Notes"
              org-roam-index-file "~/Sync/Notes/index.org")
  :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n n" . org-roam-find-ref)
               ("C-c n g" . org-roam-graph))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))))

(use-package org-ref
  :after org-roam
  :init (setq org-ref-default-bibliography "~/Sync/Notes/library.bib"))

(defcustom orb-title-format "${author-or-editor-abbrev} (${date}).  ${title}."
  "Format of the title to use for `orb-templates'.")

(use-package org-roam-bibtex
  :after org-ref
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :bind (:map org-mode-map
              (("C-c n a" . orb-note-actions)))
  :init
  (setq orb-templates
   `(("r" "ref" plain
      (function org-roam-capture--get-point)
      ""
      :file-name "refs/${citekey}"
      :head ,(s-join "\n"
                     (list
                      (concat "#+title: " orb-title-format)
                      "#+roam_key: ${ref}"
                      "#+created: %U\n\n"))
      :unnarrowed t)
     ))
  )

(use-package deft
  :init (setq deft-default-extension "org"
              deft-directory "~/Sync/Notes"
              deft-file-naming-rules '((noslash . "-") (nospace . "-") (case-fn . downcase))
              deft-recursive t
              deft-auto-save-interval nil
              deft-use-filter-string-for-filename t
              deft-strip-summary-regexp (concat "\\("
                                                "[\n\t]" ;; blank
                                                "\\|^#\\+[[:lower:]_]+:.*$" ;; org-mode metadata
                                                "\\)"))
  :bind ("C-c n d" . deft))

(use-package calfw
  :preface
  (defalias 'cal 'cfw:open-calendar-buffer)
  :commands (cfw:open-calendar-buffer))

(setq default-directory "~/")

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c n c") 'calendar)
(global-set-key (kbd "s-K") 'kill-buffer-and-window)
(global-set-key (kbd "s-o") 'find-file-existing)
(global-set-key (kbd "s-1") 'delete-other-windows)
(global-set-key (kbd "s-0") 'delete-window)
(global-set-key (kbd "s-b") 'list-buffers)
(global-set-key (kbd "s-Z") 'redo)
;; Kill current buffer without asking for name
(global-set-key [remap kill-buffer] #'kill-this-buffer)
(global-set-key (kbd "<home>") 'beginning-of-line)
(global-set-key (kbd "<end>") 'end-of-line)

(setq gc-cons-threshold (* 32 1024 1024))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(bibtex-completion-bibliography "~/Sync/Notes/library.bib")
 '(bibtex-completion-library-path "~/Sync/Notes")
 '(bibtex-completion-pdf-open-function 'helm-open-file-with-default-tool)
 '(bibtex-dialect 'biblatex)
 '(calendar-week-start-day 1)
 '(column-number-mode t)
 '(compilation-message-face 'default)
 '(css-fontify-colors nil)
 '(cursor-type 'bar)
 '(deft-auto-save-interval 0.0)
 '(delete-by-moving-to-trash t)
 '(delete-selection-mode t)
 '(dired-use-ls-dired nil)
 '(fill-column 100)
 '(frame-resize-pixelwise t)
 '(help-window-select t)
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(kill-whole-line t)
 '(line-spacing 0.15)
 '(make-backup-files nil)
 '(mouse-wheel-tilt-scroll t)
 '(org-agenda-files '("~/Sync/Notes/tracker.org"))
 '(org-agenda-tags-column 'auto)
 '(org-babel-load-languages '((emacs-lisp . t) (shell . t) (python . t) (js . t)))
 '(org-confirm-babel-evaluate nil)
 '(org-default-notes-file "~/Sync/Notes/tracker.org")
 '(org-directory "~/Sync/Notes/")
 '(org-ellipsis " ▼ ")
 '(org-fontify-quote-and-verse-blocks t)
 '(org-fontify-whole-heading-line t)
 '(org-hide-emphasis-markers t)
 '(org-html-validation-link nil)
 '(org-id-link-to-org-use-id 'create-if-interactive)
 '(org-log-note-clock-out t)
 '(org-modules
   '(ol-bbdb ol-bibtex org-crypt ol-docview ol-eww org-habit ol-info ol-irc ol-mhe ol-rmail ol-w3m))
 '(org-special-ctrl-a/e t)
 '(org-startup-folded t)
 '(org-superstar-todo-bullet-alist '(("TODO" . 9744) ("DONE" . 9745)))
 '(org-tags-column 0)
 '(ring-bell-function 'ignore)
 '(scroll-bar-mode nil)
 '(scroll-error-top-bottom t)
 '(tab-always-indent 'complete)
 '(user-mail-address "peshkovroman@gmail.com")
 '(vc-follow-symlinks t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 120 :family "JetBrains Mono"))))
 '(aw-leading-char-face ((t (:foreground "light green" :weight ultra-bold :height 2.0))))
 '(fixed-pitch ((t (:height 120 :family "JetBrains Mono"))))
 '(variable-pitch ((t (:weight normal :height 130 :family "Roboto Slab")))))

