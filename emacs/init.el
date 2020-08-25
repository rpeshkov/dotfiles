;;; init.el --- user-init-file                    -*- lexical-binding: t; -*-

;; Beautify on macos
(when (equal system-type 'darwin)
  (setq ns-alternate-modifier 'meta
        ns-command-modifier 'super))

(add-to-list 'default-frame-alist '(width . 101))
(add-to-list 'default-frame-alist '(height . 100))
(add-to-list 'default-frame-alist '(internal-border-width . 15))

(fringe-mode '(15 . 15))

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
  :init (setq exec-path-from-shell-check-startup-files nil)
  :config (when (memq window-system '(mac ns x))
            (exec-path-from-shell-initialize)))

(use-package json-mode
  :mode "\\.json\\'")

(use-package org
  :hook (org-mode . visual-line-mode)
  :config
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

(use-package modus-operandi-theme
  :init (setq modus-operandi-theme-bold-constructs t
              modus-operandi-theme-slanted-constructs t
              modus-operandi-theme-rainbow-headings t
              modus-operandi-theme-scale-headings nil
              modus-operandi-theme-faint-syntax nil)
  :config (load-theme 'modus-operandi t))

;; Taken from http://www.howardism.org/Technical/Emacs/orgmode-wordprocessor.html
;; (font-lock-add-keywords 'org-mode
;;                         '(("^ *\\(-\\) "
;;                            (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;; (font-lock-add-keywords 'org-mode
;;   '(("^\\*+ "
;;      ":" nil nil
;;      (0 (put-text-property (match-beginning 0) (match-end 0) 'display " ")))))

;; (use-package org-protocol
;;   :ensure nil
;;   :after org)

(use-package beacon
  :init
  (setq beacon-color "light green"
        beacon-blink-delay 0.1
        beacon-blink-when-window-scrolls nil
        beacon-blink-duration 0.1)
  :config
  (beacon-mode)
  (global-hl-line-mode 1))

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

(setq org-capture-templates
      '(
        ("j" "Journal entry" entry (function org-journal-find-location)
         "** %(format-time-string org-journal-time-format)%?")
        ("t" "Task" entry (file+headline "~/Sync/Notes/tracker.org" "Inbox")
         "* TODO %?" :prepend t)
        ("v" "Vocabulary" entry (file+headline "~/Sync/Notes/vocabulary.org" "Vocabulary")
         "* %^{The word}\n %?")
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
              deft-use-filter-string-for-filename t)
  :bind ("C-c n d" . deft))

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
;; (global-set-key (kbd "C-x C-c") #'delete-frame)

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
 '(line-spacing 0.25)
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
 '(scroll-bar-mode nil)
 '(scroll-error-top-bottom t)
 '(user-mail-address "peshkovroman@gmail.com")
 '(vc-follow-symlinks t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 140 :family "Roboto Mono"))))
 '(aw-leading-char-face ((t (:foreground "red" :weight ultra-bold :height 2.0))))
 '(fixed-pitch ((t (:height 140 :family "Roboto Mono"))))
 '(fringe ((t (:foreground "white"))))
 '(mode-line ((t (:background "white" :foreground "#191919" :box nil :overline t))))
 '(org-document-title ((t (:inherit (bold default) :foreground "#093060" :height 1.5))))
 '(org-done ((t (:foreground "#005e00" :strike-through t))))
 '(org-ellipsis ((t (:background "white" :height 1))))
 '(org-headline-done ((t (:foreground "#004000" :strike-through t :overline nil))))
 '(org-tag ((t (:inherit bold :extend t :foreground "#541f4f" :weight normal :height 0.8))))
 '(org-todo ((t (:foreground "#a60000" :underline t))))
 '(variable-pitch ((t (:weight normal :height 150 :family "Roboto Slab")))))
