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

(use-package sublime-themes
  :ensure t
  :demand)

(use-package evil
  :ensure t
  :bind ("C-x e" . evil-mode))

(use-package scala-mode
  :ensure t
  :pin melpa-stable
  :mode "\\.scala\\'"
  :interpreter "scala")

(use-package ensime
  :ensure t
  :pin melpa-stable)

(use-package sbt-mode
  :pin melpa-stable)

(add-to-list 'exec-path "/usr/local/bin")

;; Set emacs environment based on GUI or terminal use
(defun setup-gui-env()
  (load-theme 'brin t)
  (scroll-bar-mode -1)
  (tool-bar-mode -1))

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" default)))
 '(package-selected-packages
   (quote
    (ensime yasnippet use-package sublime-themes scala-mode sbt-mode s popup evil dash company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
