(use-package exec-path-from-shell
  :ensure t
  :init (setq exec-path-from-shell-check-startup-files t)
  :config (when (memq window-system '(mac ns x))
            (exec-path-from-shell-initialize)))

(use-package ledger-mode
  :ensure t
  :mode "\\.ledger\\'")

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
 '(inhibit-startup-screen t)
 '(ledger-default-date-format "%Y-%m-%d")
 '(make-backup-files nil)
 '(package-selected-packages '(ledger-mode use-package))
 '(ring-bell-function 'ignore)
 '(scroll-bar-mode nil)
 '(scroll-error-top-bottom t))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 120 :family "JetBrains Mono"))))
 '(fringe ((t (:background nil)))))
