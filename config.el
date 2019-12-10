;;; .doom.d/config.el -*- lexical-binding: t; -*-

(setq doom-font (font-spec :family "Fixedsys Excelsior 301" :size 20))

;; Place your private configuration here
(map! :leader
      :desc "avy-kill-whole-line" "ak" #'avy-kill-whole-line
      :desc "avy-kill-region" "aK" #'avy-kill-region
      :desc "avy-copy-line" "ay" #'avy-copy-line
      :desc "align-regexp" "ax" #'align-regexp
      :desc "bookmark jump" "bj" #'counsel-bookmark
      :desc "list bookmarks" "bl" #'list-bookmarks
      :desc "swap windows" "bx" #'ace-swap-window
      :desc "copy and comment" "ck" #'evilnc-comment-and-kill-ring-save
      :desc "dired-omit-mode" "d." #'dired-omit-mode
      :desc "dumb jump other" "dG" #'dumb-jump-go-other-window
      :desc "dumb jump" "dg" #'dumb-jump-go
      :desc "dired-jump" "dj" #'dired-jump
      :desc "kill dired" "dk" #'kill-dired-buffers
      :desc "delete-matching-lines" "dm" #'delete-matching-lines
      :desc "dumb jump quick look" "dl" #'dumb-jump-quick-look
      :desc "dired jump other" "do" #'dired-jump-other-window
      :desc "ediff-buffers" "ed" #'ediff-buffers
      :desc "evil-show-marks" "em" #'evil-show-marks
      :desc "evil-show-registers" "er" #'evil-show-registers
      :desc "counsel-file-jump" "fJ" #'counsel-file-jump
      :desc "projectile-ripgrep-filename" "fN" #'projectile-ripgrep-filename
      :desc "frog-jump-buffer" "fb" #'frog-jump-buffer
      :desc "copy-file-basename-to-clipboard" "fn" #'copy-file-basename-to-clipboard
      :desc "fzf-git-files" "fz" #'fzf-git-files
      :desc "gdb-set-fast-breakpoint" "gd" #'gdb-set-fast-breakpoint
      :desc "counsel-ffap-git" "gff" #'counsel-ffap-git
      :desc "ggtags-find-reference" "gr" #'ggtags-find-reference
      :desc "highlight-symbol-at-point" "h." #'highlight-symbol-at-point
      :desc "unhighlight-regexp" "hr" #'unhighlight-regexp
      :desc "hexl-mode" "hx" #'hexl-mode
      :desc "counsel-recentf" "if" #'counsel-recentf
      :desc "mu4e update mail cnt" "ma" #'mu4e-alert-update-mail-count-interactive
      :desc "evil-mc-mode" "mc" #'evil-mc-mode
      :desc "magit-find-file" "mf" #'magit-find-file
      :desc "mu4e-jump-to-mail" "mj" #'mu4e-jump-to-mail
      :desc "imenu-list" "ml" #'imenu-list-smart-toggle
      :desc "magit-file-popup" "mp" #'magit-file-popup
      :desc "mu4e-update-mail" "mu" #'mu4e-update-mail-and-index-wrapper
      :desc "toggle-org-checkbox" "oc" #'toggle-org-checkbox
      :desc "counsel-org-goto" "og" #'counsel-org-goto
      :desc "projectile-ripgrep-custom" "rg" #'projectile-ripgrep-custom
      :desc "parrot-start-animation" "rr" #'parrot-start-animation
      :desc "counsel-yank-pop" "ry" #'counsel-yank-pop
      :desc "sort-lines" "sl" #'sort-lines
      )

;; Spacemacs keybindings
(map! :leader
      :desc "magit-status" "gs" #'magit-status)

(define-key! "C-c g" #'counsel-git)

(use-package! key-chord
  :config
  (key-chord-mode 1)
  (key-chord-define-global "qf" 'source-peek)
  (key-chord-define-global "qr" 'query-replace)
  (key-chord-define-global "qw" 'pop-tag-mark)
  (key-chord-define-global "vv" 'other-window)
  (key-chord-define evil-insert-state-map "kj" 'evil-normal-state))

(use-package! parrot
  :config
  (add-hook 'parrot-click-hook 'mu4e-update-mail-and-index-wrapper))

(use-package! double-saber
  :config
  (with-eval-after-load "ggtags"
    (add-hook 'ggtags-global-mode-hook
              (lambda ()
                (double-saber-mode)
                (setq-local double-saber-start-line 5)
                (setq-local double-saber-end-text "Global found")))
    (define-key ggtags-global-mode-map (kbd "o") 'ggtags-navigation-visible-mode))
  (with-eval-after-load "ripgrep"
    (add-hook 'ripgrep-search-mode-hook
              (lambda ()
                (double-saber-mode)
                (setq-local double-saber-start-line 5)
                (setq-local double-saber-end-text "Ripgrep finished")))))
