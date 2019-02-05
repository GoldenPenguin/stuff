;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Configurations which do not require packages ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Set the default font to Hack *puts sunglasses and hoddie*
(add-to-list 'default-frame-alist '(font . "Hack") '(height . 105))
;(set-face-attribute 'default nil :font "Hack" :height 105)
;(set-frame-font "Hack" nil t)

;;; Remove start page, empty scratch buffer, remove tool bar and scroll bar
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
(tool-bar-mode -1)
(scroll-bar-mode -1)

;;; Highligh current line
(global-hl-line-mode t)

;;; Set cursor shape
(set-default 'cursor-type 'hollow)

;;; Scroll line per line instead of jumping half screen and recenter on point
(setq scroll-conservatively 101)

;;; When using page up/down, bring the point to the top/bottom when reaching the extremities of the document
(setq-default scroll-error-top-bottom t)

;;; ESC is just too easy to hit to quit things. Vim does it better, but shhh, we would not want someone to hear that.
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

;;; btw PLEASE use utf-8 for things
(prefer-coding-system 'utf-8)

;;; Replace selected text when typing something
(delete-selection-mode t)

;;; Change yes-or-no questions to y-or-n questions? (answer yes or no)
(defalias 'yes-or-no-p 'y-or-n-p)

;;; Set line numbers
(global-linum-mode t)

;;; I'm editing code most of the time, do not wrap lines
(setq-default truncate-lines 1)

;;; Just put backup files somewhere less distracting
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory ".emacs_saves/"))))

;;; Also prevent the creation of lock files since I don't want to lock myself (esp. on windows)
(setq create-lockfiles nil)

;;; Reload files changed on disk automatically
(global-auto-revert-mode 1)

;;; Set org-mode ellipsis to something more obvious
(setq org-ellipsis " ~~>")

;;; We are not in a terminal, and C-z is too much muscle memory at this point to learn it as "suspend emacs"
(global-set-key (kbd "C-z") 'undo)

;;; Set tab size to something tolerable
(setq tab-width 4)
(setq default-tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;;; Slowness related to unicode character should be solved by this workaround
(setq inhibit-compacting-font-caches t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Windows configuration ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; On windows, we would like to change the default shell
(setq explicit-shell-file-name "C:/Program Files/Git/bin/bash.exe")
(setq shell-file-name explicit-shell-file-name)
(add-to-list 'exec-path "C:/Program Files (x86)/Git/bin")
;;(setq explicit-shell-file-name "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe")
;;(setq shell-file-name explicit-shell-file-name)
;;(add-to-list 'exec-path "C:\Windows\System32\WindowsPowerShell\v1.0\")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Configurations which do require packages ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Set Melpa as an additionnal package repository
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;;; Bootstrapping use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Theme and apperance ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; install/update theme-related packages
(use-package spacemacs-theme
  :ensure t
  :defer t)

(use-package doom-themes
  :ensure t
  :defer t)

(use-package srcery-theme
  :ensure t
  :init
  (progn (load-theme 'srcery 'no-confirm)))

;;; Also use spaceline from spacemac's theme
(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (setq spaceline-buffer-encoding-abbrev-p t
	spaceline-line-column-p t
	spaceline-line-p t
	powerline-default-separator 'arrow)
  (spaceline-emacs-theme)
  (spaceline-helm-mode)
  (powerline-reset))

;;;;;;;;;;;;;;;;;
;;; Utilities ;;;
;;;;;;;;;;;;;;;;;

;;; Show completion on key chords
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;;; Front-end for ag, the silver searcher
(use-package ag
  :ensure t)

;;; Projectile
(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)
  (setq projectile-enable-caching t
	projectile-indexing-method 'alien
	projectile-completion-system 'helm)
  :bind
  ("s-p" . 'projectile-command-map)
  ("C-c p" . 'projectile-command-map))

;;; Helm
(use-package helm
  :ensure t
  :config
  (require 'helm-config)
  (helm-mode t)
  (helm-autoresize-mode t)
  (setq helm-M-x-fuzzy-match t
	helm-buffers-fuzzy-matching t
	helm-recentf-fuzzy-match t)
  :bind
  ("M-x" . 'helm-M-x)
  ("M-y" . 'helm-show-kill-ring)
  ("C-x b" . 'helm-mini)
  ("C-," . 'helm-mini)
  ("C-x C-b" . 'helm-buffers-list)
  ("C-x C-m" . 'helm-M-x)
  ("C-x C-f" . 'helm-find-files)
  ("C-x C-r" . 'helm-recentf)
  ("C-x r l" . 'helm-filtered-bookmarks)
  ("M-s /" . 'helm-multi-swoop))

;;; Integrate Helm and Projectile
(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on))

;;; replace isearch with helm-swoop
(use-package helm-swoop
  :ensure t
  :config
  (setq helm-swoop-split-direction 'split-window-vertically
	helm-swoop-pre-input-function (lambda () ""))
  :bind
  ("C-s" . 'helm-swoop))

;;; Install yasnippet and configure some snippets right away
(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets
	:ensure t)
  (yas-reload-all)
  (add-hook 'org-mode-hook 'yas-minor-mode))

;;; To display and select UTF-8 characters
(use-package charmap
  :ensure t)

;;; Better help
(use-package helpful
  :ensure t
  :bind
  ("C-h f" . #'helpful-callable)
  ("C-h v" . #'helpful-variable)
  ("C-h k" . #'helpful-key)
  ("C-h F" . #'helpful-function)
  ("C-h C" . #'helpful-command))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Language-specific modes ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package powershell
  :ensure t)

(use-package csharp-mode
  :ensure t)

(use-package groovy-mode
  :ensure t)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Hydra and relateds ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Hydra
(use-package hydra
  :ensure t
  :config
  (defhydra hydra-window-management (global-map "<f5>")
    "Hydra for window size : mx-butterfly to enlarge a window? Not on my watch."
    ("C-<up>" enlarge-window-horizontally)
    ("C-<down>" shrink-window-horizontally)
    ("M-<up>" enlarge-window)
    ("M-<down>" shrink-window)
    ("=" balance-windows :exit t)))
