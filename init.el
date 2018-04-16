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
(global-set-key (kbd "M-%") 'query-replace-regexp)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x C-b") #'helm-buffers-list)

;; Make yes/no options accept y/n
(defalias 'yes-or-no-p 'y-or-n-p)

;; the package manager
(require 'package)
(setq
 package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
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

(defun av-evil-mode-hook-function ()
  "Unset some evil keybindings."
  (define-key evil-normal-state-map (kbd "M-.") nil)
  (define-key evil-normal-state-map (kbd "M->") #'ensime-edit-definition-other-window)
  (define-key evil-normal-state-map (kbd ";") #'helm-buffers-list)
)
(use-package evil
  :ensure t
  :bind ("C-x e" . evil-mode)
  :init
  (add-hook 'evil-mode-hook 'av-evil-mode-hook-function))

(use-package helm
  :ensure t
  :pin melpa-stable
  :config
  (helm-mode 1))

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
    "C-c C-v" "ensime"
  ))

(use-package ensime
  :defer t
  :ensure t
  :pin melpa-stable
  :init
  (setq
   ensime-startup-notification nil
   ensime-startup-snapshot-notification nil))

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
  ;; Make flycheck use current load-path https://stackoverflow.com/a/20522255/5658995
  (setq flycheck-emacs-lisp-load-path 'inherit)
  (progn
    ;; Be sure to set pyvenv-activate in a .dir-locals.el file
    (add-hook 'python-mode-hook (lambda () (pyvenv-mode 1)))
    (setq flycheck-pylintrc "pylintrc")))



;;; init.el ends here
