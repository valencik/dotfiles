;;; init.el --- Andrew's Emacs Config

;;; Commentary:
;;
;; My Emacs config featuring evil, ensime, and org-mode.

;;; Code:

;; global variables
(setq
 inhibit-startup-screen t
 create-lockfiles nil
 make-backup-files nil
 column-number-mode t
 scroll-error-top-bottom t
 show-paren-delay 0.5
 use-package-always-ensure t
 tags-file-name ".emacs_tags"
 sentence-end-double-space nil)

;; buffer local variables
(setq-default
 indent-tabs-mode nil
 tab-width 4
 c-basic-offset 4)

;; modes
(electric-indent-mode 0)
(show-paren-mode t)
(global-linum-mode t)
(winner-mode t)

;; global keybindings
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "M-%") 'query-replace-regexp)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x C-b") #'helm-buffers-list)

;; Make yes/no options accept y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; Package Management

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa"           . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable"    . "http://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("gnu"             . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org"             . "http://orgmode.org/elpa/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; Needed to get shell's PATH
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))
(add-to-list 'exec-path "/usr/local/bin")

(use-package sublime-themes
  :demand)
(load-theme 'brin t)

(defun av-evil-mode-hook-function ()
  "Unset some evil keybindings."
  (define-key evil-normal-state-map (kbd "M-.") nil)
  (define-key evil-normal-state-map (kbd "M->") #'ensime-edit-definition-other-window)
  (define-key evil-normal-state-map (kbd ";") #'helm-buffers-list)
)
(use-package evil
  :bind ("C-x e" . evil-mode)
  :init
  (add-hook 'evil-mode-hook 'av-evil-mode-hook-function))

(use-package org
  :ensure org-plus-contrib
  :mode ("\\.org\\'" . org-mode)
  :bind (("C-c a" . org-agenda))
  :config
  (setq org-clock-persist 'history)
  (org-clock-persistence-insinuate))

(use-package helm
  :config
  (helm-mode 1))

(use-package projectile
  :demand
  :init   (setq projectile-use-git-grep t)
  :config
  (projectile-global-mode t)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package helm-projectile)

(use-package ensime
  :defer t
  :pin melpa-stable
  :init
  (setq
   ensime-startup-notification nil
   ensime-startup-snapshot-notification nil))

(use-package python-mode
  :mode "\\.py\\'"
  :interpreter "Python")

(use-package pyvenv)

(use-package flycheck
  :diminish flycheck-mode
  :config
  (global-flycheck-mode)
  ;; Make flycheck use current load-path https://stackoverflow.com/a/20522255/5658995
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (progn
    ;; Be sure to set pyvenv-activate in a .dir-locals.el file
    (add-hook 'python-mode-hook (lambda () (pyvenv-mode 1)))
    (setq flycheck-pylintrc "pylintrc")))

(use-package which-key
  :config
  (which-key-mode)
  (which-key-declare-prefixes
    "C-c p" "projectile"
    "C-c &" "yas"
    "C-c C-b" "ensime-sbt"
    "C-c C-d" "ensime-db"
    "C-c C-r" "ensime-refactor"
    "C-c C-c" "ensime"
    "C-c C-v" "ensime"))



;;; init.el ends here
