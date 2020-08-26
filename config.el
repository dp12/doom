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
(face-spec-set 'doom-dashboard-banner '((t (:inherit compilation-error))))

;;; System configuration
(menu-bar-mode 0)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(toggle-truncate-lines -1) ;; wrap long lines
(add-to-list 'auto-mode-alist '("\\.bin\\'" . hexl-mode))
(defadvice async-shell-command (around hide-async-windows activate)
  (save-window-excursion ad-do-it))

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
(setq lsp-enable-on-type-formatting nil)

;;; Leader keybindings
(map! :leader
      :desc "avy-kill-whole-line" "ak" #'avy-kill-whole-line
      :desc "avy-kill-region" "aK" #'avy-kill-region
      :desc "avy-copy-region" "ar" #'avy-copy-region
      :desc "avy-copy-line" "ay" #'avy-copy-line
      :desc "align-regexp" "ax" #'align-regexp
      :desc "evil-avy-goto-char-timer" "at" #'evil-avy-goto-char-timer
      :desc "bookmark jump" "bj" #'counsel-bookmark
      :desc "list bookmarks" "bl" #'list-bookmarks
      :desc "swap windows" "bx" #'ace-swap-window
      :desc "calc-yank-hex" "ch" #'calc-yank-hex
      :desc "cycle font" "cf" #'cycle-font-select
      :desc "save and comment" "ck" #'evilnc-comment-and-kill-ring-save
      :desc "centaur-tabs-mode" "ct" #'centaur-tabs-mode
      :desc "copy and comment" "cy" #'evilnc-copy-and-comment-lines
      :desc "dired-omit-mode" "d." #'dired-omit-mode
      :desc "dumb jump other" "dG" #'dumb-jump-go-other-window
      :desc "dumb jump" "dg" #'dumb-jump-go
      :desc "dired-jump" "dj" #'dired-jump
      :desc "kill dired" "dk" #'kill-dired-buffers
      :desc "delete-matching-lines" "dm" #'delete-matching-lines
      :desc "dumb jump quick look" "dl" #'dumb-jump-quick-look
      :desc "dired jump other" "do" #'dired-jump-other-window
      :desc "double-saber" "ds" #'double-saber-mode
      :desc "ediff-buffers" "ed" #'ediff-buffers
      :desc "evil-show-marks" "em" #'evil-show-marks
      :desc "evil-show-registers" "er" #'evil-show-registers
      :desc "dired-jump" "fj" #'dired-jump
      :desc "counsel-file-jump" "fJ" #'counsel-file-jump
      :desc "projectile-ripgrep-filename" "fN" #'projectile-ripgrep-filename
      :desc "find other file" "fo" #'ff-find-other-file
      :desc "find other file other window" "fO" #'ff-find-other-file-other-window
      :desc "frog-jump-buffer" "fb" #'frog-jump-buffer
      :desc "copy-file-basename-to-clipboard" "fn" #'copy-file-basename-to-clipboard
      :desc "fzf-git-files" "fz" #'fzf-git-files
      :desc "gdb-set-fast-breakpoint" "gd" #'gdb-set-fast-breakpoint
      :desc "counsel-ffap-git" "gff" #'counsel-ffap-git
      :desc "ggtags-find-reference" "gr" #'ggtags-find-reference
      :desc "hex-subtract" "h-" #'hex-subtract
      :desc "highlight-symbol-at-point" "h." #'highlight-symbol-at-point
      :desc "unhighlight-regexp" "hr" #'unhighlight-regexp
      :desc "hexl-mode" "hx" #'hexl-mode
      :desc "counsel-recentf" "if" #'counsel-recentf
      :desc "jump file" "jf" #'quick-file-hydra/body
      :desc "mu4e update mail cnt" "ma" #'mu4e-alert-update-mail-count-interactive
      :desc "evil-mc-mode" "mc" #'evil-mc-mode
      :desc "magit-find-file" "mf" #'magit-find-file
      :desc "mu4e-jump-to-mail" "mj" #'mu4e-jump-to-mail
      :desc "imenu-list" "ml" #'imenu-list-smart-toggle
      :desc "magit-file-popup" "mp" #'magit-file-dispatch
      :desc "mu4e-update-mail" "mu" #'mu4e-update-mail-and-index-wrapper
      :desc "toggle-org-checkbox" "oc" #'toggle-org-checkbox
      :desc "counsel-org-goto" "og" #'counsel-org-goto
      :desc "org-toggle-heading" "oh" #'org-toggle-heading
      :desc "quick calc" "qc" #'quick-calc
      :desc "quick run" "qr" #'quickrun
      :desc "counsel-rg" "rc" #'counsel-rg
      :desc "projectile-ripgrep-custom" "rg" #'projectile-ripgrep-custom
      :desc "parrot-start-animation" "rr" #'parrot-start-animation
      :desc "counsel-yank-pop" "ry" #'counsel-yank-pop
      :desc "sort-lines" "sl" #'sort-lines
      :desc "symbol overlay" "so" #'hydra-symbol-overlay/symbol-overlay-put
      :desc "search online" "sO" #'+lookup/online
      :desc "tabify" "tt" #'tabify
      :desc "untabify" "tu" #'untabify
      :desc "typing-of-emacs" "ty" #'typing-of-emacs
      )
