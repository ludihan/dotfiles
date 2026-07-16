;;; init.el --- Minimal modern Emacs configuration -*- lexical-binding: t; -*-

;;; Package management ---------------------------------------------------------

(require 'package)

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (pkg '(gruvbox-theme magit which-key))
  (unless (package-installed-p pkg)
    (package-install pkg)))

;;; which key
(require 'which-key)
(which-key-mode 1)

(setq which-key-idle-delay 0.5)
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

;; Theme
(load-theme 'gruvbox-dark-medium t)

;; Font
(set-face-attribute 'default nil
                    :family "Iosevka"
                    :height 140
                    :weight 'normal)

;; Line numbers
(global-display-line-numbers-mode 1)
(column-number-mode 1)
(setq display-line-numbers-type 'relative)

;; Highlight current line
(global-hl-line-mode 1)

;; Matching parentheses
(show-paren-mode 1)

;; Visual wrapping
(global-visual-line-mode 1)
(setq visual-line-fringe-indicators '(nil right-arrow))

;; Remove fringe clutter
(setq-default indicate-buffer-boundaries nil)
(setq-default indicate-empty-lines nil)

;;; Keybindings ----------------------------------------------------------------

(global-set-key (kbd "C-c w") #'delete-trailing-whitespace)
(global-set-key (kbd "C-x g") #'magit-status)

;; Better buffer list
(global-set-key (kbd "C-x C-b") #'ibuffer)

;; Reload init.el
(global-set-key (kbd "C-c r")
                (lambda ()
                  (interactive)
                  (load-file user-init-file)))

;; Open init.el
(global-set-key (kbd "C-c e")
                (lambda ()
                  (interactive)
                  (find-file user-init-file)))

;; Comment line/region
(global-set-key (kbd "C-;") #'comment-line)

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

(fido-vertical-mode 1)

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

;;; Language indentation -------------------------------------------------------

(add-hook 'python-mode-hook
          (lambda ()
            (setq-local python-indent-offset 4)))

(add-hook 'c-mode-common-hook
          (lambda ()
            (setq-local c-basic-offset 4)))

(add-hook 'js-mode-hook
          (lambda ()
            (setq-local js-indent-level 2)))

(add-hook 'css-mode-hook
          (lambda ()
            (setq-local css-indent-offset 2)))

(add-hook 'rust-mode-hook
          (lambda ()
            (setq-local rust-indent-offset 4)))

;;; Files ----------------------------------------------------------------------

(setq create-lockfiles nil)

(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups/" user-emacs-directory))))

(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "auto-save/" user-emacs-directory) t)))

(make-directory (expand-file-name "backups/" user-emacs-directory) t)
(make-directory (expand-file-name "auto-save/" user-emacs-directory) t)

;;; Dired ----------------------------------------------------------------------

(setq dired-listing-switches "-alh")

;;; Customize ------------------------------------------------------------------

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(when (file-exists-p custom-file)
  (load custom-file))

(provide 'init)
;;; init.el ends here
