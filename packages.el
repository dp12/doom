;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)

;;; Extensions for built-in tools
(package! dired-git-info)
(package! dired-narrow)
(package! frog-jump-buffer)
(package! key-chord)
(package! ox-hugo)
(package! shell-pop)

;;; Search
(package! deadgrep)
(package! double-saber)
(package! fzf)
(package! ggtags)
(package! git-gutter+)
(package! link-hint)
(package! projectile-ripgrep)

;;; Emacs lisp development
(package! elsa)
(package! flycheck-elsa)
(package! flycheck-package)
(package! package-lint)

;;; Programming tools
(package! company-try-hard)
(package! corral)
(package! evil-iedit-state)
(package! iedit)
(package! imenu-list)
(package! quickrun)
(package! source-peek :recipe (:host github :repo "iqbalansari/emacs-source-peek"))

;;; Visual
(package! fill-column-indicator)
(package! nyan-mode)
(package! parrot)
(package! symbol-overlay)
