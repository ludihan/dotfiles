;;; init.el --- Minimal modern Emacs configuration -*- lexical-binding: t; -*-

;;; Package management ---------------------------------------------------------

(require 'package)

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (pkg '(use-package
               gruvbox-theme
               magit
               which-key
               go-mode
               rust-mode
               typescript-mode
               svelte-mode
               lsp-mode
               lsp-ui
               treesit-auto
               corfu
               cape
               yasnippet
               yasnippet-capf
               vertico
               consult
               orderless
               marginalia
               embark
               embark-consult))

  (unless (package-installed-p pkg)
    (package-install pkg)))

(require 'use-package)

(setq use-package-always-ensure t)

;;; Which key ------------------------------------------------------------------

(require 'which-key)

(which-key-mode 1)

(setq which-key-idle-delay 0.5)

(which-key-add-key-based-replacements
  "C-c" "custom commands"
  "C-x g" "magit status")

;;; Appearance -----------------------------------------------------------------

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

(setq inhibit-startup-screen t
      inhibit-startup-message t
      initial-scratch-message nil
      use-dialog-box nil
      ring-bell-function #'ignore
      visible-bell nil)

(blink-cursor-mode -1)

(load-theme 'gruvbox-dark-medium t)

(set-face-attribute 'default nil
                    :family "Iosevka"
                    :height 140
                    :weight 'normal)

(global-display-line-numbers-mode 1)

(column-number-mode 1)

(setq display-line-numbers-type 'relative)

(global-hl-line-mode 1)

(show-paren-mode 1)

(global-visual-line-mode 1)

(setq visual-line-fringe-indicators '(nil right-arrow))

(setq-default indicate-buffer-boundaries nil)
(setq-default indicate-empty-lines nil)

;;; Keybindings ----------------------------------------------------------------

(global-set-key (kbd "C-c w")
                #'delete-trailing-whitespace)

(global-set-key (kbd "C-x g")
                #'magit-status)

(global-set-key (kbd "C-x C-b")
                #'ibuffer)

(global-set-key
 (kbd "C-c r")
 (lambda ()
   (interactive)
   (load-file user-init-file)))

(global-set-key
 (kbd "C-c e")
 (lambda ()
   (interactive)
   (find-file user-init-file)))

(global-set-key (kbd "C-;")
                #'comment-line)

;;; Smooth scrolling -----------------------------------------------------------

(setq scroll-conservatively 101
      scroll-margin 5
      scroll-step 1)

(when (display-graphic-p)
  (pixel-scroll-precision-mode 1))

(setq pixel-scroll-precision-interpolate-page t
      pixel-scroll-precision-interpolate-mice t)

;;; Editing --------------------------------------------------------------------

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default standard-indent 4)

(setq tab-always-indent 'complete)

(electric-pair-mode 1)

(delete-selection-mode 1)

(global-auto-revert-mode 1)

(setq global-auto-revert-non-file-buffers t)

(save-place-mode 1)

(savehist-mode 1)

(recentf-mode 1)

(setq recentf-max-saved-items 200)

(setq enable-recursive-minibuffers t)

(fset 'yes-or-no-p 'y-or-n-p)

(set-language-environment "UTF-8")

(prefer-coding-system 'utf-8)

;;; Sensible defaults ----------------------------------------------------------

(setq confirm-kill-emacs #'yes-or-no-p)

(setq undo-limit 80000000
      undo-strong-limit 120000000)

(setq kill-ring-max 100)

(setq uniquify-buffer-name-style 'forward)

(setq vc-follow-symlinks t)

;;; Completion -----------------------------------------------------------------

(use-package vertico
  :init
  (vertico-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides
   '((file (styles basic partial-completion)))))

(use-package marginalia
  :after vertico
  :init
  (marginalia-mode))

(use-package consult
  :bind
  (("C-s" . consult-line)
   ("C-x b" . consult-buffer)
   ("C-c f" . consult-project-buffer)
   ("C-c s" . consult-ripgrep)
   ("C-c g" . consult-grep)
   ("C-c m" . consult-mode-command))

  :custom
  (consult-preview-key "M-."))

(use-package embark
  :bind
  (("C-." . embark-act)
   ("C-h B" . embark-bindings)))

(use-package embark-consult
  :after (embark consult))

(use-package corfu
  :init
  (global-corfu-mode)

  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-preselect 'prompt)
  (corfu-preview-current nil)

  :config
  (corfu-popupinfo-mode 1))

(with-eval-after-load 'corfu
  (define-key corfu-map
              (kbd "C-h")
              #'corfu-popupinfo-toggle))

(use-package cape
  :after corfu

  :config
  (add-to-list 'completion-at-point-functions
               #'cape-file)

  (add-to-list 'completion-at-point-functions
               #'cape-dabbrev))

(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package yasnippet-capf
  :after (yasnippet corfu)

  :config
  (add-to-list 'completion-at-point-functions
               #'yasnippet-capf))

;;; Project navigation ---------------------------------------------------------

(use-package project
  :ensure nil

  :bind
  (("C-c p f" . project-find-file)
   ("C-c p s" . project-find-regexp)))
;;; Documentation --------------------------------------------------------------

(setq eldoc-idle-delay 0.2)

;;; LSP ------------------------------------------------------------------------

(use-package lsp-mode
  :hook
  ((go-mode
    rust-mode
    js-mode
    js-ts-mode
    typescript-mode
    typescript-ts-mode
    tsx-ts-mode
    html-mode
    css-mode
    svelte-mode) . lsp-deferred)

  :custom
  (lsp-keymap-prefix "C-c l")
  (lsp-idle-delay 0.5)
  (lsp-enable-symbol-highlighting t)
  (lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-enable t)
  (lsp-enable-on-type-formatting nil)
  (lsp-enable-indentation nil)
  (lsp-enable-snippet nil)
  (lsp-modeline-code-actions-enable t)
  (lsp-completion-provider :capf)

  :config
  (lsp-enable-which-key-integration t))

(use-package lsp-ui
  :after lsp-mode
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-position 'at-point)
  (lsp-ui-sideline-enable t)
  (lsp-ui-sideline-show-diagnostics t)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-sideline-show-code-actions t))


;;; Language modes -------------------------------------------------------------

(use-package go-mode
  :mode "\\.go\\'"

  :hook
  (go-mode . (lambda ()
               (setq-local tab-width 4))))


(use-package rust-mode
  :mode "\\.rs\\'"

  :hook
  (rust-mode . (lambda ()
                 (setq-local rust-format-on-save t))))


(use-package typescript-mode
  :mode ("\\.ts\\'"
         "\\.tsx\\'")

  :custom
  (typescript-indent-level 2))


(use-package svelte-mode
  :mode "\\.svelte\\'")


(add-hook 'js-mode-hook
          (lambda ()
            (setq-local js-indent-level 2)))


(add-hook 'css-mode-hook
          (lambda ()
            (setq-local css-indent-offset 2)))


;;; Tree-sitter ----------------------------------------------------------------

(use-package treesit-auto
  :config
  (global-treesit-auto-mode 1))


;;; Files ----------------------------------------------------------------------

(setq create-lockfiles nil)


(setq backup-directory-alist
      `(("." .
         ,(expand-file-name
           "backups/"
           user-emacs-directory))))


(setq auto-save-file-name-transforms
      `((".*"
         ,(expand-file-name
           "auto-save/"
           user-emacs-directory)
         t)))


(make-directory
 (expand-file-name "backups/"
                   user-emacs-directory)
 t)


(make-directory
 (expand-file-name "auto-save/"
                   user-emacs-directory)
 t)


;;; Dired ----------------------------------------------------------------------

(setq dired-listing-switches "-alh")


;;; Customize ------------------------------------------------------------------

(setq custom-file
      (expand-file-name
       "custom.el"
       user-emacs-directory))


(when (file-exists-p custom-file)
  (load custom-file))


(provide 'init)

;;; init.el ends here
