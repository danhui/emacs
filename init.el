(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)

(defun ensure-package-installed (&rest packages)
  ;; Assure every package is installed, ask for installation if it's not.
  ;; Return a list of installed packages or nil for every skipped package.
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; Activate installed packages
(package-initialize)

;; Packages required.
(ensure-package-installed 'auto-complete
                          'avy
                          'color-theme-sanityinc-tomorrow
                          'evil
                          'evil-leader
                          'evil-surround
                          'key-chord
                          'helm
                          'linum-relative)

;; Colorscheme and font.
(require 'color-theme-sanityinc-tomorrow)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (sanityinc-tomorrow-night)))
 '(custom-safe-themes
   (quote
    ("06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-to-list 'default-frame-alist
             '(font . "DejaVu Sans Mono-12"))

;; Relative line number.
(require 'linum-relative)
(global-linum-mode nil)
(linum-relative-toggle)
(setq linum-relative-current-symbol "")

;; Turn on key chord.
(require 'key-chord)
(key-chord-mode 1)

;; Surround.
(require 'evil-surround)
(global-evil-surround-mode 1)

;; Configure evil-leader before evil.
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "b" 'list-buffers
  "o" 'find-file
  "q" 'save-buffers-kill-terminal
  "w" 'save-buffer
  "x" 'delete-window)

;; Evil mode.
(setq evil-shift-width 2)
(require 'evil)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(define-key evil-normal-state-map (kbd ";") 'evil-ex)
(evil-mode t)

;; Avy.
(define-key evil-normal-state-map "s" 'avy-goto-word-0)

;; Auto-complete.
(ac-config-default)

;; Highlight trailing whitespace.
(setq-default show-trailing-whitespace t)

;; Helm, kind of like unite in vim.
(helm-mode 1)

;; Syntax highlighting.
(global-font-lock-mode 1)
