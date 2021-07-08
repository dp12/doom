;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;;; Doom configuration
(if (not (string-equal system-type "windows-nt"))
    (setq doom-font (font-spec :family "Fixedsys Excelsior 301" :size 22))
    (setq doom-font (font-spec :family "Fixedsys Excelsior 3.01" :size 20))
  (setq doom-font (font-spec :family "Consolas" :size 20))
  (setq doom-theme 'gruvbox-light-soft))
(setq doom-modeline-buffer-file-name-style 'truncate-upto-project)
;; (face-spec-set 'doom-dashboard-banner '((t (:inherit doom-modeline-evil-emacs-state))))
;; (face-spec-set 'doom-dashboard-banner '((t (:inherit default))))
(face-spec-set 'doom-dashboard-banner '((t (:inherit hl-line))))

;;; System configuration
(menu-bar-mode 0)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(toggle-truncate-lines -1) ;; wrap long lines
(add-to-list 'auto-mode-alist '("\\.bin\\'" . hexl-mode))
(defadvice async-shell-command (around hide-async-windows activate)
  (save-window-excursion ad-do-it))
(defalias 'iedit-lib-cleanup 'iedit-cleanup)
(setq inhibit-compacting-font-caches t)

(add-hook! 'whitespace-mode-hook
  (setq whitespace-style '(face tabs tab-mark spaces space-mark))
  (setq whitespace-display-mappings
        '(
          (space-mark   ?\     [?·]     [?.])      ; space - middle dot
          (space-mark   ?\xA0  [?¤]     [?_])      ; hard space - currency sign
          (newline-mark ?\n    [?$ ?\n])           ; eol - dollar sign
          (tab-mark     ?\t    [?» ?\t] [?\\ ?\t]) ; tab - right guillemet
          )))

;; Evil configuration
(setq evil-ex-search-highlight-all nil)
(setq evil-ex-search-persistent-highlight nil)

;;; Package configuration
(global-git-gutter+-mode)
;;(highlight-tail-mode)
(setq dumb-jump-force-searcher 'rg)
(setq company-show-numbers t)
(setq company-idle-delay 0)
(setq company-dabbrev-downcase nil)
(setq lsp-enable-on-type-formatting nil)

;;; Leader keybindings
(map! :leader
      :desc "+default/search-buffer" "RET" #'+default/search-buffer
      :desc "+default/search-buffer" "[" #'+default/search-buffer
      :desc "avy-goto-char-2" "SPC" #'avy-goto-char-2
      :desc "avy-kill-whole-line" "ak" #'avy-kill-whole-line
      :desc "avy-kill-region" "aK" #'avy-kill-region
      :desc "avy-copy-region" "ar" #'avy-copy-region
      :desc "avy-copy-line" "ay" #'avy-copy-line
      :desc "align-regexp" "ax" #'align-regexp
      :desc "evil-avy-goto-char-timer" "at" #'evil-avy-goto-char-timer
      :desc "breakpoint ghidra" "bg" #'ghidra-get-gdb-breakpoint
      :desc "bookmark jump" "bj" #'counsel-bookmark
      :desc "list bookmarks" "bl" #'list-bookmarks
      :desc "bookmark save" "bs" #'bookmark-save
      :desc "swap windows" "bx" #'ace-swap-window
      :desc "calc-yank-hex" "ch" #'hexentanz-calc-yank-hex
      :desc "cycle font" "cf" #'cycle-font-select
      :desc "save and comment" "ck" #'evilnc-comment-and-kill-ring-save
      :desc "centaur-tabs-mode" "ct" #'centaur-tabs-mode
      :desc "copy and comment" "cy" #'evilnc-copy-and-comment-lines
      :desc "dired-omit-mode" "d." #'dired-omit-mode
      :desc "fastdirs1" "d1" (lambda ()
                               (interactive)
                               (dired-jump-to-fastdir "d1"))
      :desc "fastdirs2" "d2" (lambda ()
                               (interactive)
                               (dired-jump-to-fastdir "d2"))
      :desc "fastdirs3" "d3" (lambda ()
                               (interactive)
                               (dired-jump-to-fastdir "d3"))
      :desc "fastdirs4" "d4" (lambda ()
                               (interactive)
                               (dired-jump-to-fastdir "d4"))
      :desc "fastdirs5" "d5" (lambda ()
                               (interactive)
                               (dired-jump-to-fastdir "d5"))
      :desc "happily-ever-no-after" "da" #'happily-ever-no-after
      :desc "delete-to-bol" "db" #'delete-to-bol
      :desc "dired home" "dh" (lambda () (interactive) (dired "~"))
      :desc "remove ld path" "dl" #'remove-ld-path
      :desc "refresh + counsel-locate" "sF" (lambda ()
                                              (interactive)
                                              (async-shell-command "sudo updatedb")
                                              (counsel-locate))
      :desc "dumb jump other" "dG" #'dumb-jump-go-other-window
      :desc "dumb jump" "dg" #'dumb-jump-go
      :desc "dired-jump" "dj" #'dired-jump
      :desc "kill dired" "dk" #'kill-dired-buffers
      :desc "delete-matching-lines" "dm" #'delete-matching-lines
      :desc "dumb jump quick look" "dq" #'dumb-jump-quick-look
      :desc "dired jump other" "do" #'dired-jump-other-window
      :desc "double-saber" "ds" #'double-saber-mode
      :desc "ediff-buffers" "ed" #'ediff-buffers
      :desc "even horizontal" "eh" #'rotate:even-horizontal
      :desc "evil-show-marks" "em" #'evil-show-marks
      :desc "evil-show-registers" "er" #'evil-show-registers
      :desc "quick-file jump" "fd" #'quick-file-hydra/body
      :desc "quick-file jump" "fk" #'quick-file-hydra/body
      :desc "counsel-git" "fg" #'counsel-git
      :desc "dired-jump" "fj" #'dired-jump
      :desc "counsel-file-jump" "fJ" #'counsel-file-jump
      :desc "counsel-file-jump" "fo" #'counsel-file-jump-orgnotes
      :desc "flyspell-auto-correct-line" "fl" #'flyspell-auto-correct-line
      :desc "fundamental-mode" "fm" #'fundamental-mode
      :desc "projectile-ripgrep-filename" "fN" #'projectile-ripgrep-filename
      :desc "find other file" "fO" #'ff-find-other-file
      :desc "find other file other window" "f0" #'ff-find-other-file-other-window
      :desc "fastaction1" "f1" (lambda ()
                                 (interactive)
                                 (async-shell-command-no-window "bash -ic 'f1'"))
      :desc "fastaction2" "f2" (lambda ()
                                 (interactive)
                                 (async-shell-command-no-window "bash -ic 'f2'"))
      :desc "fastaction3" "f3" (lambda ()
                                 (interactive)
                                 (async-shell-command-no-window "bash -ic 'f3'"))
      :desc "fastaction4" "f4" (lambda ()
                                 (interactive)
                                 (async-shell-command-no-window "bash -ic 'f4'"))
      :desc "fastaction5" "f5" (lambda ()
                                 (interactive)
                                 (async-shell-command-no-window "bash -ic 'f5'"))
      :desc "frog-jump-buffer" "fb" #'frog-jump-buffer
      :desc "copy-file-basename-to-clipboard" "fn" #'copy-file-basename-to-clipboard
      :desc "copy-file-fullname-to-clipboard" "fw" #'copy-file-fullname-to-clipboard
      :desc "fzf-git-files" "fz" #'fzf-git-files
      :desc "gdb-set-fast-breakpoint" "gd" #'gdb-set-fast-breakpoint
      :desc "counsel-ffap-git" "gff" #'counsel-ffap-git
      :desc "ggtags-find-reference" "gr" #'ggtags-find-reference
      :desc "hex-subtract" "h-" #'hexentanz-subtract
      :desc "hex-subtract" "Hr" #'hexentanz-forward-region-to-rax2
      :desc "highlight-symbol-at-point" "h." #'highlight-symbol-at-point
      :desc "unhighlight-regexp" "hr" #'unhighlight-regexp
      :desc "hexl-mode" "hx" #'hexl-mode
      :desc "insert libc base" "il" #'insert-libc-base
      :desc "insert one gadgets" "i1" #'insert-one-gadgets
      :desc "evil inc-at-pt" "in" #'evil-numbers/inc-at-pt-incremental
      ;; :desc "selectrum-recentf" "if" #'selectrum-recentf-open-files
      :desc "counsel-recentf" "if" #'counsel-recentf
      :desc "jump file" "jf" #'quick-file-hydra/body
      :desc "jump file" "jj" #'quick-file-hydra/body
      :desc "mu4e update mail cnt" "ma" #'mu4e-alert-update-mail-count-interactive
      :desc "evil-mc-mode" "mc" #'evil-mc-mode
      :desc "magit-find-file" "mf" #'magit-find-file
      :desc "mu4e-jump-to-mail" "mj" #'mu4e-jump-to-mail
      :desc "imenu-list" "ml" #'imenu-list-smart-toggle
      :desc "make-nkp" "mn" #'make-nkp
      :desc "magit-file-popup" "mp" #'magit-file-dispatch
      :desc "mu4e-update-mail" "mu" #'mu4e-update-mail-and-index-wrapper
      :desc "toggle-org-checkbox" "oc" #'toggle-org-checkbox
      :desc "counsel-org-goto" "og" #'counsel-org-goto
      :desc "org-toggle-heading" "oh" #'org-toggle-heading
      :desc "org-show-subtree" "os" #'org-show-subtree
      :desc "org-babel-execute-src-block" "ox" #'org-babel-execute-src-block
      :desc "quick calc" "qc" #'quick-calc
      :desc "quick calc insert" "qC" (lambda ()
                                       (interactive)
                                       (let ((current-prefix-arg '(4)))
                                         (call-interactively 'quick-calc)))
      :desc "quick run" "qR" #'quickrun
      :desc "counsel-rg" "rc" #'counsel-rg
      :desc "rotate-layout" "rl" #'rotate-layout
      :desc "rax2" "rx" #'hexentanz-rax2
      :desc "rax2 h2d" "rh" #'hexentanz-rax2-hex-to-dec
      :desc "rax2 h2d" "rH" (lambda ()
                              (interactive)
                              (let ((current-prefix-arg '(4)))
                                (call-interactively 'hexentanz-rax2-hex-to-dec)))
      :desc "rax2" "rX" (lambda ()
                          (interactive)
                          (let ((current-prefix-arg '(4)))
                            (call-interactively 'rax2)))
      :desc "rax2 force hex" "rk" #'hexentanz-rax2-force-hex
      :desc "rax2 force hex" "rK" (lambda ()
                                 (interactive)
                                 (let ((current-prefix-arg '(4)))
                                   (call-interactively 'hexentanz-rax2-force-hex)))
      :desc "rax2 string" "rs" #'hexentanz-rax2-string
      :desc "rax2 string" "rS" (lambda ()
                                 (interactive)
                                 (let ((current-prefix-arg '(4)))
                                   (call-interactively 'hexentanz-rax2-string)))
      :desc "projectile-ripgrep-custom" "rg" #'projectile-ripgrep-custom
      :desc "run-python" "rp" #'run-python
      :desc "parrot-start-animation" "rr" #'parrot-start-animation
      :desc "counsel-yank-pop" "ry" #'counsel-yank-pop
      :desc "sort-lines" "sl" #'sort-lines
      :desc "symbol overlay" "so" #'hydra-symbol-overlay/symbol-overlay-put
      :desc "search online" "sO" #'+lookup/online
      :desc "yasnippet recompile/refresh" "yr" #'yas-recompile-and-reload-all
      :desc "tabify" "tt" #'tabify
      :desc "toggle link display" "tL" #'org-toggle-link-display
      :desc "untabify" "tu" #'untabify
      :desc "typing-of-emacs" "ty" #'typing-of-emacs
      :desc "var fstring= python" "vf" #'var-fstring=-python
      :desc "var log python" "vl" #'var-log-python
      :desc "var print python" "vp" #'var-print-python
      )
(map!
 (:when (featurep! :editor multiple-cursors)
   :nv "C-n" #'evil-mc-make-and-goto-next-match
   :nv "C-p" #'evil-mc-make-and-goto-prev-match
   :nv "C-S-n" #'evil-mc-skip-and-goto-next-match
   :nv "C-S-p" #'evil-mc-skip-and-goto-prev-match
   :nv "gzi" #'evil-mc-make-cursor-in-visual-selection-beg
   :nv "gza" #'evil-mc-make-cursor-in-visual-selection-end))

;;; Spacemacs keybindings
(map! :leader
      :desc "open link" "al" #'link-hint-open-link ;; xo is illegal
      :desc "delete trailing whitespace" "dtw" #'delete-trailing-whitespace
      :desc "fill column" "tf" #'fci-mode
      :desc "magit-status" "gs" #'magit-status
      :desc "magit-blame" "gb" #'magit-blame-addition
      :desc "gdb-workspace" "gw" #'gdb-workspace
      :desc "jump to line" "jl" #'evil-avy-goto-line
      :desc "narrow-to-defun" "nf" #'narrow-to-defun
      :desc "narrow-to-page" "np" #'narrow-to-page
      :desc "narrow-to-region" "nr" #'narrow-to-region
      :desc "narrow-widen" "nw" #'widen
      :desc "evil-iedit" "se" #'evil-iedit-state/iedit-mode
      :desc "truncate-lines" "tl" #'toggle-truncate-lines
      :desc "toggle-line-numbers" "tn" (lambda ()
                                         (interactive)
                                         (setq display-line-numbers
                                               (not display-line-numbers)))
      :desc "toggle-relative-numbers" "tr" (lambda ()
                                             (interactive)
                                             (setq display-line-numbers
                                                   (if (or (eq display-line-numbers t)
                                                           (eq display-line-numbers nil))
                                                       (if visual-line-mode 'visual 'relative)
                                                     t)))
      :desc "toggle read-only" "tR" #'read-only-mode
      :desc "toggle whitespace mode" "tw" #'whitespace-mode
      "0" #'winum-select-window-0
      "1" #'winum-select-window-1
      "2" #'winum-select-window-2
      "3" #'winum-select-window-3
      "4" #'winum-select-window-4
      "5" #'winum-select-window-5
      "6" #'winum-select-window-6
      "7" #'winum-select-window-7
      "8" #'winum-select-window-8
      "9" #'winum-select-window-9
      "l" #'hydra-workspaces/body
      "Tm" #'menu-bar-mode
      "w|" #'split-window-horizontally
      "w-" #'split-window-vertically)

;;; Non-leader keybindings
;; TODO: get mu4e working
(map!
  :nvi "M-D" #'company-dabbrev
  :nvi "C-M-D" #'company-dabbrev-code
  :nvi "M-F" #'company-files
  :nvi "M-?" #'company-hippie
  :nvi "M-H" #'company-try-hard
  :nvi "C-c g" #'counsel-git
  :nvi "M-U" #'downcase-word
  :nv "+" #'evil-numbers/inc-at-pt
  :nv "-" #'evil-numbers/dec-at-pt
  :v "s" #'evil-surround-region
  :nvi "M-." #'ggtags-find-tag-dwim
  :nvi "C-M-S-<right>" #'sp-slurp-hybrid-sexp
  :nvi "C-M-S-<left>" #'sp-forward-barf-sexp
  :nvi "C-M-S-<down>" #'sp-push-hybrid-sexp
  :nvi "C-M-S-<up>" #'sp-transpose-hybrid-sexp
  :nvi "C-M-S-k" #'sp-kill-hybrid-sexp
  :nvi (kbd "C-c <left>") #'windmove-left
  :nvi (kbd "C-c <right>") #'windmove-right
  :nvi (kbd "C-c <down>") #'windmove-down
  :nvi (kbd "C-c <up>") #'windmove-up
  :nvi "C-7" #'+workspace/other
  :nv "gt" #'centaur-tabs-forward
  :nv "gT" #'centaur-tabs-backward
  :nv "]f" #'ff-find-other-file
  :nv "[f" #'ff-find-other-file-other-window
  :nv "[h" #'parrot-hippie
  )

(after! dired
  (map! :map dired-mode-map
        :n "a" #'ripgrep-regexp
        :n "W" #'wdired-change-to-wdired-mode
        "M-n" #'dired-narrow)
  (add-hook! dired-mode (dired-hide-details-mode t)))

(map! :map magit-status-mode-map
  :nv "gz" #'magit-jump-to-stashes)

(map! :map magit-file-section-map
  :nv [S-return] (lambda ()
                     (interactive)
                     (let ((current-prefix-arg '(4)))
                       (call-interactively 'magit-diff-visit-file))))

(map! :map magit-file-section-map
  :nv [S-return] (lambda ()
                     (interactive)
                     (let ((current-prefix-arg '(4)))
                       (call-interactively 'magit-diff-visit-file))))

(map! :after ccls
      :map (c-mode-map c++-mode-map)
      :n "C-l" #'recenter-top-bottom)

;; Ediff
;; From http://stackoverflow.com/questions/9656311/conflict-resolution-with-emacs-ediff-how-can-i-take-the-changes-of-both-version
(defun ediff-copy-both-to-C ()
  (interactive)
  (ediff-copy-diff ediff-current-difference nil 'C nil
                   (concat
                    (ediff-get-region-contents ediff-current-difference 'A ediff-control-buffer)
                    (ediff-get-region-contents ediff-current-difference 'B ediff-control-buffer))))
(defun add-c-to-ediff-mode-map () (map!
                                   :map ediff-mode-map
                                   :nvi "c" #'ediff-copy-both-to-C))
(add-hook! 'ediff-keymap-setup-hook 'add-c-to-ediff-mode-map)

;;; Package configuration
(use-package! corral
  :config
  (progn
    (defun corral-at-point (corral-command)
      (interactive)
      (setq current-prefix-arg '(4))
      (call-interactively corral-command))

    (map! :nvi "M-9" #'corral-parentheses-backward
          :nvi "M-0" #'corral-parentheses-forward
          :nvi "M-[" #'corral-brackets-backward
          :nvi "M-]" #'corral-brackets-forward
          :nvi "M-{" #'corral-braces-backward
          :nvi "M-}" #'corral-braces-forward
          :nvi "M-'" #'corral-single-quotes-forward
          :nvi "M-\"" #'corral-double-quotes-forward
          :nvi "C-M-0" (lambda () (interactive) (corral-at-point 'corral-parentheses-forward))
          :nvi "C-M-]" (lambda () (interactive) (corral-at-point 'corral-brackets-forward))
          :nvi "C-M-}" (lambda () (interactive) (corral-at-point 'corral-braces-forward))
          :nvi "C-M-\"" (lambda () (interactive) (corral-at-point 'corral-double-quotes-forward))
          :nvi "C-M-'" (lambda () (interactive) (corral-at-point 'corral-single-quotes-forward)))))

(use-package! evil-iedit-state)

(use-package! evil-lisp-state
  :init
  (setq evil-lisp-state-global t))

(use-package! evil-fringe-mark
  :init
  (global-evil-fringe-mark-mode)
  (setq-default left-fringe-width 16))

(use-package! isearch-prop)

(use-package! ivy-avy :after ivy)

(use-package! key-chord
  :init
  (key-chord-mode 1)
  :config
  (key-chord-define-global "qf" 'source-peek)
  (key-chord-define-global "qr" 'query-replace)
  (key-chord-define-global "qw" 'pop-tag-mark)
  (key-chord-define-global "vv" 'other-window)
  (key-chord-define evil-normal-state-map "kj" 'doom/escape)
  (key-chord-define evil-insert-state-map "kj" 'evil-normal-state))

(use-package! parrot
  :init
  (parrot-mode)
  :config
  (add-hook! 'parrot-click-hook 'parrot-rotate-next-word-at-point)
  (define-key evil-normal-state-map (kbd "[r") 'parrot-rotate-prev-word-at-point)
  (define-key evil-normal-state-map (kbd "]r") 'parrot-rotate-next-word-at-point)

  (dolist (entry '((:rot ("encrypt" "decrypt") :caps t :upcase t)
                   (:rot ("encode" "decode") :caps t :upcase t)
                   (:rot ("enable" "disable") :caps t :upcase t)
                   (:rot ("unlock" "lock") :caps t :upcase t)
                   (:rot ("read" "write") :caps t :upcase t)
                   (:rot ("tx" "rx") :caps t :upcase t)
                   (:rot ("transmit" "receive") :caps t :upcase t)
                   (:rot ("src" "dest") :caps t :upcase t)
                   (:rot ("up" "down") :caps t :upcase t)))
    (add-to-list 'parrot-rotate-dict entry)))

(use-package! evil-lisp-state
  :config
  (evil-lisp-state-leader "SPC k"))

(use-package! evil-org
  :config
  (evil-org-set-key-theme '(textobjects navigation additional todo))
  (evil-define-key 'normal evil-org-mode-map
    (kbd "M-o") (evil-org-define-eol-command org-insert-subheading))
  (evil-define-key 'normal evil-org-mode-map
    (kbd "M-S-<return>") (evil-org-define-eol-command org-insert-todo-heading)))

(use-package! org-roam-server
  :init
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-export-inline-images t
        org-roam-server-authenticate nil
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))

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
     :nv "C-_" #'double-saber-redo)))

(use-package! hexentanz
  :load-path "~/hexentanz")
;;; Hooks
;; Python
(add-hook! 'python-mode-hook
  (setq indent-tabs-mode nil)
  (setq tab-width 4)
  (setq python-indent 4))

;; C-like languages (e.g. C, C++, Java, Python)
(add-hook! 'prog-mode-hook
           ;; ggtags breaks iedit unless the below is nil
           (setq ggtags-highlight-tag nil)
           (ggtags-mode t)
           (yas-minor-mode)
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
           (toggle-truncate-lines nil)
           (setq word-wrap nil)
           (setq c-auto-newline nil)
           (setq c-default-style "linux"
                 c-basic-offset 4)
           (company-mode t)
           ;; (lsp)
           ;; (setq lsp-enable-on-type-formatting nil)
           ;; (setq lsp-enable-indentation nil)
           (local-set-key [tab] 'tab-indent-or-complete))

;;; Function definitions
(defun async-shell-command-no-window
    (command)
  (interactive)
  (let
      ((display-buffer-alist
        (list
         (cons
          "\\*Async Shell Command\\*.*"
          (cons #'display-buffer-no-window nil)))))
    (async-shell-command
     command)))

(defun hide/show-docx-metadata (&optional show)
  "Remove <w:> and </w> tags and text within them.
    With a prefix arg, show all invisible text."
  (interactive "P")
  (if show
      (isearchp-make-zones-visible `((,(point-min) ,(point-max))))
    (let ((isearchp-dim-outside-search-area-flag  nil))
      (isearchp-regexp-define-contexts (point-min) (point-max) 'invisible "</*w:[^>]*>"))))

(defvar parrot-hippie-trailing-text "")
(defvar parrot-hippie-end-regexp "[[:space:]]\\|,\\|(\\|)\\|\\[\\|<\\|{\\|;")
(defun parrot-hippie ()
  (interactive)
  (let (start-pt end-pt)
    (save-excursion
      (ignore-errors
        (call-interactively #'hippie-expand))
      (parrot-start-animation)
      (if (< he-num 0) ;; no more candidates; insert original post-cursor text
          (progn
            ;; (message "inserting trailing text, which is %s" parrot-hippie-trailing-text)
            (insert parrot-hippie-trailing-text))
        (setq start-pt (point))
        (re-search-forward parrot-hippie-end-regexp (line-end-position) t)
        (setq end-pt (1- (point)))
        (setq parrot-hippie-trailing-text (buffer-substring-no-properties start-pt end-pt))
        ;; (message "parrot-hippie-trailing-text is %s" parrot-hippie-trailing-text)
        (delete-region start-pt end-pt)))))

;; From https://www.emacswiki.org/emacs/HippieExpand#toc10
(defun my-hippie-expand-completions (&optional hippie-expand-function)
      "Return the full list of possible completions generated by `hippie-expand'.
    The optional argument can be generated with `make-hippie-expand-function'."
      (let ((this-command 'my-hippie-expand-completions)
            (last-command last-command)
            (buffer-modified (buffer-modified-p))
            (hippie-expand-function (or hippie-expand-function 'hippie-expand)))
        (cl-flet ((ding)) ; avoid the (ding) when hippie-expand exhausts its options.
          (while (progn
                   (funcall hippie-expand-function nil)
                   (setq last-command 'my-hippie-expand-completions)
                   (not (equal he-num -1)))))
        ;; Evaluating the completions modifies the buffer, however we will finish
        ;; up in the same state that we began.
        (set-buffer-modified-p buffer-modified)
        ;; Provide the options in the order in which they are normally generated.
        (delete he-search-string (reverse he-tried-table))))

(defvar company-hippie-num-candidates 5)
(setq company-hippie-cands (my-hippie-expand-completions))

(defun company-hippie (command &optional arg &rest ignored)
  (interactive (list 'interactive))
  (let ((company-transformers nil)
        (company-tooltip-limit 3))    (cl-case command      (interactive (company-begin-backend 'company-hippie))      (sorted t)      (prefix (company-grab-symbol))        ;; (candidates (subseq (my-hippie-expand-completions) 0 company-hippie-num-candidates)))))
      (candidates (my-hippie-expand-completions)))))
;; (candidates company-hippie-cands))))

(defun delete-to-bol ()
  (interactive)
  (if (region-active-p)
      (indent-region (region-beginning) (region-end) 0)
    (back-to-indentation)
    (kill-line 0)))

(defun dired-jump-to-fastdir (fastdir)
  (interactive)
  (dired (shell-command-to-string (concat "cat ~/fastdirs | grep " fastdir " | cut -d'=' -f2 | cut -c 2- | head -c-1"))))

(defun ff-find-other-file-other-window ()
    (interactive)
    (let ((current-prefix-arg '(4)))
      (call-interactively 'ff-find-other-file)))

;; Doom new workspace helper function
(defun +workspace/new-with-name (name)
  (interactive "sWorkspace name: ")
  (+workspace/new name))

(defun +workspace/switch-to-or-create (index)
  (interactive)
  (if (nth index (+workspace-list-names))
    (+workspace/switch-to index)
    (call-interactively #'+workspace/new-with-name)))

;;;;;;;;;;;;;;;
;; PWN FUNCS ;;
;;;;;;;;;;;;;;;

;; 0x7ffff79e2000
;; 0x7ffff7a79070
;;
;; -->
;;
;; # libc base: 0x7ffff79e2000
;; # libc leak: 0x7ffff7a79070
;; # offset: 0x97070
;; libc.address = libc_leak - 0x97070
;; log.info("libc.address: 0x%x" % libc.address)
(defun insert-libc-base ()
  (interactive)
  (let (start-pt end-pt offset-bounds offset)
    (back-to-indentation)
    (setq start-pt (point))
    (insert "# libc base: ")
    (forward-line)
    (insert "# libc leak: ")
    (end-of-line)
    (setq end-pt (point))
    (goto-char start-pt)
    (push-mark (1+ end-pt))
    (hex-subtract)
    (previous-line)
    (end-of-line)
    (setq offset-bounds (bounds-of-thing-at-point 'symbol))
    (setq offset (buffer-substring-no-properties (car offset-bounds) (cdr offset-bounds)))
    (forward-line)
    (back-to-indentation)
    (insert (concat "libc.address = libc_leak - " offset "\n"
                    "log.info(\"libc.address: 0x%x\" % libc.address)\n"))))

;; Deletes after and the first argument
;; target.sendlineafter(": ", "1") --> target.sendline("1")
(defun happily-ever-no-after ()
  (interactive)
  (let (start-pt)
    (replace-string "after" "" nil (line-beginning-position) (line-end-position))
    (forward-char)
    (setq start-pt (point))
    (search-forward "," (line-end-position))
    (delete-region start-pt (1+ (point)))))

;; gdb.debug([ld.path, elf.path]) --> gdb.debug(elf.path)
(defun remove-ld-path ()
  (interactive)
  (replace-string "[ld.path, " "" nil (line-beginning-position) (line-end-position))
  (replace-string "elf.path]" "elf.path" nil (line-beginning-position) (line-end-position)))

(defun make-nkp ()
  (interactive)
  (find-file "./nkp.py"))

(defun gdb-workspace ()
  (interactive)
  (unless (member "gdb" (+workspace-list-names))
    (+workspace/new "gdb"))
  (+workspace/switch-to "gdb")
  (find-file "~/.gdbinit"))

(defun get-lvalue-at-point ()
  (car (last (split-string
              (car (split-string
                    (thing-at-point 'line t) "="))))))

(defun var-fstring=-python ()
  (interactive)
  (let ((target-var (get-lvalue-at-point)))
    (forward-line)
    (back-to-indentation)
    (insert (concat "print(f\"{" target-var "=}\")\n"))))

(defun var-log-python ()
  (interactive)
  (let ((target-var (get-lvalue-at-point)))
    (forward-line)
    (back-to-indentation)
    (insert (concat "log.info(\"" target-var ": 0x%x\" % " target-var ")\n"))))

(defun var-print-python ()
  (interactive)
  (let ((target-var (get-lvalue-at-point)))
    (forward-line)
    (back-to-indentation)
    (insert (concat "print(\"" target-var ": 0x%x\" % " target-var ")\n"))))

;; (defun rax2-region-by-lines ()
;;   (interactive)
;;   (let ((beg (copy-marker (region-beginning)))
;;         (end (copy-marker (region-end))))
;;   (goto-char (marker-position beg))
;;   ;; (goto-char (region-end))
;;   ;; (print (region-end))
;;   ;; (while (< (point) (max (marker-position beg)
;;   ;;                        (marker-position end)))
;;   (while (< (point) (marker-position end))
;;     (beginning-of-line)
;;     ;; (message "calling rax2-line")
;;     (rax2-line)
;;     (forward-line)
;;     ;; (message "point is: %d; region is %d %d" (point)
;;     ;;          (marker-position beg)
;;     ;;          (marker-position end))
;;   )))

;; 0x4029 + 0x100
(defun rax2-region ()
  (interactive)
  (let ((instr (buffer-substring-no-properties
                    (region-beginning) (region-end)))
        (outstr ""))
    (message instr)
    (when (string-match-p "[+-/*%]" instr)
      (setq instr (replace-regexp-in-string "[ \t\n]" "" instr)))
    (setq outstr (string-trim (shell-command-to-string (concat "rax2 " instr))))
      (print outstr)
      (end-of-line)
      (insert (concat " => " (string-trim outstr)))))

(defun insert-one-gadgets ()
  (interactive)
  (let ((one-gadget-cmd
         "one_gadget %s 2>/dev/null | grep '/bin/sh' | cut -d' ' -f1 | while read addr; do echo 'one_gadget = libc.address + '${addr}; done")
        (libc (car (directory-files "\./" nil "libc.*\.so" t)))

        (log-info "log.info(\"one_gadget: 0x%x\" % one_gadget)"))
    (insert (concat (shell-command-to-string (format one-gadget-cmd libc)) log-info))))

;;;;;;;;;;;;;;;;;;;
;; END PWN FUNCS ;;
;;;;;;;;;;;;;;;;;;;

;; From http://ergoemacs.org/emacs/emacs_switching_fonts.html
(setq cycle-font-list
      (cond
       ((string-equal system-type "windows-nt")
        '(
          "Fixedsys Excelsior 3.01-15"
          "Lucida Console-10"
          ))
       ((string-equal system-type "gnu/linux")
        '(
          "Fixedsys Excelsior 3.01-15"
          "bitocra13full"
          "GohuFont-24"
          "sys-24"
          "Dina-24"
          "Ubuntu Mono-16"
          "Tamsynmod-16"
          "Terminus-16"
          "Consolas-14"
          ))))

(defun counsel-file-jump-orgnotes ()
  (interactive)
  (counsel-file-jump nil "/media/sf_Shared/orgnotes"))

(defun cycle-font-select ()
  (interactive)
  (set-frame-font (completing-read "Select font: " cycle-font-list nil t)))
(defun cycle-font (@n)
  "Change font in current frame.
Each time this is called, font cycles thru a predefined list of fonts in the variable `cycle-font-list' .
If @n is 1, cycle forward.
If @n is -1, cycle backward.

URL `http://ergoemacs.org/emacs/emacs_switching_fonts.html'
Version 2015-09-21"
  (interactive "p")
  ;; this function sets a property “state”. It is a integer. Possible values are any index to the fontList.
  (let (cur-font prev-state next-state )
    (setq prev-state (if (get 'cycle-font 'state) (get 'cycle-font 'state) 0))
    (setq next-state (% (+ prev-state (length cycle-font-list) @n) (length cycle-font-list)))
    (setq cur-font (nth next-state cycle-font-list))
    (set-frame-font cur-font t)
    ;; (set-frame-parameter nil 'font cur-font)
    (message "Current font is: %s" cur-font )
    (put 'cycle-font 'state next-state)))

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

(defun doom-dashboard-widget-doge-banner ()
  (let ((point (point)))
    (mapc (lambda (line)
            (insert (propertize (+doom-dashboard--center +doom-dashboard--width line)
                                'face 'doom-dashboard-banner) " ")
            (insert "\n"))
'("
                      ░░░░░░░░░▄░░░░░░░░░░░░░░▄░░░░
                      ░░░░░░░░▌▒█░░░░░░░░░░░▄▀▒▌░░░
     Such powerful    ░░░░░░░░▌▒▒█░░░░░░░░▄▀▒▒▒▐░░░
                      ░░░░░░░▐▄▀▒▒▀▀▀▀▄▄▄▀▒▒▒▒▒▐░░░
                      ░░░░░▄▄▀▒░▒▒▒▒▒▒▒▒▒█▒▒▄█▒▐░░░  Vim and Emacs
                      ░░░▄▀▒▒▒░░░▒▒▒░░░▒▒▒▀██▀▒▌░░░    So love
                      ░░▐▒▒▒▄▄▒▒▒▒░░░▒▒▒▒▒▒▒▀▄▒▒▌░░      Much forbidden
                      ░░▌░░▌█▀▒▒▒▒▒▄▀█▄▒▒▒▒▒▒▒█▒▐░░
Very modes            ░▐░░░▒▒▒▒▒▒▒▒▌██▀▒▒░░░▒▒▒▀▄▌░
                      ░▌░▒▄██▄▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▌░
                      ▀▒▀▐▄█▄█▌▄░▀▒▒░░░░░░░░░░▒▒▒▐░
                      ▐▒▒▐▀▐▀▒░▄▄▒▄▒▒▒▒▒▒░▒░▒░▒▒▒▒▌
                      ▐▒▒▒▀▀▄▄▒▒▒▄▒▒▒▒▒▒▒▒░▒░▒░▒▒▐░
                      ░▌▒▒▒▒▒▒▀▀▀▒▒▒▒▒▒░▒░▒░▒░▒▒▒▌░
                      ░▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒░▒▒▄▒▒▐░░
                      ░░▀▄▒▒▒▒▒▒▒▒▒▒▒░▒░▒░▒▄▒▒▒▒▌░░
                      ░░░░▀▄▒▒▒▒▒▒▒▒▒▒▄▄▄▀▒▒▒▒▄▀░░░      Wow.
                      ░░░░░░▀▄▄▄▄▄▄▀▀▀▒▒▒▒▒▄▄▀░░░░░
                      ░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▀▀░░░░░░░░

  ██████╗  ██████╗  ██████╗ ███████╗███╗   ███╗ █████╗  ██████╗███████╗
  ██╔══██╗██╔═══██╗██╔════╝ ██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝
  ██║  ██║██║   ██║██║  ███╗█████╗  ██╔████╔██║███████║██║     ███████╗
  ██║  ██║██║   ██║██║   ██║██╔══╝  ██║╚██╔╝██║██╔══██║██║     ╚════██║
  ██████╔╝╚██████╔╝╚██████╔╝███████╗██║ ╚═╝ ██║██║  ██║╚██████╗███████║
  ╚═════╝  ╚═════╝  ╚═════╝ ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝
"))
    (when (and (display-graphic-p)
               (stringp fancy-splash-image)
               (file-readable-p fancy-splash-image))
      (let ((image (create-image (fancy-splash-image-file))))
        (add-text-properties
         point (point) `(display ,image rear-nonsticky (display)))
        (save-excursion
          (goto-char point)
          (insert (make-string
                   (truncate
                    (max 0 (+ 1 (/ (- +doom-dashboard--width
                                      (car (image-size image nil)))
                                   2))))
                   ? ))))
      (insert (make-string (or (cdr +doom-dashboard-banner-padding) 0)
                           ?\n)))))

(setq +doom-dashboard-functions
  '(doom-dashboard-widget-doge-banner
    doom-dashboard-widget-shortmenu
    doom-dashboard-widget-loaded
    doom-dashboard-widget-footer))


;; [9]
;; [10]
;; [10]
;; [9]
;; [9]
(defun down-crementer (&optional stride)
  (interactive)
  (let ((current-number (thing-at-point 'number t)))
    (next-line)
    (while (thing-at-point 'number t)
      ;; TODO: should be bounds of number?
      (let ((bounds (bounds-of-thing-at-point 'symbol)))
        (setq current-number (1+ current-number))
       (save-excursion
          (delete-region (car bounds) (cdr bounds))
          (insert (number-to-string current-number))))
      ;; (print current-number)
      (next-line))))

(defun flyspell-visible()
  (interactive)
  (flyspell-region (window-start) (window-end)))

(defun flyspell-auto-correct-line()
  (interactive)
  (flyspell-region (line-beginning-position) (line-end-position))
  (flyspell-auto-correct-previous-word (point))
  (goto-last-change 0))

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

;; e.g. "nc chall.tw 12374" --> target = remote("chall.tw", 12374)
;; 52.198.317.2 12374
;; 52.198.317.2:12374
;; TODO: after pasting the nc line, have insert target remote just transform the
;; line and delete the other line
(defun insert-target-remote()
  (interactive)
  (let ((nc-line (split-string (thing-at-point 'line t)))
        (hostname nil)
        (port nil))
    (if (string-equal "nc" (car nc-line))
        (progn
          (setq hostname (nth 1 nc-line))
          (setq port (nth 2 nc-line)))
      (setq hostname (nth 0 nc-line))
      (setq port (nth 1 nc-line)))
    (beginning-of-line)
    (kill-line)
    (insert (concat "target = remote(\"" hostname "\", " port ")"))))

;; TODO no after function, e.g. convert target.sendlineafter to sendline or sendafter to send
(defun ghidra-get-gdb-breakpoint ()
  (interactive)
  (unless (or (= (char-before) 32)
              (= (point) (line-beginning-position)))
    (evil-backward-word-begin))
  (insert "b *0x")
  ;; (insert (concat "b *0x" (substring-no-properties (pop kill-ring))))
  (call-interactively #'evil-indent-line))

(defun gdb-get-breakpoint-str (breakpoint-type)
  "Return string of the form 'b foo.c:108'"
  (concat breakpoint-type " "
          (if (uniquify-buffer-base-name)
              (uniquify-buffer-base-name)
            (buffer-name)) ":"
          (number-to-string (line-number-at-pos))))

(defun gdb-set-fast-breakpoint ()
  "Insert breakpoint in ~/.gdbinit before line with the 'end #FBB' marker"
  (interactive)
  (let ((insert-br-cmd  "awk '/#BREAKPOINT_INSERT_MARKER/ { print \"  %s\"; print; next }1' ~/.gdbinit > ~/.gdbinit.tmp && cp ~/.gdbinit.tmp ~/.gdbinit")
        (breakpoint-type (if current-prefix-arg "tb" "b")))
    (shell-command
     (format insert-br-cmd (gdb-get-breakpoint-str breakpoint-type)))))

(defun get-rand-url ()
  (interactive)
  (let (start end result)
  (beginning-of-buffer)
  (re-search-forward "writeupqueue high priority")
  (setq start (point))
  (re-search-forward "^$")
  (setq end (point))
  (setq result (shell-command-on-region start end "grep \"^$((($RANDOM % 10) + 1))\""))
  (print result)

  (re-search-forward "Nice")
  (setq start (point))
  (re-search-forward "^$")
  (setq end (point))
  ;; (setq result (concat result (shell-command-on-region start end "grep \"$((($RANDOM % 10) + 1))\"")))
  ))

(defun toggle-org-checkbox ()
  (interactive)
  (save-excursion
    (back-to-indentation)
    (let ((cur-string nil)
          (start-point (point))
          (end-point nil))
      (end-of-line)
      (setq end-point (point))
      (while (looking-at-p "[[:blank:]]")
        (blank-char))
      (delete-trailing-whitespace (line-beginning-position) (line-end-position))
      (setq cur-string (buffer-substring-no-properties start-point end-point))
      (cond ((string-match-p (regexp-quote "- [ ]") cur-string) (replace-regexp (regexp-quote "- [ ]") "" nil start-point end-point))
            ((string-match-p (regexp-quote "- [X]") cur-string) (replace-regexp (regexp-quote "- [X]") "- [ ]" nil start-point end-point))
            ((string-match-p (regexp-quote "- [") cur-string) (replace-regexp (regexp-quote "- [") "- [ ]" nil start-point end-point))
            ((string-match-p (regexp-quote "-") cur-string) (replace-regexp (regexp-quote "-") "- [ ]" nil start-point end-point))
            (t (progn
                 (goto-char start-point)
                 (insert "- [ ] ")))))
    (delete-to-bol)))

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

(defun mu4e-jump-to-mail ()
  (interactive)
  (+workspace/new "mail")
  (if (member "mail" (+workspace-list-names))
      (progn
        (+workspace/switch-to "mail")
        (unless (derived-mode-p 'mu4e-main-mode 'mu4e-headers-mode)
          (mu4e))
        ;; (mu4e-alert-view-unread-mails)
        )
    (+workspace/new "mail")
    (mu4e)
    (delete-other-windows)))

(defun counsel-ffap-git ()
  (interactive)
  (require 'ffap)
  (let ((ivy-auto-select-single-candidate t))
    (counsel-git (ffap-string-at-point))))

(defun copy-file-basename-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (if (uniquify-buffer-base-name)
                        (uniquify-buffer-base-name)
                      (buffer-name)))))
    (when filename
      (kill-new filename)
      (message "%s" filename))))

(defun copy-file-fullname-to-clipboard (&optional linum)
  (interactive "P")
  (let ((filename (replace-regexp-in-string
                   (concat "^/home/" user-login-name "/\\.*") ""
                   (file-truename (buffer-file-name)))))
    (when linum
        (setq filename (concat filename ":" (number-to-string (line-number-at-pos)))))
    (kill-new filename)
    (message filename)))

  (defun projectile-ripgrep-filename ()
    "Search for the current filename"
    (interactive)
    (projectile-ripgrep (if (uniquify-buffer-base-name)
                            (uniquify-buffer-base-name)
                          (buffer-name))))

(defun add-minibuffer-ripgrep-keymap ()
  (define-key minibuffer-local-map (kbd "C-c C-p") (lambda ()
                                                     (interactive)
                                                     (minibuffer-insert "PRODUCE_")
                                                     (end-of-line))))

(defun projectile-ripgrep-custom ()
  (interactive)
  (minibuffer-with-setup-hook
      'add-minibuffer-ripgrep-keymap
    (call-interactively #'projectile-ripgrep)))

;;; eval-after-load configuration
(after! org
  (require 'org-mouse)
  (setq org-startup-indented t)
  (setq org-superstar-headline-bullets-list '("◎" "◉" "○" "✎" "†" "⁖" "■" "▷"))
  (setq org-todo-keywords
        (quote ((sequence "☛ TODO(t)" "↻ PENDING(p)" "|" "✔ DONE(d!)")
                (sequence "⚑ WAITING(w@/!)" "⚁ MAYBE(m)" "PROJECT(P@)" "|" "✘ CANCELLED(c@/!)"))))
  (setq org-fontify-whole-heading-line t)
  (setq org-todo-keyword-faces
        '(
          ("☛ TODO"  . (:inherit org-todo :foreground "red"))
          ("⚑ WAITING"  . (:inherit org-todo :foreground "purple"))
          ("⚁ MAYBE"  . (:inherit org-todo :foreground "chocolate"))
          ("↻ PENDING"  . (:inherit org-todo :foreground "orange"))
          ("PROJECT"  . (:inherit org-todo :foreground "steelblue"))
          ("✔ DONE"  . (:inherit org-todo :foreground "green2"))
          ("✘ CANCELED"  . shadow)
          ))
  (setq org-src-fontify-natively t)
  ;; Use middle dot instead of "-" list markers
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
  (add-hook! 'text-mode-hook 'turn-on-visual-line-mode)
  (add-to-list 'org-structure-template-alist
               '("el" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC"))
  (add-to-list 'org-structure-template-alist
               '("cs" "#+BEGIN_SRC c\n?\n#+END_SRC"))
  (add-to-list 'org-structure-template-alist
               '("cpp" "#+BEGIN_SRC c++\n?\n#+END_SRC"))
  (add-to-list 'org-structure-template-alist
               '("py" "#+BEGIN_SRC python\n?\n#+END_SRC"))
  (add-hook! org-mode
    (org-superstar-mode 1)
    (setq display-line-numbers nil)
    (auto-fill-mode -1)))

(after! mu4e
  (setq mu4e-maildir "~/Maildir"
        mu4e-attachment-dir "~/Maildir/.attachments"
        mu4e-get-mail-command "mbsync -a"
        mu4e-update-interval 60
        mu4e-change-filenames-when-moving t
        mu4e-compose-signature-auto-include nil
        mu4e-compose-dont-reply-to-self t
        mu4e-mu-binary "/usr/local/bin/mu"
        mu4e-maildirs-extension-count-command-format "/usr/local/bin/mu find %s --fields 'i' | wc -l")

  (setq message-send-mail-function 'message-send-mail-with-sendmail
        sendmail-program "/usr/bin/msmtp")

  (add-to-list 'mu4e-view-actions
               '("browser" . mu4e-action-view-in-browser) t)

  (defun mu4e-alert-update-mail-count-interactive ()
    (interactive)
    (mu4e-alert-update-mail-count-modeline))

  (defun mu4e-update-mail-and-index-wrapper (&optional prefix)
    (interactive "P")
    (if prefix
        (mu4e-update-mail-and-index)
      (mu4e-update-mail-and-index t))))

(after! ivy
  (global-set-key "\C-s" 'counsel-grep-or-swiper)
  (global-set-key (kbd "C-S-s") 'isearch-forward)
  (global-set-key (kbd "C-S-r") 'isearch-backward)
  (define-key ivy-minibuffer-map (kbd "C-w") 'ivy-next-history-element)
  (define-key ivy-minibuffer-map (kbd "C-s") 'ivy-next-history-element)
  (define-key ivy-minibuffer-map (kbd "[") 'ivy-next-history-element)
  (define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line-or-history)
  (define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line-or-history)
  (define-key ivy-minibuffer-map (kbd "C-u") 'ivy-kill-line)
  (define-key ivy-minibuffer-map (kbd "C-c +") (lambda () (interactive) (minibuffer-insert " \\.c\\(pp\\)*$" t)))
  (define-key ivy-minibuffer-map (kbd "C-c h") (lambda () (interactive) (minibuffer-insert " \\.h\\(pp\\)*$" t)))
  (define-key ivy-minibuffer-map (kbd "C-c p") (lambda () (interactive) (minibuffer-insert " \\.py$" t)))
  (define-key ivy-minibuffer-map (kbd "C-c k") (lambda () (interactive) (minibuffer-munch)))
  (define-key ivy-minibuffer-map (kbd "C-c K") (lambda () (interactive) (minibuffer-crunch)))
(setq swiper-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-s") 'ivy-next-history-element)
    (define-key map (kbd "M-q") 'swiper-query-replace)
    (define-key map (kbd "C-l") 'swiper-recenter-top-bottom)
    (define-key map (kbd "C-'") 'swiper-avy)
    (define-key map (kbd "C-7") 'swiper-mc)
    (define-key map (kbd "C-c C-f") 'swiper-toggle-face-matching)
    map)))

(after! avy
  (setq avy-all-windows t))

(after! hydra
  (defhydra hydra-workspaces ()
    "workspaces"
    ("r" (call-interactively #'+workspace/rename) nil)
    ("d" (call-interactively #'+workspace/delete) nil)
    ("l" (call-interactively #'+workspace/cycle) nil :color blue)
    ("L" (call-interactively #'+workspace/cycle) nil)
    ("1" (+workspace/switch-to-or-create 0) nil)
    ("2" (+workspace/switch-to-or-create 1) nil)
    ("3" (+workspace/switch-to-or-create 2) nil)
    ("4" (+workspace/switch-to-or-create 3) nil)
    ("5" (+workspace/switch-to-or-create 4) nil)
    ("6" (+workspace/switch-to-or-create 5) nil)
    ("7" (+workspace/switch-to-or-create 6) nil)
    ("8" (+workspace/switch-to-or-create 7) nil)
    ("9" (+workspace/switch-to-or-create 8) nil))
  (setq hydra-workspaces/hint
        '(prog1 (eval
                 (hydra--format nil '(nil nil :hint nil)
                                (+workspace/display) hydra-workspaces/heads))))

  (defhydra hydra-git-gutter+ (global-map "C-c")
    "git-gutter+"
    ("n" git-gutter+-next-hunk "next")
    ("p" git-gutter+-previous-hunk "prev")
    ("v" git-gutter+-revert-hunk "revert")
    ("r" git-gutter+-revert-hunk "revert")
    ("=" git-gutter+-show-hunk "show")
    ("i" git-gutter+-show-hunk-inline-at-point "show inline")
    ("<tab>" git-gutter+-show-hunk-inline-at-point "show inline")
    ("m" git-messenger:popup-message "msgr")
    ("s" git-gutter+-stage-hunks "stage")
    ("S" magit-status "magit")
    ("c" git-gutter+-stage-and-commit "stage/commit" :color blue)
    ("C" git-gutter+-stage-and-commit-whole-buffer "stage/commit buffer" :color blue)
    ("M" (lambda () (interactive) (async-shell-command "git commit --amend --no-edit")) "gcan" :color blue)
    ("U" (lambda () (interactive) (async-shell-command "git add -u")) "git add -u" :color blue)
    ("l" recenter-top-bottom "recenter window")
    ("q" nil "quit"))

  (defhydra hydra-kill-buffer (global-map "C-x")
    "Kill Buffer"
    ("k" (lambda () (interactive) (kill-buffer nil)) "assassinate buffer" :color red)
    ("K" kill-buffer "kill buffer")
    ("d" kill-dired-buffers "kill dired buffers")
    ("x" (lambda () (interactive) (kill-buffer nil)) "assassinate buffer" :color blue)
    ("q" nil "quit"))

  (defhydra hydra-symbol-overlay ()
    "symbol-overlay"
    ("b" symbol-overlay-switch-backward "switch")
    ("c" symbol-overlay-save-symbol "copy")
    ("d" symbol-overlay-jump-to-definition "def")
    ("e" symbol-overlay-echo-mark "echo")
    ("f" symbol-overlay-switch-forward "switch")
    ("n" symbol-overlay-jump-next "next")
    ("N" symbol-overlay-jump-prev "prev")
    ("o" symbol-overlay-put "overlay")
    ("O" symbol-overlay-remove-all "unoverlay all")
    ("p" symbol-overlay-jump-prev "prev")
    ("r" symbol-overlay-query-replace "replace")
    ("R" symbol-overlay-rename "rename")
    ("s" symbol-overlay-isearch-literally "search")
    ("t" symbol-overlay-toggle-in-scope "scope")
    ("z" recenter-top-bottom "recenter")
    ("q" nil "quit" :color blue))

  (defhydra quick-file-hydra ()
    "Jump to file"
    ("d" (find-file "~/.doom.d/config.el") "doom config" :color blue)
    ("g" (find-file "~/.gdbinit") "gdbinit" :color blue)
    ("p" (find-file "~/.profile") ".profile" :color blue)
    ("p" (find-file "~/.pwn_funcs") "pwn_funcs" :color blue)
    ("s" (find-file "~/.system_aliases") "system_aliases" :color blue)
    ("f" (find-file "~/.system_funcs") "system_funcs" :color blue)
    ("z" (find-file "~/.zshrc") "zshrc" :color blue)
   ))

(after! ggtags
  (map! :map ggtags-navigation-map
        :nv (kbd "M-<up>") 'ggtags-navigation-previous-file
        :nv (kbd "M-<down>") 'ggtags-navigation-next-file)
  (define-key evil-normal-state-map (kbd "M-<left>") 'ggtags-prev-mark)
  (define-key evil-normal-state-map (kbd "M-<right>") 'ggtags-next-mark)
  (define-key ggtags-global-mode-map (kbd "o") 'ggtags-navigation-visible-mode)
  (add-hook! 'ggtags-global-mode-hook (when (and (buffer-live-p ggtags-global-last-buffer)
                                                   (with-current-buffer ggtags-global-last-buffer
                                                     (derived-mode-p 'ggtags-global-mode)))
                                          (ggtags-navigation-visible-mode t))
                                        (double-saber-mode)
                                        (setq-local double-saber-start-line 5)
                                        (setq-local double-saber-end-text "Global found")))

(after! ripgrep
  (map! :map ripgrep-search-mode-map
        :nv (kbd "M-<up>") 'compilation-previous-error
        :nv (kbd "M-<down>") 'compilation-next-error
        :nv "q" 'kill-current-buffer)
  (add-hook! 'ripgrep-search-mode-hook
    (double-saber-mode)
    (setq-local double-saber-start-line 5)
    (setq-local double-saber-end-text "Ripgrep finished") nil t))

(after! evil-snipe
  (setq evil-snipe-repeat-keys t)
  (setq evil-snipe-scope 'buffer)
  (setq evil-snipe-repeat-scope 'buffer))

(after! evil-embrace
  (add-hook! 'python-mode-hook
    (embrace-add-pair ?3 "p32(" ")")
    (embrace-add-pair ?6 "p64(" ")")
    (embrace-add-pair ?^ "u64(" ")")
    (embrace-add-pair ?i "int(" ")")
    (embrace-add-pair ?# "int(" ", 16)")
    (embrace-add-pair ?l "len(" ")")
    (embrace-add-pair ?s "str(" ")")
    (embrace-add-pair ?x "hexdump(" ")"))
  (add-hook! 'c-mode-common-hook
    (embrace-add-pair ?8 "/* " " */")
    (embrace-add-pair ?s "static_cast<>(" ")")))

(after! magit
  (transient-append-suffix 'magit-commit "c"
    '("n" "Amend --no-edit" (lambda () (interactive) (async-shell-command "git commit --amend --no-edit"))))
  (transient-append-suffix 'magit-commit "c"
    '("u" "Unlock" (lambda () (interactive) (async-shell-command "cd $(git rev-parse --show-toplevel) && rm .git/index.lock; rm .git/refs/heads/master.lock; rm .git/HEAD.lock"))))
  (transient-append-suffix 'magit-commit "c"
    '("g" "gsr" (lambda () (interactive)
                  (async-shell-command
                       "if ! git diff-index --quiet HEAD --; then git stash save; git pull --rebase; git stash pop; else git pull --rebase; fi"))))
  )

(after! nyan-mode
  (setq nyan-bar-length 8))

(after! yasnippet
  (push "~/.doom.d/snippets" yas-snippet-dirs)
  (defun check-expansion ()
    (save-excursion
      (if (looking-at "\\_>") t
        (backward-char 1)
        (if (looking-at "\\.") t
          (backward-char 1)
          (if (looking-at "->") t nil)))))

  (defun do-yas-expand ()
    (let ((yas/fallback-behavior 'return-nil))
      (yas/expand)))

  (defun tab-indent-or-complete ()
    (interactive)
    (if (minibufferp)
        (minibuffer-complete)
      (if (or (not yas/minor-mode)
              (null (do-yas-expand)))
          (if (check-expansion)
              (company-complete-common)
            (indent-for-tab-command)))))

  ;; TODO: Add autodetector for context, e.g. context.arch = 'amd64'
  ;; https://github.com/Gallopsled/pwntools-tutorial/blob/master/context.md
  (defun yas-get-bin-name ()
    (let ((bin (string-trim
                (shell-command-to-string
                 "file * | grep ELF | cut -d':' -f1 | grep -vE 'ld|libc'"))))
    (concat "\"./" bin "\"")))

  (defun yas-get-libc-name ()
    (car (directory-files "\./" nil "libc.*\.so" t)))

  (defun yas-get-ld-name ()
    (car (directory-files "\./" nil "ld.*\.so" t)))

  ;; Example:
  ;; libc = ELF("./libc.so.6")
  ;; ld = ELF("./ld-2.23.so")
  (defun yas-get-elfs ()
    (let ((libc-file (car (directory-files "\./" nil "libc.*\.so" t)))
          (ld-file (car (directory-files "\./" nil "ld.*\.so" t)))
          (outstring ""))
      (when libc-file
        (setq outstring (concat outstring "libc = ELF(\"./" libc-file "\")")))
      (when ld-file
        (unless (eq outstring "")
          (setq outstring (concat outstring "\n")))
        (setq outstring (concat outstring "ld = ELF(\"./" ld-file "\")")))
      outstring))

  ;; Return ld.path and elf.path if both exist, otherwise elf.path
  (defun yas-get-ld-elf-paths ()
    (let ((ld-file (car (directory-files "\./" nil "ld.*\.so" t))))
      (if ld-file
          "[ld.path, elf.path]"
        "elf.path")))

  ;; Example
  ;; , env={"LD_PRELOAD":libc.path}
  (defun yas-get-ld-preload ()
    (let ((libc-file (car (directory-files "\./" nil "libc.*\.so" t))))
      (when libc-file
        (concat ", env={\"LD_PRELOAD\":libc.path}"))))
  )

;; FIXME: need this to get parrot working
(after! doom-modeline
  (nyan-mode)
  (doom-modeline-def-modeline 'my/modeline
    '(bar matches buffer-info remote-host buffer-position parrot selection-info)
    '(misc-info minor-modes checker input-method buffer-encoding major-mode process vcs))
  (defun setup-custom-doom-modeline ()
    (doom-modeline-set-modeline 'my/modeline 'default))
  (add-hook! 'doom-modeline-mode-hook 'setup-custom-doom-modeline))

;; Save off custom settings to custom.el
(setq custom-file (expand-file-name "custom.el" doom-local-dir))
(load custom-file 'no-error 'no-message)

(put 'narrow-to-region 'disabled nil)
