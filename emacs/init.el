;;; This is all kind of necessary
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;;; Bootstrapping use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;; Making sure the spacemac's theme is installed now
(unless (package-installed-p 'spacemacs-theme)
  (package-refresh-contents)
  (package-install 'spacemacs-theme))

;;; Also use spaceline from spacemac's theme
(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
    (setq spaceline-buffer-encoding-abbrev-p nil)
    (setq spaceline-line-column-p nil)
    (setq spaceline-line-p nil)
    (setq powerline-default-separator (quote arrow))
    (spaceline-spacemacs-theme))

;;; Prerequisite for others packages
(use-package ivy
  :ensure t)

;;; Show completion on commands
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

;;; Ido : show possible completion (ex.: files)
(setq ido-enable-flex-matching nil)
(setq ido-create-new-buffer 'always)
(setq ido-everywhere t)
(ido-mode 1)

;;; smex, also known as “ido for M-x”
(use-package smex
  :ensure t
  :init
    (smex-initialize)
  :bind
    ("M-x" . smex)
    ("M-X" . smex-major-mode-commands))

;;; Set tab size to something tolerable
(setq tab-width 4)
(setq default-tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;;; Replace selected text when typing something
(delete-selection-mode t)

;;; Display search highlighting permanently
(setq lazy-highlight-cleanup nil)

;;; Stop displaying the start page
(setq inhibit-startup-message t)

;;; Change yes-or-no questions to y-or-n questions? (answer yes or no)
(defalias 'yes-or-no-p 'y-or-n-p)

;;; Set line numbers
(global-linum-mode t)

;;; Set <ESC> to cancel the command/search : we aint working on 70's steam powered keyboards
(define-key isearch-mode-map [escape] 'isearch-abort)   ;; isearch
(define-key isearch-mode-map "\e" 'isearch-abort)   ;; \e seems to work better for terminals
(global-set-key [escape] 'keyboard-escape-quit)         ;; everywhere else

;;; Set the default font to Hack
(set-face-attribute 'default nil :font "Hack" )
(set-frame-font "Hack" nil t)

;;; Just put backup files somewhere less distracting
(setq backup-directory-alist `(("." . "~/.emacs_saves")))

;;;
;;; Other generated configuration
;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
	("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(global-whitespace-mode t)
 '(indent-tabs-mode t)
 '(package-selected-packages
   (quote
	(company db-pg emacsql-psql emacsql smex ivy spacemacs-theme ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org sql-indent spaceline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox org-plus-contrib org-bullets open-junk-file neotree move-text mmm-mode markdown-toc macrostep lorem-ipsum linum-relative link-hint indent-guide hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-flx helm-descbinds helm-ag google-translate golden-ratio gh-md flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu elisp-slime-nav dumb-jump diminish define-word column-enforce-mode clean-aindent-mode auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line)))
 '(sql-product (quote postgres))
 '(whitespace-style
   (quote
	(face trailing tabs spaces newline empty indentation space-after-tab space-before-tab space-mark tab-mark newline-mark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(trailing-whitespace ((t (:background "#3c3c69"))))
 '(whitespace-indentation ((t (:foreground "#7f4d7a"))))
 '(whitespace-newline ((t (:foreground "#3c3c69"))))
 '(whitespace-space ((t (:foreground "#3c3c69"))))
 '(whitespace-space-after-tab ((t (:foreground "#3c3c69"))))
 '(whitespace-space-before-tab ((t (:foreground "#3c3c69"))))
 '(whitespace-tab ((t (:foreground "#3c3c69"))))
 '(whitespace-trailing ((t (:background "gray17" :foreground "#776644")))))
