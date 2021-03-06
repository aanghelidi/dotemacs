(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(setq split-width-threshold 0) ;Default split is right window
(menu-bar-mode -1)            ; Disable the menu bar

(column-number-mode)

(setq make-backup-files nil) ; remove backup files
;; Set up the visible bell
(setq visible-bell t)

;; Use short answers
(setq use-short-answers t)

(set-face-attribute 'default nil :font "RobotoMono Nerd Font" :height 130)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

;; Clock display
(display-time-mode 1)

;; Adjust dired behaviour
(setq dired-kill-when-opening-new-dired-buffer t)
(setq dired-do-revert-buffer t)
(setq dired-create-destination-dirs 'ask)

;; Dired X
(with-eval-after-load 'dired
(require 'dired-x)
;; Set dired-x global variables here.  For example:
(setq dired-x-hands-off-my-keys nil))

(add-hook 'dired-mode-hook
	(lambda ()
	    ;; Set dired-x buffer-local variables here.  For example:
	    (dired-omit-mode 1)
	    ))

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)

(use-package evil
  :ensure t ;; install the evil package if not installed
  :init ;; tweak evil's configuration before loading it
  (setq evil-search-module 'evil-search)
  (setq evil-want-keybinding nil)
  :config ;; tweak evil after loading it
  (evil-mode)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init)))

(defun evil-collection-vterm-escape-stay ()
"Go back to normal state but don't move
cursor backwards. Moving cursor backwards is the default vim behavior but it is
not appropriate in some cases like terminals."
(setq-local evil-move-cursor-back nil))

(add-hook 'vterm-mode-hook #'evil-collection-vterm-escape-stay)

;; Only for text
(add-hook 'text-mode-hook #'abbrev-mode)
(setq abbrev-suggest t)

(use-package vterm
    :ensure t)

(use-package multi-vterm
	:ensure t
	:config
	(add-hook 'vterm-mode-hook
			(lambda ()
			(setq-local evil-insert-state-cursor 'box)
			(evil-insert-state)))
	(define-key vterm-mode-map [return]                      #'vterm-send-return)

	(setq vterm-keymap-exceptions nil)
	(evil-define-key 'insert vterm-mode-map (kbd "C-e")      #'vterm--self-insert)
	(evil-define-key 'insert vterm-mode-map (kbd "C-f")      #'vterm--self-insert)
	(evil-define-key 'insert vterm-mode-map (kbd "C-a")      #'vterm--self-insert)
	(evil-define-key 'insert vterm-mode-map (kbd "C-v")      #'vterm--self-insert)
	(evil-define-key 'insert vterm-mode-map (kbd "C-b")      #'vterm--self-insert)
	(evil-define-key 'insert vterm-mode-map (kbd "C-w")      #'vterm--self-insert)
	(evil-define-key 'insert vterm-mode-map (kbd "C-u")      #'vterm--self-insert)
	(evil-define-key 'insert vterm-mode-map (kbd "C-d")      #'vterm--self-insert)
	(evil-define-key 'insert vterm-mode-map (kbd "C-n")      #'vterm--self-insert)
	(evil-define-key 'insert vterm-mode-map (kbd "C-m")      #'vterm--self-insert)
	(evil-define-key 'insert vterm-mode-map (kbd "C-p")      #'vterm--self-insert)
	(evil-define-key 'insert vterm-mode-map (kbd "C-j")      #'vterm--self-insert)
	(evil-define-key 'insert vterm-mode-map (kbd "C-k")      #'vterm--self-insert)
	(evil-define-key 'insert vterm-mode-map (kbd "C-r")      #'vterm--self-insert)
	(evil-define-key 'insert vterm-mode-map (kbd "C-t")      #'vterm--self-insert)
	(evil-define-key 'insert vterm-mode-map (kbd "C-g")      #'vterm--self-insert)
	(evil-define-key 'insert vterm-mode-map (kbd "C-c")      #'vterm--self-insert)
	(evil-define-key 'insert vterm-mode-map (kbd "C-SPC")    #'vterm--self-insert)
	(evil-define-key 'normal vterm-mode-map (kbd "C-d")      #'vterm--self-insert)
	(evil-define-key 'normal vterm-mode-map (kbd ",c")       #'multi-vterm)
	(evil-define-key 'normal vterm-mode-map (kbd ",n")       #'multi-vterm-next)
	(evil-define-key 'normal vterm-mode-map (kbd ",p")       #'multi-vterm-prev)
	(evil-define-key 'normal vterm-mode-map (kbd "i")        #'evil-insert-resume)
	(evil-define-key 'normal vterm-mode-map (kbd "o")        #'evil-insert-resume)
	(evil-define-key 'normal vterm-mode-map (kbd "<return>") #'evil-insert-resume))

(use-package all-the-icons
   :ensure t)

 (use-package rainbow-delimiters
   :ensure t
   :hook (prog-mode . rainbow-delimiters-mode))

 ;;(load-theme 'modus-vivendi)

(use-package doom-themes
:ensure t
:config
    (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
    doom-themes-enable-italic t) ; if nil, italics is universally disabled
    (load-theme 'doom-gruvbox t)
    ;; Enable flashing mode-line on errors
    (doom-themes-visual-bell-config)
    ;; Corrects (and improves) org-mode's native fontification.
    (doom-themes-org-config))

(use-package webjump
  :custom
  (webjump-sites '(("Github" . "https://github.com/aanghelidi")
      ("Web search[DuckDuckgo]" .
       [simple-query "www.duckduckgo.com" "https://www.duckduckgo.com/?q=" ""])
      ("Google search" .
       [simple-query "www.google.com" "https://www.google.com/?q=" ""])
      ("Youtube search" .
       [simple-query "www.youtube.com" "https://www.youtube.com/results?search_query=" ""])
      ("StackOverflow" .
       [simple-query "www.stackoverflow.com" "https:://www.stackoverflow.com/search?q=" ""])))
  :bind ("C-c j" . webjump))

(use-package dashboard
  :ensure t
  :delight
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-startup-banner 'logo))

(use-package pdf-tools-install
  :ensure pdf-tools
  :if (display-graphic-p)
  :mode "\\.pdf\\'"
  :commands (pdf-loader-install)
  :custom
  (TeX-view-program-selection '((output-pdf "pdf-tools")))
  (TeX-view-program-list '(("pdf-tools" "TeX-pdf-tools-sync-view")))
  :hook
  (pdf-view-mode . (lambda () (display-line-numbers-mode -1)))
  :config
  (pdf-loader-install))

;; Org mode latest version
(use-package org
  :ensure t)

;; org-babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '(( emacs-lisp . t)
   (python . t)))

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("ditaa" . "src ditaa"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))

(setq org-confirm-babel-evaluate nil)

;; org-bullet
(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

(use-package which-key
   :ensure t
   :init (which-key-mode)
   :diminish which-key-mode
   :config
   (setq which-key-idle-delay 1))

(use-package selectrum
  :ensure t
  :config
  (selectrum-mode +1)
  (setq selectrum-refine-candidates-function #'orderless-filter)
  (setq orderless-skip-highlighting (lambda () selectrum-is-active))
  (setq selectrum-highlight-candidates-function #'orderless-highlight-matches))

;; Enable richer annotations using the Marginalia package
(use-package marginalia
  :ensure t
  :bind (("M-A" . marginalia-cycle)
	 :map minibuffer-local-map))
  :init
  (marginalia-mode)

(marginalia-mode)

(use-package orderless
  :ensure t
  :custom (completion-styles '(orderless)))

;; Configuration for Consult
(use-package consult
  :ensure t
  :bind
  ("C-s" . consult-line)
  ("M-g g" . consult-goto-line))

(use-package embark
  :ensure t
  :bind
  (("C-S-a" . embark-act)
   ("C-h B" . embark-bindings))
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (add-to-list 'display-buffer-alist
	       '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
		 nil
		 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :ensure t
  :after (embark consult)
  :demand t ; only necessary if you have the hook below
  ;; if you want to have consult previews as you move around an
  ;; auto-updating embark collect buffer
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; Git setup
(use-package magit
  :ensure t)

(use-package forge
  :after magit
  :ensure t)

;; LSP mode
(use-package lsp-mode
  :ensure t
  :init (setq lsp-keymap-prefix "C-c l")
  :config
  (lsp-dired-mode)
  :custom
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-signature-auto-activate nil)
  (lsp-signature-render-documentation nil)
  (lsp-enable-file-watchers nil)
  (lsp-log-io nil)
   :hook (python-mode . lsp)
	 (go-mode . lsp)
	 (js-mode . lsp)
	 (lsp-enable-which-key-integration . lsp)
  :commands lsp)

;; LSP UI
(use-package lsp-ui
  :ensure t
  :custom
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-doc nil))  

;; dap-mode
(use-package dap-mode
  :ensure t
  :config
  (dap-mode 1)
  (dap-ui-mode 1)
  (dap-tooltip-mode 1)
  (tooltip-mode 1)
  (dap-ui-controls-mode 1)
  ;; dap-python
  (require 'dap-python)
  (setq dap-python-debugger 'debugpy)
  ;; dap-go
  (require 'dap-go))

(use-package company
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))

;; flycheck
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; Python setup
(use-package python
    :custom
    (python-shell-interpreter "python")
    (python-shell-interpreter-args "-i")
    (python-indent-offset 4))

(use-package pyvenv
  :ensure t
  :init
  (setenv "WORKON_HOME" "~/.pyenv/versions"))

(use-package lsp-pyright
:ensure t
:custom
(setq lsp-pyright-auto-import-completions t)
(setq lsp-pyright-diagnostic-mode "workspace")
(setq lsp-pyright-typechecking-mode "basic")
:hook (python-mode . (lambda ()
			    (require 'lsp-pyright)
			    (lsp))))
(use-package numpydoc
    :ensure t
    :after python
    :bind (:map python-mode-map
		("C-c d" . numpydoc-generate)))

(use-package go-mode
  :ensure t)

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(provide 'gopls-config)



(use-package yasnippet
 :ensure t
 :hook ((text-mode
	 prog-mode
	 conf-mode
	 snippet-mode) . yas-minor-mode-on)
 :init
 (setq yas-snippet-dir "~/.emacs.d/snippets"))

(use-package yasnippet-snippets
  :ensure t)

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package exec-path-from-shell
  :ensure t)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(use-package shift-number
  :ensure t
  :bind
  ("C-+" . shift-number-up)
  ("C--" . shift-number-down))

(use-package yaml-mode
  :ensure t)

(add-hook 'yaml-mode-hook
	  '(lambda ()
	     (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

(use-package docker
  :ensure t
  :bind ("C-c d" . docker))
