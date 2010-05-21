(setq inhibit-startup-message t) ;; Disable start up message
(server-start)

;; Set encoding to UTF-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
 
;; Useful key strokes
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-d" 'delete-region)
 
;; Anti Aliasing
;; (setq mac-allow-anti-aliasing t)
(setq mac-allow-anti-aliasing nil)
 
;; Frame title : set to buffer name
(setq frame-title-format "Emacs - %f ")
(setq icon-title-format "Emacs - %b")
 
;; Editor Preferences
;; (column-number-mode t) ;; Show column numbers
(tool-bar-mode nil) ;; Disable tool bar
(menu-bar-mode nil) ;; Disable menu bar
(scroll-bar-mode nil) ;; Disable scrollbar
(transient-mark-mode t) ;; Selection highlighting
(show-paren-mode t) ;; Highlight parens
(setq show-paren-style 'parentheses) ;; Shor parens
(blink-cursor-mode nil) ;; Disable blinking of cursor
(fset 'yes-or-no-p 'y-or-n-p) ;; Alias Y and N
(setq message-log-max 100) ;; Set log buffer size
;; (resize-minibuffer-mode 1) ;; Resize buffer depending on text
(follow-mode t) ;; Easier editing of longs files
(setq search-highlight t) ;; Highlight search results
(setq kill-whole-line t) ;; Kill whole line
(setq backup-inhibited t) ;; Never backup
;; (setq column-number-mode t) ;; Show column numbers
;; (setq line-number-mode 1) ;; Show line numbers
(setq-default indent-tabs-mode nil) ;; Use spaces for tabs
;; (setq visible-bell t) ;; Visable bells
;; (kill-buffer "*scratch*") ;; Kill default scratch buffer
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)


(setq comint-input-ring-size 1024)
(iswitchb-mode t)

;; Local paths
(add-to-list 'load-path "~/.emacs.d/plugins")
(add-to-list 'load-path "~/.elisp")
(add-to-list 'load-path "~/.elisp/git")

;; Switch buffer
(global-set-key [f5] 'buffer-menu)

;; Save and load
(global-set-key [f2] 'save-buffer)
(global-set-key [f3] 'find-file)

;; Compile file
(global-set-key [f9] 'slime-compile-and-load-file)

;; Goto line
(global-set-key "\M-l" 'goto-line)

;; Go to other window
(global-set-key (kbd "<C-tab>") 'other-window)

;; Don't mix tabs and spaces
(setq-default indent-tabs-mode nil) 
  
;; Use "newline-and-indent" when you hit the Enter key so
;; you don't need to keep using TAB to align each line.
(global-set-key "\C-m" 'newline-and-indent)

;; Get rid of the <2> with duplicate file names
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; Replacing fundamental mode with text-mode as the default mode when a new buffer is open.
(setq default-major-mode 'text-mode)

;; Turn auto fill (automatic line wraping) and flyspell (spellchecking) on by default
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-flyspell)

 
;; ASpell And FlySpell
(setq ispell-program-name "/opt/local/bin/aspell")
(add-hook 'text-mode-hook
          '(lambda()
             (flyspell-mode)
             ))
 
;; Status bar
;; (display-time)
(setq column-number-mode t)
(setq line-number-mode t)

;; Visually show region
;;(setq transient-mark-mode t) 

;; Show line numbers
;; (setq line-number-mode t)

;; shift-arrow key moves to window in that direction
(windmove-default-keybindings)
