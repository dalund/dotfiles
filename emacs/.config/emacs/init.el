;; The default is 800 kilobytes. Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

(require 'use-package-ensure) ;; Load use-package-always-ensure
(setq use-package-always-ensure t) ;; Always ensures that a package is installed
(setq package-archives '(("melpa" . "https://melpa.org/packages/") ;; Sets default package repositories
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/"))) ;; For Eat Terminal

(use-package emacs
  :custom
  (menu-bar-mode nil)         ;; Disable the menu bar
  (scroll-bar-mode nil)       ;; Disable the scroll bar
  (tool-bar-mode nil)         ;; Disable the tool bar
  ;;(inhibit-startup-screen t)  ;; Disable welcome screen

  (delete-selection-mode t)   ;; Select text and delete it by typing.
  (electric-indent-mode nil)  ;; Turn off the weird indenting that Emacs does by default.
  (electric-pair-mode t)      ;; Turns on automatic parens pairing

  (blink-cursor-mode nil)     ;; Don't blink cursor
  (global-auto-revert-mode t) ;; Automatically reload file and show changes if the file has changed

  ;;(dired-kill-when-opening-new-dired-buffer t) ;; Dired don't create new buffer
  ;;(recentf-mode t) ;; Enable recent file mode

  ;;(global-visual-line-mode t)           ;; Enable truncated lines
  ;;(display-line-numbers-type 'relative) ;; Relative line numbers
  (global-display-line-numbers-mode t)  ;; Display line numbers

  (mouse-wheel-progressive-speed nil) ;; Disable progressive speed when scrolling
  (scroll-conservatively 10) ;; Smooth scrolling
  ;;(scroll-margin 8)

  (tab-width 4)

  (make-backup-files nil) ;; Stop creating ~ backup files
  (auto-save-default nil) ;; Stop creating # auto save files
  :hook
  (prog-mode . (lambda () (hs-minor-mode t))) ;; Enable folding hide/show globally
  :config
  ;; Move customization variables to a separate file and load it, avoid filling up init.el with unnecessary variables
  (setq custom-file (locate-user-emacs-file "custom-vars.el"))
  (load custom-file 'noerror 'nomessage)
  :bind (
         ([escape] . keyboard-escape-quit) ;; Makes Escape quit prompts (Minibuffer Escape)
         )
  )

(use-package recentf
  :config 
  (recentf-mode t))
;; (use-package gruvbox-theme
;;   :config
;;   (load-theme 'gruvbox-dark-medium t)) ;; We need to add t to trust this package

(use-package catppuccin-theme)
(setq catppuccin-flavor 'frappe)
(catppuccin-reload)

(add-to-list 'default-frame-alist '(alpha-background . 90)) ;; For all new frames henceforth

(set-face-attribute 'default nil
                    ;; :font "JetBrains Mono" ;; Set your favorite type of font or download JetBrains Mono
                    :height 120
                    :weight 'medium)
;; This sets the default font on all graphical frames created after restarting Emacs.
;; Does the same thing as 'set-face-attribute default' above, but emacsclient fonts
;; are not right unless I also add this method of setting the default font.

;;(add-to-list 'default-frame-alist '(font . "JetBrains Mono")) ;; Set your favorite font
(setq-default line-spacing 0.12)

(use-package diminish)

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


(use-package nerd-icons
  :if (display-graphic-p))

(use-package nerd-icons-dired
  :hook (dired-mode . (lambda () (nerd-icons-dired-mode t))))

(use-package nerd-icons-ibuffer
  :hook (ibuffer-mode . nerd-icons-ibuffer-mode))

(use-package magit
  ;; :custom (magit-diff-refine-hunk (quote all)) ;; Shows inline diff
  :commands magit-status)

(use-package emacs
  :bind
  ("C-+" . text-scale-increase)
  ("C--" . text-scale-decrease)
  ("<C-wheel-up>" . text-scale-increase)
  ("<C-wheel-down>" . text-scale-decrease))

;; (use-package doom-modeline
;;   :init (doom-modeline-mode 1)
;;   :custom
;;   (doom-modeline-height 25)     ;; Sets modeline height
;;   (doom-modeline-bar-width 5)   ;; Sets right bar width
;;   (doom-modeline-persp-name t)  ;; Adds perspective name to modeline
;;   (doom-modeline-persp-icon t)) ;; Adds folder icon next to persp name



(use-package corfu																		   ;;
  ;; Optional customizations																   ;;
  :custom																				   ;;
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'				   ;;
  (corfu-auto t)                 ;; Enable auto completion								   ;;
  (corfu-auto-prefix 2)          ;; Minimum length of prefix for auto completion.		   ;;
  (corfu-popupinfo-mode t)       ;; Enable popup information								   ;;
  (corfu-popupinfo-delay 0.5)    ;; Lower popupinfo delay to 0.5 seconds from 2 seconds	   ;;
  (corfu-separator ?\s)          ;; Orderless field separator, Use M-SPC to enter separator ;;
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary					   ;;
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match				   ;;
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview					   ;;
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt								   ;;
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches				   ;;
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin									   ;;
  (completion-ignore-case t)																   ;;
  ;; Enable indentation+completion using the TAB key.									   ;;
  ;; `completion-at-point' is often bound to M-TAB.										   ;;
  (tab-always-indent 'complete)															   ;;
  (corfu-preview-current nil) ;; Don't insert completion without confirmation			   ;;
  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can			   ;;
  ;; be used globally (M-/).  See also the customization variable						   ;;
  ;; `global-corfu-modes' to exclude certain modes.										   ;;
  :init																					   ;;
  (global-corfu-mode))																	   ;;


(use-package nerd-icons-corfu
  :after corfu
  :init (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))


(use-package cape
  :after corfu
  :init
  ;; Add to the global default value of `completion-at-point-functions' which is
  ;; used by `completion-at-point'.  The order of the functions matters, the
  ;; first function returning a result wins.  Note that the list of buffer-local
  ;; completion fun
  ;; The functions that are added later will be the first in the list

  (add-to-list 'completion-at-point-functions #'cape-dabbrev) ;; Complete word from current buffers
  (add-to-list 'completion-at-point-functions #'cape-dict) ;; Dictionary completion
  (add-to-list 'completion-at-point-functions #'cape-file) ;; Path completion
  (add-to-list 'completion-at-point-functions #'cape-elisp-block) ;; Complete elisp in Org or Markdown mode
  (add-to-list 'completion-at-point-functions #'cape-keyword) ;; Keyword/Snipet completion

  ;; (add-to-list 'completion-at-point-functions #'cape-abbrev) ;; Complete abbreviation
  ;; (add-to-list 'completion-at-point-functions #'cape-history) ;; Complete from Eshell, Comint or minibuffer history
  ;; (add-to-list 'completion-at-point-functions #'cape-line) ;; Complete entire line from current buffer
  ;; (add-to-list 'completion-at-point-functions #'cape-elisp-symbol) ;; Complete Elisp symbol
  ;; (add-to-list 'completion-at-point-functions #'cape-tex) ;; Complete Unicode char from TeX command, e.g. \hbar
  ;; (add-to-list 'completion-at-point-functions #'cape-sgml) ;; Complete Unicode char from SGML entity, n.g., &alpha
  ;; (add-to-list 'completion-at-point-functions #'cape-rfc1345) ;; Complete Unicode char using RFC 1345 mnemonics
  )




(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package vertico
  :init
  (vertico-mode))


;; Configure directory extension.
(use-package vertico-directory
  :after vertico
  :ensure nil
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
              ("RET" . vertico-directory-enter)
              ("DEL" . vertico-directory-delete-char)
              ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(savehist-mode) ;; Enables save history mode

(use-package marginalia
  :after vertico
  :init
  (marginalia-mode))

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  :hook
  ('marginalia-mode-hook . 'nerd-icons-completion-marginalia-setup))

(use-package consult
  :bind
  (("C-x b" . consult-buffer))
  :custom
  (xref-show-xrefs-function 'consult-xref)
  )

(use-package embrace
  :ensure t)

(defun me/meow-insert-at-indentation ()
  (interactive)
  (meow-back-to-indentation)
  (meow-insert-mode))

(defun me/meow-insert-at-end ()
  (interactive)
  (end-of-line)
  (meow-insert-mode))

(defun me/meow-paste-before ()
  (interactive)
  (meow-open-above)
  (beginning-of-line)
  (meow-yank)
  (meow-normal-mode))

(defun me/meow-delete-char-or-region ()
  (interactive)
  (cond
   ((equal mark-active t)
    (delete-region (region-beginning) (region-end)))
   ((equal mark-active nil)
    (delete-char 1))))

(defun me/copy-line ()
  (interactive)
  (save-excursion
    (back-to-indentation)
    (kill-ring-save
     (point)
     (line-end-position)))
  (message "1 line copied"))

(defun me/meow-save ()
  (interactive)
  (cond
   ((org-at-heading-p)
    (org-copy-subtree))
   ((equal mark-active t)
    (meow-save))
   ((equal mark-active nil)
    (rr/copy-line))))

(defun me/ultra-scroll-up ()
  (interactive)
  (ultra-scroll-up (- (/ (window-pixel-height) 2) 30)))

(defun me/ultra-scroll-down ()
  (interactive)
  (ultra-scroll-down (- (/ (window-pixel-height) 2) 30)))


(defun meow-setup ()
  "Setup meow keys"
  (interactive)
  
  ;; (meow-define-keys 'sexp
  ;;   '("<escape>" . meow-normal-mode)
  ;;   '("l" . sp-forward-sexp)
  ;;   '("h" . sp-backward-sexp)
  ;;   '("j" . sp-down-sexp)
  ;;   '("k" . sp-up-sexp)
  ;;   '("N" . sp-backward-slurp-sexp)
  ;;   '("n" . sp-forward-slurp-sexp)
  ;;   '("b" . sp-forward-barf-sexp)
  ;;   '("B" . sp-backward-barf-sexp)
  ;;   '("u" . meow-undo))
  
  (defun ensure-meow-normal-mode ()
    "Ensure Meow is in normal mode. If not, switch to it."
    (interactive)
    (unless (eq meow--current-state 'normal)
      (meow-normal-mode)))

  (meow-motion-overwrite-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("h" . meow-left)
   '("l" . meow-right)
   '("`" . capitalize-dwim)
   '("<escape>" . ignore))

  (meow-define-keys 'motion
    '("C-c n" . meow-normal-mode))

  (meow-leader-define-key 
   '("/" . consult-ripgrep)
   '("fs" . save-buffer)
   )
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)

   `("X" . "M-x")

   ;; '("!j" . flycheck-next-error)
   ;; '("!k" . flycheck-previous-error)
   ;; '("!," . flycheck-display-error-at-point)
   ;; '("!." . flycheck-explain-error-at-point)

   '("|" . shell-command-on-region)

   '("=" . indent-region)
   '("\\" . indent-rigidly)
   
   '("~" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("(" . meow-sexp-mode)
   '(")" . meow-sexp-mode)

   '(":." . point-to-register)
   '(":," . jump-to-register)
   
   '("`" . capitalize-dwim)
   '("^^" . meow-motion-mode)

   '("&" . meow-query-replace-regexp)
   '("%" . meow-query-replace)

   '("a" . meow-append)
   '("A" . me/meow-insert-at-end)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)

   ;; g is the quick action key
   
   '("gb" . meow-pop-to-mark)
   '("gf" . meow-unpop-to-mark)
   '("gB" . pop-global-mark)
   
   '("gl" . meow-goto-line)
   '("gc" . avy-goto-char)
   '("gC" . avy-goto-char-timer)
   '("g:" . jump-to-register)
   '("gr" . xref-find-references)
   '("gR" . xref-find-references-and-replace)
   '("gd" . xref-find-definitions)
   '("gD" . xref-find-definitions-other-window)

   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . me/meow-insert-at-indentation)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)

   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-open-below)
   '("O" . meow-open-above)
   '("p" . meow-yank-pop)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-slection)

   ;; quote
   '("qa" . embrace-add)
   '("qc" . embrace-change)
   '("qd" . embrace-delete)
   '("q\"" . embrace-double-quotes)
   '("q'" .  embrace-single-quotes)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("'" . meow-pop-selection)
   '("z" . repeat)
   '("Z" . meow-repeat)
   '("<escape>" . meow-cancel-selection)))

;;;; Meow
(use-package meow
  :ensure t
  :custom
  (meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)

  (meow-use-cursor-position-hack t)
  (meow-use-clipboard t)
  (meow-goto-line-function 'cosult-goto-line)

  :config

  (add-to-list 'meow-mode-state-list '(vterm-mode . insert))
  (add-to-list 'meow-mode-state-list '(eshell-mode . insert))
  (add-to-list 'meow-mode-state-list '(mu4e-headers-mode . motion))
  (add-to-list 'meow-mode-state-list '(mu4e-view-mode . motion))
  (add-to-list 'meow-mode-state-list '(helpful-mode . normal))

  (setq meow-use-dynamic-face-color nil)
  (setq meow--kbd-delete-char "<deletechar>")
  (with-eval-after-load 'org
    (modify-syntax-entry ?@ "_" org-mode-syntax-table))

  (meow-setup)
  ;; (meow-setup-indicator)
  (meow-global-mode 1))

(use-package meow-tree-sitter
  :ensure t

  :after meow
  :config
  (meow-tree-sitter-register-defaults))


(use-package which-key
  :ensure nil ;; Don't install which-key because it's now built-in
  :init
  (which-key-mode 1)
  :diminish
  :custom
  (which-key-side-window-location 'bottom)
  (which-key-sort-order #'which-key-key-order-alpha) ;; Same as default, except single characters are sorted alphabetically
  (which-key-sort-uppercase-first nil)
  (which-key-add-column-padding 1) ;; Number of spaces to add to the left of each column
  (which-key-min-display-lines 6)  ;; Increase the minimum lines to display, because the default is only 1
  (which-key-idle-delay 0.8)       ;; Set the time delay (in seconds) for the which-key popup to appear
  (which-key-max-description-length 25)
  (which-key-allow-imprecise-window-fit nil)) ;; Fixes which-key window slipping out in Emacs Daemon


(use-package eglot
  :ensure nil
  :hook ((python-ts-mode python-mode) . eglot-ensure)
  :config 
  (add-to-list 'eglot-server-programs
               '(python-mode . ("basedpyright" "--flag=value"))
			   '(python-ts-mode . ("basedpyright")))
  )

;; (use-package flymake-ruff
;; :ensure t
;; :defines (python-mode . flymake-ruff-load)
;; (python-ts-mode . flymake-ruff-load)
;; (eglot-managed-mdode . flymake-ruff-load))

(use-package apheleia
  :ensure t
  :defines (apheleia-formatters apheleia-mode-alist)
  :hook (after-init . apheleia-global-mode)
  :config 
  (setf (alist-get 'python-mode apheleia-mode-alist) '(ruff-isort ruff))
  (setf (alist-get 'python-ts-mode apheleia-mode-alist) '(ruff-isort ruff)))


(use-package key-chord
  :config
  (setf key-chord-two-keys-delay 0.1)
  (key-chord-mode 1)
  (key-chord-define meow-insert-state-keymap "fd" #'meow-insert-exit))

(use-package eat
  :ensure t)


(use-package zig-mode
  :ensure t)

(use-package elm-mode
  :ensure t)

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))
;; Increase the amount of data which Emacs reads from the process
(setq read-process-output-max (* 1024 1024)) ;; 1mb
