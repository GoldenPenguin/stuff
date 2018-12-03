;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Configurations which do not require packages ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Set the default font to Hack
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

;;; Just put backup files somewhere less distracting
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory ".emacs_saves/"))))

;;; Also prevent the creation of lock files on windows since I don't want to lock myself
(setq create-lockfiles nil)

;;; Reload files changed on disk automatically
(global-auto-revert-mode 1)

;;; Set org-mode elipsis to something more obvious
(setq org-ellipsis " ~~>")

;;; We are not in a terminal, and C-z is too much muscle memory at this point to learn it as "suspend emacs"
(global-set-key (kbd "C-z") 'undo)

;;; Windows configuration
;;; On windows, we would like to change the default shell
(setq explicit-shell-file-name "C:/Program Files/Git/bin/bash.exe")
(setq shell-file-name explicit-shell-file-name)
(add-to-list 'exec-path "C:/Program Files (x86)/Git/bin")
;;(setq explicit-shell-file-name
;;      "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe")
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

;;; Making sure the spacemac's theme is installed now
(use-package spacemacs-theme
  :ensure t
  :defer t
  :config
  (load-theme 'spacemacs-dark))

;(use-package doom-themes
;  :ensure t)

;;; Also use spaceline from spacemac's theme
(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (spaceline-spacemacs-theme)
  (setq spaceline-buffer-encoding-abbrev-p nil
		spaceline-line-column-p nil
		spaceline-line-p nil
		powerline-default-separator (quote arrow))
  (powerline-reset))

;(use-package doom-modeline
;  :ensure t
;  :defer t
;  :hook (after-init . doom-modeline-init)
;  :config
;  (setq doom-modeline-buffer-file-name-style 'relative-to-project)
;  (setq doom-modeline-icon t)
;  (setq inhibit-compacting-font-caches t))

;;; Use Beacon to locate the cursor
(use-package beacon
  :ensure t
  :config
  (beacon-mode 1))

;;; Show completion on key chords
(use-package which-key
  :ensure t
  :config
  (which-key-mode))

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
  ("C-x C-b" . 'helm-buffers-list)
  ("C-x C-m" . 'helm-M-x)
  ("C-x C-f" . 'helm-find-files)
  ("C-x C-r" . 'helm-recentf)
  ("C-x r l" . 'helm-filtered-bookmarks)
  ;;  ("M-s o" . 'helm-swoop)
  ;;  ("M-s /" . 'helm-multi-swoop)
  )

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

;;; install multiple-cursor
(use-package multiple-cursors
  :ensure t
  :config
  (add-hook 'multiple-cursors-mode-enabled-hook (lambda () (setq blink-matching-paren nil)))
  (add-hook 'multiple-cursors-mode-disabled-hook (lambda () (setq blink-matching-paren t)))
  :bind
  ("C->" . 'mc/mark-next-like-this)
  ("C-<" . 'mc/mark-previous-like-this)
  ("C-c C-<" . 'mc/mark-all-like-this))

;;; To display and select UTF-8 characters
(use-package charmap
  :ensure t)

;;; Set tab size to something tolerable
(setq tab-width 4)
(setq default-tab-width 4)
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Other generated configuration ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
	("cb6092256387fe55bf1f425e7a4dc0e378340c3292dfd730601e5213ca25e715" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" "100e7c5956d7bb3fd0eebff57fde6de8f3b9fafa056a2519f169f85199cc1c96" "d2e9c7e31e574bf38f4b0fb927aaff20c1e5f92f72001102758005e53d77b8c9" "b3562b69f03fdef6e4fed669c92843c1557eab2914417bfeab46bb2bf613a096" "3e9b76af1cc32a2292474f3b9239c5e5c9152704ecf04e745f4403a045cec4cf" "6b45a976e615ea23d14ac1242acc70a1fd698a6af623e231e8fc252d09600728" "1f82d77255651c959ef7e1d41d59dd63e2e175cf054b89159679f2f70f9c1f4a" "9ff84d6d4e85175edc9972da4851b16dfe06b1f43c8d800dcafbfbefa50275e2" "4228daafb62f72ed251f5b5b7bfde1119c2bd90ce4e0694edd8bdf5194533503" "d1ede12c09296a84d007ef121cd72061c2c6722fcb02cb50a77d9eae4138a3ff" "bd7b7c5df1174796deefce5debc2d976b264585d51852c962362be83932873d9" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(fci-rule-color "#3C3D37")
 '(global-whitespace-mode t)
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
	(("#3C3D37" . 0)
	 ("#679A01" . 20)
	 ("#4BBEAE" . 30)
	 ("#1DB4D0" . 50)
	 ("#9A8F21" . 60)
	 ("#A75B00" . 70)
	 ("#F309DF" . 85)
	 ("#3C3D37" . 100))))
 '(indent-tabs-mode t)
 '(magit-diff-use-overlays nil)
 '(package-selected-packages
   (quote
	(doom-themes srcery-theme doom-modeline monokai-alt-theme monokai-theme git-timemachine csharp-mode beacon charmap multiple-cursors swiper-helm projectile helm xah-find magit-filenotify magit yasnippet-snippets yasnippet swiper company db-pg emacsql-psql emacsql ivy spacemacs-theme ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org sql-indent spaceline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox org-plus-contrib org-bullets open-junk-file neotree move-text mmm-mode markdown-toc macrostep lorem-ipsum linum-relative link-hint indent-guide hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-flx helm-descbinds helm-ag google-translate golden-ratio gh-md flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu elisp-slime-nav dumb-jump diminish define-word column-enforce-mode clean-aindent-mode auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line)))
 '(pdf-view-midnight-colors (quote ("#b2b2b2" . "#292b2e")))
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(sql-product (quote postgres))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
	((20 . "#F92672")
	 (40 . "#CF4F1F")
	 (60 . "#C26C0F")
	 (80 . "#E6DB74")
	 (100 . "#AB8C00")
	 (120 . "#A18F00")
	 (140 . "#989200")
	 (160 . "#8E9500")
	 (180 . "#A6E22E")
	 (200 . "#729A1E")
	 (220 . "#609C3C")
	 (240 . "#4E9D5B")
	 (260 . "#3C9F79")
	 (280 . "#A1EFE4")
	 (300 . "#299BA6")
	 (320 . "#2896B5")
	 (340 . "#2790C3")
	 (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
	(unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
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
