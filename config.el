;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;;; Doom configuration
(setq doom-font (font-spec :family "Fixedsys Excelsior 301" :size 20))

;;; System configuration
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(toggle-truncate-lines -1) ;; wrap long lines

;;; Leader keybindings
(map! :leader
      :desc "avy-kill-whole-line" "ak" #'avy-kill-whole-line
      :desc "avy-kill-region" "aK" #'avy-kill-region
      :desc "avy-copy-line" "ay" #'avy-copy-line
      :desc "align-regexp" "ax" #'align-regexp
      :desc "bookmark jump" "bj" #'counsel-bookmark
      :desc "list bookmarks" "bl" #'list-bookmarks
      :desc "swap windows" "bx" #'ace-swap-window
      :desc "save and comment" "ck" #'evilnc-comment-and-kill-ring-save
      :desc "copy and comment" "cy" #'evilnc-copy-and-comment-lines
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
      :desc "dired-jump" "fj" #'dired-jump
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
(map!
 (:when (featurep! :editor multiple-cursors)
   :nv "C-n" #'evil-mc-make-and-goto-next-match
   :nv "C-p" #'evil-mc-make-and-goto-prev-match))

;;; Spacemacs keybindings
(map! :leader
      :desc "magit-status" "gs" #'magit-status
      :desc "magit-blame" "gb" #'magit-blame
      :desc "jump to line" "jl" #'evil-avy-goto-line
      :desc "narrow-to-defun" "nf" #'narrow-to-defun
      :desc "narrow-to-page" "np" #'narrow-to-page
      :desc "narrow-to-region" "nr" #'narrow-to-region
      :desc "narrow-widen" "nw" #'widen
      :desc "evil-iedit" "se" #'evil-iedit-state/iedit-mode
      :desc "truncate-lines" "tl" #'toggle-truncate-lines
      :desc "toggle-line-numbers" "tn" #'doom/toggle-line-numbers
      )

;;; Non-leader keybindings
;; TODO: get mu4e working
;; TODO: add git-gutter hydra
(map!
  :nvi "C-c g" #'counsel-git
  :nvi "M-." #'ggtags-find-tag-dwim)

;;; Package configuration
(use-package! corral
  :defer t
  :config
  (progn
    (defun corral-at-point (corral-command)
      (interactive)
      (when (and (eq evil-move-cursor-back t) (eq evil-state 'insert))
        (right-char))
      (evil-escape)
      (setq current-prefix-arg '(4))
      (call-interactively corral-command))

    (global-set-key (kbd "M-9") 'corral-parentheses-backward)
    (global-set-key (kbd "M-0") 'corral-parentheses-forward)
    (define-key evil-normal-state-map (kbd "M-9") 'corral-parentheses-backward)
    (define-key evil-normal-state-map (kbd "M-0") 'corral-parentheses-forward)
    (global-set-key (kbd "M-[") 'corral-brackets-backward)
    (global-set-key (kbd "M-]") 'corral-brackets-forward)
    (global-set-key (kbd "M-{") 'corral-braces-backward)
    (global-set-key (kbd "M-}") 'corral-braces-forward)
    (global-set-key (kbd "M-'") 'corral-single-quotes-forward)
    (global-set-key (kbd "M-\"") 'corral-double-quotes-forward)
    (global-set-key (kbd "C-M-0") (lambda () (interactive)
                                    (corral-at-point 'corral-parentheses-forward)))
    (global-set-key (kbd "C-M-]") (lambda () (interactive)
                                    (corral-at-point 'corral-brackets-forward)))
    (global-set-key (kbd "C-M-}") (lambda () (interactive)
                                    (corral-at-point 'corral-braces-forward)))
    (global-set-key (kbd "C-M-\"") (lambda () (interactive)
                                     (corral-at-point 'corral-double-quotes-forward)))
    (global-set-key (kbd "C-M-'") (lambda () (interactive)
                                    (corral-at-point 'corral-single-quotes-forward)))))

(use-package! key-chord
  :init
  (key-chord-mode 1)
  :config
  (key-chord-define-global "qf" 'source-peek)
  (key-chord-define-global "qr" 'query-replace)
  (key-chord-define-global "qw" 'pop-tag-mark)
  (key-chord-define-global "vv" 'other-window)
  (key-chord-define evil-insert-state-map "kj" 'evil-normal-state))

(use-package! parrot
  :init
  (parrot-mode)
  :config
  (add-hook 'parrot-click-hook 'mu4e-update-mail-and-index-wrapper)
  (define-key evil-normal-state-map (kbd "[r") 'parrot-rotate-prev-word-at-point)
  (define-key evil-normal-state-map (kbd "]r") 'parrot-rotate-next-word-at-point))

(use-package! double-saber
  :config
  (map!
   (:after double-saber
     :map double-saber-mode-map
     :nv "d" #'double-saber-delete
     :nv "x" #'double-saber-narrow
     :nv "s" #'double-saber-sort-lines
     :nv "u" #'double-saber-undo
     :nv "C-r" #'double-saber-redo
     :nv "C-_" #'double-saber-redo))
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

;;; Hooks
;; Python
(add-hook 'python-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (setq tab-width 4)
            (setq python-indent 4)
            ))

;; C-like languages (e.g. C, C++, Java, Python)
(add-hook 'prog-mode-hook
          (lambda ()
            ;; ggtags breaks iedit unless the below is nil
            (setq ggtags-highlight-tag nil)
            (ggtags-mode t)
            (setq semantic-stickyfunc-show-only-functions-p t)
            (local-set-key (kbd "C-M-.") 'insert-period)
            (local-set-key (kbd "C-M-,") 'cthulhu-summon-comma)
            (local-set-key (kbd "C-M-;") 'cthulhu-summon-c-terminator)
            (local-set-key (kbd "C-M-:") 'cthulhu-summon-function-call)
            (dtrt-indent-mode t)
            (with-eval-after-load "evil-surround"
              ;; Use 7 to /* wrap */ a word
              (push '(?7 . ("/* " . " */")) evil-surround-pairs-alist))

            ;; Treat _ as PART_OF_A_WORD
            (modify-syntax-entry ?_ "w")
            ;; Indent case labels in switch-case statements
            (c-set-offset 'case-label '+)
            ;; Visual-line-mode slows down swiper
            (setq visual-line-mode nil)
            (setq c-auto-newline nil)
            (setq c-default-style "linux"
                  c-basic-offset 4)
            (company-mode t)
            ;; (lsp)
            ;; (setq lsp-enable-on-type-formatting nil)
            ;; (setq lsp-enable-indentation nil)
            (local-set-key [tab] 'tab-indent-or-complete)))

;;; Function definitions
; Comment toggle
(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)
    (next-line)))
(global-set-key (kbd "M-;") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "C-M-;") 'comment-dwim)

(defun flyspell-visible()
  (interactive)
  (flyspell-region (window-start) (window-end)))

;; yasnippet
(defun yas-recompile-and-reload-all ()
  (interactive)
  (yas/recompile-all)
  (yas/reload-all))

;; Adapted rom http://irreal.org/blog/?p=297
(defun eval-and-replace (value)
  "Evaluate the sexp at point and replace it with its value"
  (interactive (list (eval-last-sexp nil)))
  (sp-backward-up-sexp)
  (sp-kill-sexp)
  (insert (format "%S" value)))

(defun gdb-get-breakpoint-str (breakpoint-type)
  "Return string of the form 'b foo.c:108'"
  (concat breakpoint-type " "
          (uniquify-buffer-base-name) ":"
          (number-to-string (line-number-at-pos))))

(defun gdb-set-fast-breakpoint ()
  "Insert breakpoint in ~/.gdbinit before line with the 'end #FBB' marker"
  (interactive)
  (let ((insert-br-cmd  "awk '/#BREAKPOINT_INSERT_MARKER/ { print \"  %s\"; print; next }1' ~/.gdbinit > ~/.gdbinit.tmp && cp ~/.gdbinit.tmp ~/.gdbinit")
        (breakpoint-type (if current-prefix-arg "tb" "b")))
    (shell-command
     (format insert-br-cmd (gdb-get-breakpoint-str breakpoint-type)))))

(defun add-minibuffer-ripgrep-keymap ()
  (define-key minibuffer-local-map (kbd "C-c C-p") (lambda ()
                                                     (interactive)
                                                     (minibuffer-insert "PRODUCE_")
                                                     (end-of-line))))

(defun minibuffer-toggle (string &optional eol)
  (save-excursion
    (let ((found nil))
      (if eol
          (progn
            (end-of-line)
            (setq found (re-search-backward (regexp-quote string) (line-beginning-position) t)))
        (beginning-of-line)
        (setq found (re-search-forward (regexp-quote string) (line-end-position) t)))
      (if found
          (replace-match "")
        (minibuffer-insert string eol)))))

(defun minibuffer-insert (string &optional eol)
  (save-excursion
    (if eol
        (progn
          (end-of-line)
          (delete-horizontal-space))
      (beginning-of-line))
    (insert string)))

(defun minibuffer-munch ()
  (save-excursion
    (beginning-of-line)
    (delete-region (point) (progn (forward-word-strictly) (point)))
    (delete-horizontal-space)))

(defun minibuffer-crunch ()
  (save-excursion
    (end-of-line)
    (delete-region (save-excursion (backward-word-strictly) (point)) (point))
    (delete-horizontal-space)))

(defun counsel-ffap-git ()
  (interactive)
  (require 'ffap)
  (let ((ivy-auto-select-single-candidate t))
    (counsel-git (ffap-string-at-point))))

(defun projectile-ripgrep-custom ()
  (interactive)
  (minibuffer-with-setup-hook
      'add-minibuffer-ripgrep-keymap
    (call-interactively #'projectile-ripgrep)))

;;; eval-after-load configuration
(map! :map dired-mode-map
  :n "a" #'ripgrep-regexp
  :n "W" #'wdired-change-to-wdired-mode
     "M-n" #'dired-narrow)
;; (after! dired
  ;; (define-key dired-mode-map "a" 'ripgrep-regexp)
  ;; (define-key dired-mode-map "A" 'helm-ag)
  ;; (define-key dired-mode-map "W" 'wdired-change-to-wdired-mode)
  ;; (define-key dired-mode-map (kbd "M-n") 'dired-narrow)
  ;; (setq diff-hl-dired-mode t)
  ;; (add-hook 'dired-mode-hook (lambda () (dired-hide-details-mode t)))
  ;; (setq dired-listing-switches "--group-directories-first -alh")
  ;; ;; (add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
  ;; )

(after! ivy
  (global-set-key "\C-s" 'counsel-grep-or-swiper)
  (global-set-key (kbd "C-S-s") 'isearch-forward)
  (global-set-key (kbd "C-S-r") 'isearch-backward)
  (define-key ivy-minibuffer-map (kbd "C-w") 'ivy-next-history-element)
  (define-key ivy-minibuffer-map (kbd "C-s") 'ivy-next-history-element)
  (define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line-or-history)
  (define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line-or-history)
  (define-key ivy-minibuffer-map (kbd "C-u") 'ivy-kill-line)
  (define-key ivy-minibuffer-map (kbd "C-c +") (lambda () (interactive) (minibuffer-insert " \\.c\\(pp\\)*$" t)))
  (define-key ivy-minibuffer-map (kbd "C-c h") (lambda () (interactive) (minibuffer-insert " \\.h\\(pp\\)*$" t)))
  (define-key ivy-minibuffer-map (kbd "C-c p") (lambda () (interactive) (minibuffer-insert " \\.py$" t)))
  (define-key ivy-minibuffer-map (kbd "C-c k") (lambda () (interactive) (minibuffer-munch)))
  (define-key ivy-minibuffer-map (kbd "C-c K") (lambda () (interactive) (minibuffer-crunch))))

(after! ggtags
  (define-key ggtags-navigation-map (kbd "M-<up>") 'ggtags-navigation-previous-file)
  (define-key ggtags-navigation-map (kbd "M-<down>") 'ggtags-navigation-next-file)
  (define-key evil-normal-state-map (kbd "M-<left>") 'ggtags-prev-mark)
  (define-key evil-normal-state-map (kbd "M-<right>") 'ggtags-next-mark)
  (add-hook 'ggtags-global-mode-hook (lambda ()
                                       (when (and (buffer-live-p ggtags-global-last-buffer)
                                                  (with-current-buffer ggtags-global-last-buffer
                                                    (derived-mode-p 'ggtags-global-mode)))
                                         (ggtags-navigation-visible-mode t)))))
(after! ripgrep
  (define-key ripgrep-search-mode-map (kbd "M-<up>") 'compilation-previous-error)
  (define-key ripgrep-search-mode-map (kbd "M-<down>") 'compilation-next-error))

(after! evil-snipe
  (setq evil-snipe-repeat-keys t)
  (setq evil-snipe-scope 'buffer)
  (setq evil-snipe-repeat-scope 'buffer))

;; FIXME: need this to get parrot working
(after! doom-modeline
  (doom-modeline-def-modeline 'my/modeline
    '(bar matches buffer-info remote-host buffer-position parrot selection-info)
    '(misc-info minor-modes checker input-method buffer-encoding major-mode process vcs))
  (defun setup-custom-doom-modeline ()
    (doom-modeline-set-modeline 'my/modeline 'default))
  (add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline))

;; (load-file "~/.irobot/custom/doom-config.el")
