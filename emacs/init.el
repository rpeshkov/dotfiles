(use-package exec-path-from-shell
  :ensure t
  :init (setq exec-path-from-shell-check-startup-files t)
  :config (when (memq window-system '(mac ns x))
            (exec-path-from-shell-initialize)))
(load-theme 'modus-operandi t)

(use-package expand-region
  :ensure t
  :bind (("M-<up>" . er/expand-region)
         ("M-<down>" . er/contract-region)))

(use-package ledger-mode
  :ensure t
  :mode "\\.ledger\\'")

;(use-package org-modern
;  :ensure t
;  :hook
;  (org-mode . org-modern-mode)
;  (org-agenda-finalize . org-modern-agenda))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(calendar-week-start-day 1)
 '(column-number-mode t)
 '(frame-resize-pixelwise t)
 '(fringe-mode 0 nil (fringe))
 '(global-display-line-numbers-mode t)
 '(help-window-select t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(ledger-default-date-format "%Y-%m-%d")
 '(line-spacing 0.2)
 '(make-backup-files nil)
 '(markdown-wiki-link-search-type '(sub-directories parent-directories))
 '(org-agenda-files
   '("~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/habits.org" "~/Library/Mobile Documents/iCloud~com~appsonthemove~beorg/Documents/org/tracker.org"))
 '(org-fontify-whole-heading-line t)
 '(org-habit-show-all-today t)
 '(org-modules '(org-habit))
 '(package-selected-packages '(org-modern expand-region ledger-mode use-package))
 '(ring-bell-function 'ignore)
 '(scroll-bar-mode nil)
 '(scroll-error-top-bottom t)
 '(tab-width 4)
 '(vc-follow-symlinks t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:weight medium :height 120 :family "Cascadia Code"))))
 '(fixed-pitch ((t (:height 120 :family "Cascadia Code")))))
