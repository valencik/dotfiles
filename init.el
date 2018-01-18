;; global variables
(setq
 inhibit-startup-screen t
 create-lockfiles nil
 make-backup-files nil
 column-number-mode t
 scroll-error-top-bottom t
 show-paren-delay 0.5
 use-package-always-ensure t
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

;; global keybindings
(global-unset-key (kbd "C-z"))

;; Make yes/no options accept y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; the package manager
(require 'package)
(setq
 package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                    ("org" . "http://orgmode.org/elpa/")
                    ("melpa" . "http://melpa.org/packages/")
                    ("melpa-stable" . "http://stable.melpa.org/packages/"))
 package-archive-priorities '(("melpa-stable" . 1)))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Needed to get shell's PATH
(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))
(add-to-list 'exec-path "/usr/local/bin")

(use-package sublime-themes
  :ensure t
  :demand)
(load-theme 'brin t)

(use-package evil
  :ensure t
  :bind ("C-x e" . evil-mode))

(use-package ensime
  :ensure t
  :pin melpa-stable
  :mode "\\.scala\\'")

(use-package sbt-mode
  :pin melpa-stable
  :mode "\\.scala\\'")

(use-package python-mode
  :ensure t
  :mode "\\.py\\'"
  :interpreter "Python")

(use-package pyvenv
  :ensure t
  :pin melpa-stable)

(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :config
  (global-flycheck-mode)
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (progn
    (add-to-list 'flycheck-disabled-checkers 'python-flake8)
    ;; Be sure to set pyvenv-activate in a .dir-locals.el file
    (add-hook 'python-mode-hook (lambda () (pyvenv-mode 1)))
    (setq flycheck-pylintrc "pylintrc")))



;;; init.el ends here
