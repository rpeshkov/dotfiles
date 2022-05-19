(use-package exec-path-from-shell
  :ensure t
  :init (setq exec-path-from-shell-check-startup-files t)
  :config (when (memq window-system '(mac ns x))
            (exec-path-from-shell-initialize)))

;(use-package leuven-theme
;  :ensure t
;  :config
;  (load-theme 'leuven t))

(use-package expand-region
  :ensure t
  :bind (("M-<up>" . er/expand-region)
         ("M-<down>" . er/contract-region)))

(use-package ledger-mode
  :ensure t
  :mode "\\.ledger\\'")

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package flymake-shellcheck
  :ensure t
  :commands flymake-shellcheck-load
  :hook (sh-mode . flymake-shellcheck-load))

(use-package shfmt
  :ensure t
  :bind (("C-c C-f" . shfmt))
  :hook (sh-mode . shfmt-on-save-mode))

(use-package tree-sitter
  :ensure t
  :init (global-tree-sitter-mode)
  :hook ((ruby-mode . tree-sitter-hl-mode)
         (js-mode . tree-sitter-hl-mode)
         (typescript-mode . tree-sitter-hl-mode)
         (go-mode . tree-sitter-hl-mode)
         (sh-mode . tree-sitter-hl-mode)))

(use-package tree-sitter-langs
  :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(calendar-week-start-day 1)
 '(column-number-mode t)
 '(frame-resize-pixelwise t)
 '(help-window-select t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(ledger-default-date-format "%Y-%m-%d")
 '(line-spacing 0.2)
 '(make-backup-files nil)
 '(markdown-wiki-link-search-type '(sub-directories parent-directories))
 '(org-agenda-files '("~/life/time/tracker.org"))
 '(org-fontify-whole-heading-line t)
 '(package-selected-packages
   '(leuven-theme shfmt flymake-shellcheck expand-region markdown-mode tree-sitter-langs tree-sitter ledger-mode use-package))
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
 '(default ((t (:height 120 :family "Cascadia Code"))))
 '(fringe ((t (:background nil))))
 '(mode-line ((t (:box nil))))
 '(mode-line-inactive ((t (:box nil)))))
