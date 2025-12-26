; -*- lexical-binding: t; -*-
(setq make-backup-files nil)
(setq backup-inhibited nil)
(setq create-lockfiles nil)

;; Set the location for the custom file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;; Load the custom file, suppressing errors if it doesn't exist yet
(load custom-file :noerror)

;; Make native compilation silent.
(when (native-comp-available-p)
  (setq native-comp-async-report-warnings-errors 'silent))

;; set which-key mode
(which-key-mode 1)
(setq which-key-idle-delay 0.05) 

;; Set the line number display type to relative
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook #'display-line-numbers-mode) ; hook for programming files

;; Start in a scratch list-interactive buffer
(setq initial-buffer-choice t)
(setq initial-major-mode 'lisp-interaction-mode)
(setq initial-scratch-message
      (format ";; This is `%s'.  Type `%s' to evaluate and print results.\n\n"
              'lisp-interaction-mode
              (propertize
               (substitute-command-keys "\\<lisp-interaction-mode-map>\\[eval-print-last-sexp]")
               'face 'help-key-binding)))
(setq global-mark-ring-max 30)
(setq tab-width 4)

;;;; Packages
(add-hook 'package-menu-mode-hook #'hl-line-mode)

(setq package-archives
      '(("gnu-elpa" . "https://elpa.gnu.org/packages/")
        ("gnu-elpa-devel" . "https://elpa.gnu.org/devel/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))

;; Highest number gets priority (what is not mentioned has priority 0)
(setq package-archive-priorities
      '(("gnu-elpa" . 3)
        ("melpa" . 2)
        ("nongnu" . 1)))

;; Upgrade built in packages
(setq package-install-upgrade-built-in t)

;; Mark all themes as safe
(setq custom-safe-themes t)

;; Make sure packages are installed before used
(unless (package-installed-p 'modus-themes)
  (package-install 'modus-themes))

(unless (package-installed-p 'doome-themes)
  (package-install 'doom-themes))
(unless (package-installed-p 'evil)
  (package-install 'evil))

(unless (package-installed-p 'helpful)
  (package-install 'helpful))

(unless (package-installed-p 'doom-modeline)
  (package-install 'doom-modeline))

(unless (package-installed-p 'procress)
  (package-install 'procress))

(unless (package-installed-p 'page-break-lines)
  (package-install 'page-break-lines))

(unless (package-installed-p 'nerd-icons)
  (package-install 'nerd-icons))

(unless (package-installed-p 'projectile)
  (package-install 'projectile))

(unless (package-installed-p 'dashboard)
  (package-install 'dashboard))

(unless (package-installed-p 'vertico)
  (package-install 'vertico))

(unless (package-installed-p 'marginalia)
  (package-install 'marginalia))

(unless (package-installed-p 'orderless)
  (package-install 'orderless))

(unless (package-installed-p 'consult)
  (package-install 'consult))

(unless (package-installed-p 'embark)
  (package-install 'embark))

(unless (package-installed-p 'embark-consult)
  (package-install 'embark-consult))

(unless (package-installed-p 'magit)
  (package-install 'magit))

;;;; Load Packages
;; Theme
(use-package doom-themes
  :ensure t)
(load-theme 'doom-gruvbox t)

;; Helpful
(use-package helpful
  :ensure t)
;; Note that the built-in `describe-function' includes both functions
;; and macros. `helpful-function' is functions only, so we provide
;; `helpful-callable' as a drop-in replacement.
(global-set-key (kbd "C-h f") #'helpful-callable)

(global-set-key (kbd "C-h v") #'helpful-variable)
(global-set-key (kbd "C-h k") #'helpful-key)
(global-set-key (kbd "C-h x") #'helpful-command)
;; Lookup the current symbol at point. C-c C-d is a common keybinding
;; for this in lisp modes.
(global-set-key (kbd "C-c C-d") #'helpful-at-point)

;; Look up *F*unctions (excludes macros).
;;
;; By default, C-h F is bound to `Info-goto-emacs-command-node'. Helpful
;; already links to the manual, if a function is referenced there.
(global-set-key (kbd "C-h F") #'helpful-function)
;; if using ivy and counsel
;;(setq counsel-describe-function-function #'helpful-callable)
;;(setq counsel-describe-variable-function #'helpful-variable)

;; Modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; Procress
(use-package procress
  :commands procress-auctex-mode
  :init
  (add-hook 'LaTeX-mode-hook #'procress-auctex-mode)
  :config
  (procress-load-default-svg-images))

;; Evil Mode
;; enable Evil
(require 'evil)
(global-unset-key (kbd "C-z"))
(setq evil-toggle-key "C-z")
(setq evil-want-C-u-scroll t)
(evil-mode 1)

;; Evil config
;; esc quits
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
;; get back some Emacs keys
(define-key evil-normal-state-map "\C-y" 'yank)
(define-key evil-insert-state-map "\C-y" 'yank)
(define-key evil-visual-state-map "\C-y" 'yank)
(define-key evil-insert-state-map "\C-e" 'end-of-line)
(define-key evil-normal-state-map "\C-w" 'evil-delete)
(define-key evil-insert-state-map "\C-w" 'evil-delete)
(define-key evil-insert-state-map "\C-r" 'search-backward)
(define-key evil-visual-state-map "\C-w" 'evil-delete)
;; Modes
(evil-set-initial-state 'dired-mode 'emacs)
(evil-set-initial-state 'magit-status-mode 'emacs)
(evil-set-initial-state 'help-mode 'emacs)
(evil-set-initial-state 'dashboard-mode 'emacs)
(evil-set-initial-state 'Info-mode 'emacs)
(evil-set-initial-state 'erc-mode 'emacs) ;; for IRC clients

;; Page breaks
(use-package page-break-lines)

;; Icons
(use-package nerd-icons
  :ensure t)
 
;; Projectile
(use-package projectile
  :ensure t)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; Dashboard
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(setq initial-buffer-choice (lambda () (get-buffer-create dashboard-buffer-name)))

;; config option
;;(setq dashboard-icon-type 'all-the-icons)  ; use `all-the-icons' package
(setq dashboard-display-icons-p t)     ; display icons on both GUI and terminal
(setq dashboard-icon-type 'nerd-icons) ; use `nerd-icons' package
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)

;; set the title
(setq dashboard-banner-logo-title "Welcome to the Machine")
;; set the banner
(setq dashboard-startup-banner "~/dotfiles/banners/ut.png")
;; Value can be:
;;  - 'official which displays the official emacs logo.
;;  - 'logo which displays an alternative emacs logo.
;;  - an integer which displays one of the text banners
;;    (see dashboard-banners-directory files).
;;  - a string that specifies a path for a custom banner
;;    currently supported types are gif/image/text/xbm.
;;  - a cons of 2 strings which specifies the path of an image to use
;;    and other path of a text file to use if image isn't supported.
;;    (cons "path/to/image/file/image.png" "path/to/text/file/text.txt").
;;  - a list that can display an random banner,
;;    supported values are: string (filepath), 'official, 'logo and integers.

;; content is not centered by default. To center, set
(setq dashboard-center-content t)
;; vertically center content
(setq dashboard-vertically-center-content t)
;; to disable shortcut "jump" indicators for each section, set
;;(setq dashboard-show-shortcuts nil)
;; set shortcuts
(setq dashboard-items '((recents   . 5)
                        (bookmarks . 5)
                        (projects  . 5)
                        (agenda    . 5)
                        (registers . 5)))
;; widgets
(setq dashboard-startupify-list '(dashboard-insert-banner
                                  dashboard-insert-newline
                                  dashboard-insert-banner-title
                                  dashboard-insert-newline
                                  dashboard-insert-navigator
                                  dashboard-insert-newline
                                  dashboard-insert-init-info
                                  dashboard-insert-items
                                  ;;dashboard-insert-newline
                                  ;;dashboard-insert-footer
				  ))
;; cycle navigation
(setq dashboard-navigation-cycle t)
;; shortcut format
(setq dashboard-heading-shorcut-format " [%s]")
;; shortcut keys
(setq dashboard-item-shortcuts '((recents   . "r")
                                 (bookmarks . "m")
                                 (projects  . "p")
                                 (agenda    . "a")
                                 (registers . "e")))
;; to change verbiage
;;(setq dashboard-item-names '(("Recent Files:"               . "Recently opened files:")
;;                             ("Agenda for today:"           . "Today's agenda:")
;;                             ("Agenda for the coming week:" . "Agenda:")))

;; Vertico
(setq vertico-scroll-margin 0)
(setq vertico-count 10)
(setq vertico-resize t)
(setq vertico-cycle t)
(vertico-mode 1)

;; Marginalia
(marginalia-mode 1)

;; Orderless
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

;; Consult
;; Example configuration for Consult
(use-package consult
  ;; Replace bindings. Lazily loaded by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g r" . consult-grep-match)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)                  ;; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Tweak the register preview for `consult-register-load',
  ;; `consult-register-store' and the built-in commands.  This improves the
  ;; register formatting, adds thin separator lines, register sorting and hides
  ;; the window mode line.
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult-source-bookmark consult-source-file-register
   consult-source-recent-file consult-source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (keymap-set consult-narrow-map (concat consult-narrow-key " ?") #'consult-narrow-help)
)
;; Embark
(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  ;; Show the Embark target at point via Eldoc. You may adjust the
  ;; Eldoc strategy, if you want to see the documentation from
  ;; multiple providers. Beware that using this can be a little
  ;; jarring since the message shown in the minibuffer can be more
  ;; than one line, causing the modeline to move up and down:

  ;; (add-hook 'eldoc-documentation-functions #'embark-eldoc-first-target)
  ;; (setq eldoc-documentation-strategy #'eldoc-documentation-compose-eagerly)

  ;; Add Embark to the mouse context menu. Also enable `context-menu-mode'.
  ;; (context-menu-mode 1)
  ;; (add-hook 'context-menu-functions #'embark-context-menu 100)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; Corfu

;; Cape

;; Tempel

;; Magit
(use-package magit
  :ensure t)

;; Modify dired to us a single buffer
(eval-after-load "dired"
'(progn
    (defadvice dired-advertised-find-file (around dired-subst-directory activate)
    "Replace current buffer if file is a directory."
    (interactive)
    (let* ((orig (current-buffer))
	    ;; (filename (dired-get-filename))
	    (filename (dired-get-filename t t))
	    (bye-p (file-directory-p filename)))
	ad-do-it
	(when (and bye-p (not (string-match "[/\\\\]\\.$" filename)))
	(kill-buffer orig))))))

(eval-after-load "dired"
;; don't remove `other-window', the caller expects it to be there
'(defun dired-up-directory (&optional other-window)
    "Run Dired on parent directory of current directory."
    (interactive "P")
    (let* ((dir (dired-current-directory))
    (orig (current-buffer))
    (up (file-name-directory (directory-file-name dir))))
    (or (dired-goto-file (directory-file-name dir))
    ;; Only try dired-goto-subdir if buffer has more than one dir.
    (and (cdr dired-subdir-alist)
	(dired-goto-subdir up))
    (progn
	(kill-buffer orig)
	(dired up)
	(dired-goto-file dir))))))
