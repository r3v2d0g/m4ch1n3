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

(defun documentation-box (box-size lines)
  (insert (concat "/* ┌" (make-string (- box-size 8) ?─) "┐ *\\"))
  (dolist (line lines)
    (newline)
    (insert (concat " * │ " line (make-string (- box-size (string-width line) 9) ?\s) "│ *")))
  (newline)
  (insert (concat "\\* └" (make-string (- box-size 8) ?─) "┘ */")))
(defun documentation-copyright ()
    (interactive)
    (documentation-box 100 '("Copyright (c) 2020"
                              "All Rights Reserved to Matthieu Le brazidec"
                              "Unauthorized copying of this file, via any medium is stricly prohibited"
                              "Proprietary and confidential")))
(defun documentation-mpl ()
  (interactive)
  (documentation-box 100 '(""
                            "This Source Code Form is subject to the terms of the Mozilla Public"
                            "License, v. 2.0. If a copy of the MPL was not distributed with this"
                            "file, You can obtain one at http://mozilla.org/MPL/2.0/."
                            "")))

(defun documentation-separator (text size)
  (interactive "sText:
nSize: ")
  (delete-trailing-whitespace (line-beginning-position) (line-end-position))
  (let* ((spaces (- display-fill-column-indicator-column (+ size 6)))
         (rem (mod spaces 2))
         (left (/ spaces 2))
         (right (+ left rem))
         (inner (- size (string-width text) 4))
         (irem (mod inner 2))
         (ileft (/ inner 2))
         (iright (+ ileft irem)))
    (insert (concat "/* " (make-string left ?\s)))
    (insert (concat "┌" (make-string (- size 2) ?─) "┐ "))
    (insert (concat (make-string right ?\s) "*\\"))
    (newline)

    (insert (concat " *" (make-string left ?\s)))
    (insert (concat " │ " (make-string ileft ?\s)))
    (insert text)
    (insert (concat (make-string iright ?\s) " │ "))
    (insert (concat (make-string right ?\s) "*"))

    (newline)
    (insert (concat "\\* " (make-string left ?\s)))
    (insert (concat "└" (make-string (- size 2) ?─) "┘"))
    (insert (concat (make-string right ?\s) " */"))))
