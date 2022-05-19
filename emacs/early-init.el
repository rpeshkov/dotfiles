(setq gc-cons-threshold most-positive-fixnum   ;; Defer Garbage collection
      gc-cons-percentage 1.0)

(add-hook 'emacs-startup-hook
         `(lambda ()
            (setq gc-cons-threshold 800000
                  gc-cons-percentage 0.1)
            (garbage-collect)) t)

(setq frame-inhibit-implied-resize t)
(setq default-directory "~/")
(setq command-line-default-directory "~/")

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                          ("melpa" . "https://melpa.org/packages/")))
(setq package-quickstart t)

(provide 'early-init)
