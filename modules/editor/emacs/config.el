;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Matthieu Le brazidec (r3v2d0g)"
      user-mail-address "r3v2d0g@jesus.gg")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font "JetBrains Mono-12")

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-outrun-electric
      doom-outrun-electric-brighter-modeline t
      doom-outrun-electric-brighter-comments t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Local config
(load! "config.el" "~/emacs")

;; Helpers
(load! "funcs.el")

;; Display column indicator
(add-hook! prog-mode #'display-fill-column-indicator-mode)
(setq-hook! prog-mode fill-column 100)

;; js-mode
(setq-hook! js-mode
  js-indent-level 2)

;; web-mode
(setq-hook! web-mode
  js-indent-level 2
  web-mode-part-padding nil
  web-mode-script-padding nil
  web-mode-attr-indent-offset 2
  web-mode-markup-indent-offset 2
  web-mode-code-indent-offset 2)

;; rustic-mode
(setq-hook! rustic-mode
  rustic-lsp-server 'rust-analyzer
  rustic-match-angle-brackets nil
  lsp-enable-semantic-highlighting t
  ;; TODO: lsp-rust-analyzer-max-inlay-hint-length
  lsp-rust-analyzer-server-display-inlay-hints t
  lsp-rust-analyzer-display-parameter-hints t
  lsp-rust-analyzer-display-chaining-hints t
  lsp-rust-analyzer-cargo-watch-enable t
  lsp-rust-analyzer-cargo-watch-command "clippy"
  ;; TODO: lsp-rust-analyzer-cargo-all-targets
  ;; TODO: lsp-rust-analyzer-exclude-globs
  lsp-rust-analyzer-diagnostics-enable t
  lsp-rust-analyzer-diagnostics-enable-experimental t
  ;; TODO: lsp-rust-analyzer-diagnostics-disabled
  lsp-rust-analyzer-cargo-load-out-dirs-from-check t
  lsp-rust-analyzer-completion-add-call-parenthesis t ;; TODO: investigate
  lsp-rust-analyzer-completion-add-call-argument-snippets t 
  lsp-rust-analyzer-completion-postfix-enable t ;; TODO: investigate
  lsp-rust-analyzer-call-info-full t ;; TODO: investigate
  lsp-rust-analyzer-proc-macro-enable t
  lsp-rust-analyzer-import-merge-behaviour "last"
  lsp-rust-analyzer-import-prefix "by_self"
  ;; TODO: lsp-rust-analyzer-inlay-type{,space-}-format
  ;; TODO: lsp-rust-analyzer-inlay-param{,space-}-format
  ;; TODO: lsp-rust-analyzer-inlay-chain{,space-}-format
  )
(map! :map rustic-mode-map
      :localleader :prefix ("i" . "inlay hints")
      :desc "Toggle inlay hints"     "i" #'lsp-rust-analyzer-server-display-inlay-hints-toggle
      :desc "Toggle parameter hints" "p" #'lsp-rust-analyzer-display-parameter-hints-toggle
      :desc "Toggle chaining hints"  "c" #'lsp-rust-analyzer-display-chaining-hints-toggle)

;; Re-map evil newline keys
(map! :n "o" #'+default/newline-below
      :n "O" #'+default/newline-above)

;; Flycheck next/previous error
(map! :n "] e" #'flycheck-next-error
      :n "[ e" #'flycheck-previous-error)

;; Documentation commands
(map! :leader :prefix ("d" . "documentation")
      :desc "Copyright" "c" #'documentation-copyright
      :desc "MPL-2.0"   "p" #'documentation-mpl
      :desc "Section"   "s" #'documentation-section)

;; vterm commands
(map! :leader :prefix "o"
      :desc "Toggle vterm pop up"          "t" #'+vterm/toggle
      :desc "Open vterm in current window" "T" #'+vterm/here)

;; Snippets
(map! :n "C-c C-s" #'yas/exit-all-snippets)

;; ;;(load! "ledger.el")
;; ;;(load! "circe-color-nicks-modified.el")
;;
;; ;;(use-package! atomic-chrome
;; ;;  :config
;; ;;  (atomic-chrome-start-server))
;; ;;
;; ;;(use-package! ejc-sql
;; ;;  :config
;; ;;  (setq!
;; ;;   ejc-set-column-width-limit nil))
;; ;;(use-package! ejc-company
;; ;;  :config
;; ;;  (push 'ejc-company-backend company-backends)
;; ;;  (add-hook! ejc-sql-minor-mode
;; ;;             (cmd! (company-mode t))))
;;
;; ;;(use-package! ox-gfm
;; ;;  :after-call org-export-dispatch)
;;
;; (setq! +mu4e-mu4e-mail-path "~/email")
;; (set-email-account!
;;  "pm"
;;  '((mu4e-sent-folder      . "/pm/sent")
;;    (mu4e-drafts-folder    . "/pm/drafts")
;;    (mu4e-trash-folder     . "/pm/trash")
;;    (mu4e-refile-folder    . "/pm/all")
;;    (mu4e-attachment-dir   . "~/email/attachment")
;;    (smtpmail-smtp-user    . "r3v2d0g@jesus.gg")
;;    (smtpmail-smtp-server  . "127.0.0.1")
;;    (smtpmail-smtp-service . 1025))
;;  t)
;;
;; ;;(after! (mu4e gnutls)
;; ;;  (pushnew! gnutls-trustfiles "~/.mbsync-pm-bridge.crt")
;; ;;  (pushnew! mu4e-bookmarks
;; ;;            '(:name  "Inbox"
;; ;;              :key   ?i
;; ;;              :query "maildir:/INBOX AND NOT \"maildir:/All Mail\"")))
;; ;;(set-email-account!
;; ;; "Protonmail"
;; ;; '((mu4e-mail-path             . "/mnt/email")
;; ;;   (mu4e-mu-home               . "/mnt/email/.mu")
;; ;;   (mu4e-sent-folder           . "/Sent")
;; ;;   (mu4e-drafts-folder         . "/Drafts")
;; ;;   (mu4e-trash-folder          . "/Trash")
;; ;;   (mu4e-refile-folder         . "/All Mail")
;; ;;   (mu4e-attachment-dir        . "/mnt/email/.attachment")
;; ;;   (message-send-mail-function . smtpmail-send-it)
;; ;;   (smtpmail-smtp-server       . "127.0.0.1")
;; ;;   (smtpmail-smtp-service      . 1025)
;; ;;   (smtpmail-stream-type       . starttls)
;; ;;   (smtpmail-smtp-user         . "r3v2d0g@jesus.gg"))
;; ;; t)
;;
;; ;;(setq!
;; ;; tramp-terminal-type "tramp"
;; ;; tramp-default-method "ssh"
;; ;; tramp-default-host "d31ph1n3")
;;
;; (setq!
;;  auth-sources '("~/.authinfo.gpg")
;;
;;  ledger-reconcile-default-commodity "€"
;;
;;  ;;lsp-enable-semantic-highlighting t
;;
;;  org-journal-encrypt-journal t
;;
;;  +irc-defer-notifications 60)
;;
;; ;;(after! circe
;; ;;  (let ((table (circe-irc-handler-table)))
;; ;;    (irc-handler-add table "conn.connected" #'circe--irc-conn-connected)
;; ;;    (setq circe--irc-handler-table table))
;; ;;
;; ;;  (defun circe--irc-conn-connected (conn _event)
;; ;;    (irc-connection-put conn :cap-req (append (irc-connection-get conn :cap-req)
;; ;;                                              '("znc.in/self-message"))))
;; ;;  (add-hook!
;; ;;   'circe-query-mode-hook
;; ;;   #'turn-on-visual-line-mode)
;; ;;
;; ;;  (set-irc-server!
;; ;;   "irc.r3vd5u3d.network"
;; ;;   `(:tls t
;; ;;     :port 6697
;; ;;     :nick "r3v2d0g"
;; ;;     :pass irc-pass
;; ;;     :server-buffer-name "r3vd5u3d")))
;;
;; (map! "C-S-v" #'evil-paste-after)
;;
;; (map! :n "TAB" #'+fold/toggle)
;;
;; (map! :leader
;;
;;       ;;; <leader> o --- open
;;       (:prefix "o"
;;        ;;:desc "IRC"                          "i" #'=irc
;;        :desc "Ledger"                       "l" (cmd! (find-file "~/ledger/ledger.dat"))
;;        :desc "Toggle vterm pop up"          "t" #'+vterm/toggle
;;        :desc "Open vterm in current window" "T" #'+vterm/here
;;
;;        ;;; <leader> o o --- ~/org
;;        (:prefix ("o" . "~/org")
;;         :desc "~/org/books.org" "b" (cmd! (find-file "~/org/books.org"))
;;         :desc "~/org/links.org" "l" (cmd! (find-file "~/org/links.org"))))
;;
;;       ;;; <leader> d --- documentation
;;       (:prefix ("d" . "documentation")
;;        :desc "Copyright" "c" #'documentation-copyright
;;        :desc "MPL-2.0"   "p" #'documentation-mpl
;;        :desc "Separator" "s" #'documentation-separator))
;;
;; (after! ledger-mode
;;   (map! :localleader
;;         :map ledger-mode-map
;;
;;         :desc "Add transaction" "q" #'add-ledger-transaction))
