;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)

;;; Extensions for built-in tools
(package! dired-git-info)
(package! dired-narrow)
(package! dired-subtree)
(package! frog-jump-buffer)
(package! key-chord)
(package! org-roam-server)
(package! org-sidebar)
(package! ox-hugo)
(package! shell-pop)
(package! selectrum)
(package! selectrum-prescient)

;;; Search
(package! ctrlf)
(package! deadgrep)
(package! double-saber)
(package! fzf)
(package! ggtags)
(package! git-gutter+)
(package! gxref)
(package! link-hint)
(package! projectile-ripgrep)
(package! ivy-avy)

;;; Emacs lisp development
(package! elsa)
(package! evil-lisp-state)
(package! flycheck-elsa)
(package! flycheck-package)
(package! package-lint)

;;; Programming tools
(package! company-try-hard)
(package! company-tabnine)
(package! corral)
(package! drag-stuff)
(package! evil-iedit-state)
(package! iedit)
(package! imenu-list)
(package! intel-hex-mode)
(package! quickrun)
(package! source-peek :recipe (:host github :repo "iqbalansari/emacs-source-peek"))

;;; Visual
(package! rotate)
(package! evil-fringe-mark)
(package! fill-column-indicator)
(package! gruvbox-theme)
(package! isearch-prop)
(package! org-superstar)
(package! symbol-overlay)

;;; Fun
(package! nyan-mode)
(package! parrot)
(package! typing)