(map!
 (:when (featurep! :editor multiple-cursors)
   :nv "C-n" #'evil-mc-make-and-goto-next-match
   :nv "C-p" #'evil-mc-make-and-goto-prev-match
   :nv "C-S-n" #'evil-mc-skip-and-goto-next-match
   :nv "C-S-p" #'evil-mc-skip-and-goto-prev-match))

;;; Spacemacs keybindings
(map! :leader
      :desc "open link" "al" #'link-hint-open-link ;; xo is illegal
      :desc "delete trailing whitespace" "dtw" #'delete-trailing-whitespace
      :desc "fill column" "tf" #'fci-mode
      :desc "magit-status" "gs" #'magit-status
      :desc "magit-blame" "gb" #'magit-blame-addition
      :desc "delete workspace" "ld" #'+workspace/delete
      :desc "new workspace" "ln" #'+workspace/new-with-name
      :desc "workspace" "lw" #'+workspace/display
      :desc "jump to line" "jl" #'evil-avy-goto-line
      :desc "narrow-to-defun" "nf" #'narrow-to-defun
      :desc "narrow-to-page" "np" #'narrow-to-page
      :desc "narrow-to-region" "nr" #'narrow-to-region
      :desc "narrow-widen" "nw" #'widen
      :desc "evil-iedit" "se" #'evil-iedit-state/iedit-mode
      :desc "truncate-lines" "tl" #'toggle-truncate-lines
      :desc "toggle-line-numbers" "tn" #'doom/toggle-line-numbers
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

(use-package! evil-fringe-mark
  :init
  ;; (global-evil-fringe-mark-mode)
  (setq-default left-fringe-width 16))

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
  (add-hook! 'parrot-click-hook 'mu4e-update-mail-and-index-wrapper)
  (define-key evil-normal-state-map (kbd "[r") 'parrot-rotate-prev-word-at-point)
  (define-key evil-normal-state-map (kbd "]r") 'parrot-rotate-next-word-at-point))

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

;; e.g. Yank 0x4526a into calc without having to change it to 16#4526a
(defun calc-yank-hex ()
  (interactive)
  (let* ((bounds (bounds-of-thing-at-point 'symbol))
         (hex-num (buffer-substring-no-properties (car bounds) (cdr bounds))))
    (setq hex-num (concat "16#" (string-remove-prefix "0x" hex-num)))
    (calc-enter-result 0 "grab" (math-read-expr hex-num))))

; libc base: 0xf7e1d000
; leak: 0xf7e7cca0
;; (string-to-number "f7e7cca0" 16)
;; (format "%x" 11)
(defun hex-subtract ()
  (interactive)
  (let ((hex-nums (buffer-substring-no-properties
                   (region-beginning) (region-end))))
    (setq hex-nums (remove-if-not (lambda (x)
                                    (and (> (length x) 2)
                                         (string= (substring x 0 2) "0x")))
                                  (split-string hex-nums)))
    (if (/= (length hex-nums) 2)
        (message "error: two hex numbers required")

      (setq hex-nums
            (mapcar
             (lambda (num)
               (string-to-number (string-remove-prefix "0x" num) 16)) hex-nums))
      (goto-char (region-end))
      (end-of-line)
      (back-to-indentation)
      (insert
       (concat "# offset: 0x" (format "%x" (abs (apply '- hex-nums))) "\n")))))

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
                 (insert "- [ ] ")))))))

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
  (setq org-bullets-bullet-list '("◎" "◉" "○" "✎" "†" "■"))
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
    ("l" (call-interactively #'+workspace/cycle) nil)
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

  (defun yas-insert-libc-name ()
    (car (directory-files "\./" nil "libc.*\.so" t))))

;; FIXME: need this to get parrot working
(after! doom-modeline
  (nyan-mode)
  (doom-modeline-def-modeline 'my/modeline
    '(bar matches buffer-info remote-host buffer-position parrot selection-info)
    '(misc-info minor-modes checker input-method buffer-encoding major-mode process vcs))
  (defun setup-custom-doom-modeline ()
    (doom-modeline-set-modeline 'my/modeline 'default))
  (add-hook! 'doom-modeline-mode-hook 'setup-custom-doom-modeline))
