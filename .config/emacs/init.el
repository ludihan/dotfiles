;;; init.el --- Minimal modern Emacs configuration -*- lexical-binding: t; -*-
(global-visual-line-mode 1)
(setq visual-line-fringe-indicators '(right-arrow right-arrow))

;;; Package management ---------------------------------------------------------

(require 'package)

(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (pkg '(gruvbox-theme magit))
  (unless (package-installed-p pkg)
    (package-install pkg)))

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

(global-set-key (kbd "C-c w") #'delete-trailing-whitespace)
(global-set-key (kbd "C-x g") #'magit-status)

;; Theme
(load-theme 'gruvbox-dark-medium t)

;; Font
(set-face-attribute 'default nil
                    :family "Iosevka"
                    :height 140
                    :weight 'normal)

;; Display
(global-display-line-numbers-mode 1)
(column-number-mode 1)

;; Relative line numbers (like Vim)
(setq display-line-numbers-type 'relative)

;; Highlight current line
(global-hl-line-mode 1)

;; Matching parentheses
(show-paren-mode 1)

;; Smooth scrolling
(setq scroll-conservatively 101
      scroll-margin 5
      scroll-step 1)

;; Smooth GUI scrolling
(when (display-graphic-p)
  (pixel-scroll-precision-mode 1))

(setq pixel-scroll-precision-interpolate-page t
      pixel-scroll-precision-interpolate-mice t)

;;; Editing --------------------------------------------------------------------

;; Default indentation: 4 spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default standard-indent 4)

;; TAB indents according to the current major mode.
;; Pressing TAB again can invoke completion when appropriate.
(setq tab-always-indent 'complete)

;; Editing conveniences
(electric-pair-mode 1)
(delete-selection-mode 1)

;; Reload files changed on disk
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)

;; Remember state
(save-place-mode 1)
(savehist-mode 1)
(recentf-mode 1)

(setq recentf-max-saved-items 200)

;; Built-in completion UI
(fido-vertical-mode 1)

;; Allow minibuffer recursion
(setq enable-recursive-minibuffers t)

;; y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; UTF-8 everywhere
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

;;; Language-specific indentation ----------------------------------------------

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

;; No lockfiles
(setq create-lockfiles nil)

;; Store backup files in ~/.emacs.d/backups/
(setq backup-directory-alist
      `(("." . ,(expand-file-name "backups/" user-emacs-directory))))

;; Store auto-save files in ~/.emacs.d/auto-save/
(setq auto-save-file-name-transforms
      `((".*" ,(expand-file-name "auto-save/" user-emacs-directory) t)))

(make-directory (expand-file-name "backups/" user-emacs-directory) t)
(make-directory (expand-file-name "auto-save/" user-emacs-directory) t)

;;; Dired ----------------------------------------------------------------------

(setq dired-listing-switches "-alh")

;;; Customize ------------------------------------------------------------------

;; Keep Customize out of init.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(when (file-exists-p custom-file)
  (load custom-file))

(provide 'init)
;;; init.el ends here
