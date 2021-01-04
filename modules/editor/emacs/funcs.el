;;; ~/.doom.d/funcs.el -*- lexical-binding: t; -*-

(defun fetch-password (&rest params)
  (require 'auth-source)
  (let ((match (car (apply #'auth-source-search params))))
    (if match
        (let ((secret (plist-get match :secret)))
          (if (functionp secret)
              (funcall secret)
            secret))
      (error "Password not found for %S" params))))

(defun irc-pass (_server)
  (fetch-password :login "r3v2d0g" :machine "irc.r3vd5u3d.network" :port "6697"))

;; ┌────────────────────────────────────────────────────────────────────────────────────────────┐ ;;
;; │                                    LSP Toggle Commands                                     │ ;;
;; └────────────────────────────────────────────────────────────────────────────────────────────┘ ;;

(defun lsp-rust-analyzer-server-display-inlay-hints-toggle ()
  (interactive)
  (setq lsp-rust-analyzer-server-display-inlay-hints
        (not lsp-rust-analyzer-server-display-inlay-hints))
  (cond (lsp-rust-analyzer-server-display-inlay-hints
         (lsp-rust-analyzer-inlay-hints-mode 1)
         (message "Inlay hints enabled"))
        (t
         (lsp-rust-analyzer-inlay-hints-mode -1)
         (message "Inlay hints disabled"))))

(defun lsp-rust-analyzer-display-parameter-hints-toggle ()
  (interactive)
  (setq lsp-rust-analyzer-display-parameter-hints
        (not lsp-rust-analyzer-display-parameter-hints))
  (if lsp-rust-analyzer-display-parameter-hints
      (message "Parameter hints enabled")
    (message "Parameter hints disabled")))

(defun lsp-rust-analyzer-display-chaining-hints-toggle ()
  (interactive)
  (setq lsp-rust-analyzer-display-chaining-hints
        (not lsp-rust-analyzer-display-chaining-hints))
  (if lsp-rust-analyzer-display-chaining-hints
      (message "Chaining hints enabled")
    (message "Chaining hints disabled")))

;; ┌────────────────────────────────────────────────────────────────────────────────────────────┐ ;;
;; │                                     Copyright Commands                                     │ ;;
;; └────────────────────────────────────────────────────────────────────────────────────────────┘ ;;

(defun documentation-mpl ()
  (interactive)
  (documentation-box
   100 0
   '(""
     "This Source Code Form is subject to the terms of the Mozilla Public"
     "License, v. 2.0. If a copy of the MPL was not distributed with this"
     "file, You can obtain one at http://mozilla.org/MPL/2.0/."
     "")
   nil))

(defun documentation-copyright ()
  (interactive)
  (documentation-box
   100 0
   '("Copyright (c) 2020"
     "All Rights Reserved to Matthieu Le brazidec"
     "Unauthorized copying of this file, via any medium is stricly prohibited"
     "Proprietary and confidential")
   nil))

;; ┌────────────────────────────────────────────────────────────────────────────────────────────┐ ;;
;; │                               Documentation Section Command                                │ ;;
;; └────────────────────────────────────────────────────────────────────────────────────────────┘ ;;

(defun documentation-section (text size)
  (interactive "sText:
nSize: ")
  (delete-trailing-whitespace (line-beginning-position) (line-end-position))
  (documentation-box fill-column (- fill-column size 4) (list text) t))


;; ┌────────────────────────────────────────────────────────────────────────────────────────────┐ ;;
;; │                                 Documentation Box Helpers                                  │ ;;
;; └────────────────────────────────────────────────────────────────────────────────────────────┘ ;;

(defun documentation-box-start (len offset)
  (let ((start (cond ((eq major-mode 'rustic-mode) "/*")
                     ((eq major-mode 'emacs-lisp-mode) ";;")
                     (t "  ")))
        (end (cond ((eq major-mode 'rustic-mode) "*\\")
                   ((eq major-mode 'emacs-lisp-mode) ";;")
                   (t "  "))))
    (insert (concat start (make-string offset ?\s) " ┌"
                    (make-string (- len (* 2 offset) 8) ?─)
                    "┐ " (make-string offset ?\s) end))))

(defun documentation-box-line (len offset text center)
  (let* ((start (cond ((eq major-mode 'rustic-mode) " *")
                      ((eq major-mode 'emacs-lisp-mode) ";;")
                      (t "  ")))
         (end (cond ((eq major-mode 'rustic-mode) "*")
                    ((eq major-mode 'emacs-lisp-mode) ";;")
                    (t "  ")))

         (inner (- len (* 2 offset) 10 (string-width text)))
         (rem (if center (mod inner 2) 0))
         (left (if center (/ inner 2) 0))
         (right (if center (+ left rem) inner)))
    (insert (concat start (make-string offset ?\s) " │ "
                    (make-string left ?\s) text (make-string right ?\s)
                    " │ " (make-string offset ?\s) end))))

(defun documentation-box-end (len offset)
  (let ((start (cond ((eq major-mode 'rustic-mode) "\\*")
                     ((eq major-mode 'emacs-lisp-mode) ";;")
                     (t "  ")))
        (end (cond ((eq major-mode 'rustic-mode) "*/")
                   ((eq major-mode 'emacs-lisp-mode) ";;")
                   (t "  "))))
    (insert (concat start (make-string offset ?\s) " └"
                    (make-string (- len (* 2 offset) 8) ?─)
                    "┘ " (make-string offset ?\s) end))))

(defun documentation-box (len offset lines center)
  (documentation-box-start len offset)
  (dolist (line lines) (newline) (documentation-box-line len offset line center))
  (newline) (documentation-box-end len offset))
