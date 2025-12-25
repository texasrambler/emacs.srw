;; -*- lexical-binding: t; -*-
(setq frame-resize-pixelwise t
      frame-inhibit-implied-resize 'force
      frame-title-format '("%b")
      ring-bell-function 'ignore
      use-dialog-box t
      use-file-dialog nil
      use-short-answers t
      inhibit-splash-screen t
      inhibit-startup-screen t
      inhibit-x-resources t
      inhibit-startup-echo-area-message user-login-name 
      inhibit-startup-buffer-menu t)

(setq initial-frame-alist `((horizontal-scroll-bars . nil)
                            (menu-bar-lines . 0)
                            (tool-bar-lines . 0)
                            (vertical-scroll-bars . nil)
			    (fullscreen . fullboth)))

(setq package-enable-at-startup t)

;; Emacs will compile lisp code in this directory
(setq user-lisp-directory (locate-user-emacs-file "local-lisp/"))

(setq gc-cons-threshold 100000000) ;; Set to 100MB

;; Set main frame's name.
(add-hook 'after-init-hook (lambda () (set-frame-name "home")))

;;Set the initial background color to black
(add-to-list 'initial-frame-alist '(background-color . "#000000"))

