;; sets user details
(setq user-full-name "Bradley Iroine")
(setq user-mail-address "bradplos@iroine.com")

;;--------------------------------------------------
;; PACKAGE MANAGEMENT
;;--------------------------------------------------

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     ;; (package-installed-p 'evil)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; make sure to have downloaded archive description.
;; Or use package-archive-contents as suggested by Nicolas Dudebout
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(ensure-package-installed 'iedit ) ;  --> (nil nil) if iedit and magit are already installed

;;--------------------------------------------------
;; PLUGINS
;;--------------------------------------------------

;;-------------------------
;; AUTO-COMPLETE
;;-------------------------

;; start auto-complete with emacs
(require 'auto-complete)

;;dp default config for auto-complete
(require 'auto-complete-config)
(ac-config-default)

;; function which initializes auto-complete-c-headers & gets called for c/c++ hooks
(defun my:ac-c-header-init()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/include/c++/4.9")
  )

;; call above function from c/c++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;; turn on semantics
(semantic-mode 1)

(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
  )
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

;;-------------------------
;; YASNIPPET
;;-------------------------

;; start yasnippet with emacs
(require 'yasnippet)
(yas-global-mode 1)

;;-------------------------
;; IEDIT
;;-------------------------

;; map iedit
(define-key global-map (kbd "C-c ;") 'iedit-mode)


;;-------------------------
;; NEOTREE
;;-------------------------

;; start neotree with emacs
(require 'neotree)
;; map neotree
(global-set-key [f8] 'neotree-toggle)

;;-------------------------
;; MINIMAP
;;-------------------------

;; start minimap with emacs
(require 'minimap)
(global-set-key [f9] 'minimap-toggle)

;;-------------------------
;; INDENT-GUIDE
;;-------------------------

;; start indent-guide with emacs
(require 'indent-guide)
;; starts indent-guide in all modes
(indent-guide-global-mode)
;; shows all guides
(setq indent-guide-recursive t)

;;--------------------------------------------------
;; OTHER
;;--------------------------------------------------

;; kills the splash screen / welcome message
(setq inhibit-startup-message t)

;; kills the menu-bar
(menu-bar-mode -1)

;; kills the tool-bar
(tool-bar-mode -1)

;; kills the scroll-bar
(scroll-bar-mode -1)

;; disables backups
(setq make-backup-files nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (seti)))
 '(custom-safe-themes
   (quote
    ("94ba29363bfb7e06105f68d72b268f85981f7fba2ddef89331660033101eb5e5" default)))
 '(fancy-splash-image nil)
 '(global-linum-mode t)
 '(indent-tabs-mode nil)
 '(initial-scratch-message "")
 '(minimap-always-recenter nil)
 '(minimap-recenter-type (quote relative))
 '(minimap-update-delay 0.1)
 '(minimap-window-location (quote right))
 '(mouse-avoidance-mode (quote banish) nil (avoid))
 '(standard-indent 2)
 '(tab-always-indent nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 180 :width normal :foundry "unknown" :family "Inconsolata"))))
 '(linum ((t (:foreground "#dddddd" :weight bold :height 0.9))))
 '(minimap-font-face ((t (:height 50 :family "DejaVu Sans Mono")))))
