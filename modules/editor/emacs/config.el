;;; config.el -*- lexical-binding: t; -*-

;; Basic configuration
(setq user-full-name "Matthieu Le brazidec (r3v2d0g)"
      user-mail-address "r3v2d0g@jesus.gg"

      doom-theme 'doom-outrun-electric
      doom-font "JetBrains Mono-12"
      doom-outrun-electric-brighter-modeline t
      doom-outrun-electric-brighter-comments t
      display-line-numbers-type t

      org-directory "~/org/")

;; Helpers
(load! "funcs.el")

;; Display column indicator
(add-hook! prog-mode #'display-fill-column-indicator-mode)
(setq-hook! prog-mode fill-column 100)

;; Local leader key
(setq! doom-localleader-key ",")

;; js-mode
(setq-hook! js-mode
  js-indent-level 2)

;; typescript-mode
(setq-hook! typescript-mode
  typescript-indent-level 2)

;; css-mode
(setq-hook! css-mode
  css-indent-offset 2)

;; web-mode
(setq-hook! web-mode
  js-indent-level 2
  ;; padding
  web-mode-part-padding nil
  web-mode-script-padding nil
  web-mode-style-padding nil
  ;; indent-offset
  web-mode-attr-indent-offset 2
  web-mode-code-indent-offset 2
  web-mode-css-indent-offset 2
  web-mode-markup-indent-offset 2)

;; rustic-mode
(setq-hook! rustic-mode
  rustic-indent-offset 4
  rustic-lsp-server 'rust-analyzer
  rustic-match-angle-brackets nil
  ;;lsp-enable-semantic-highlighting t
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
  lsp-rust-analyzer-completion-add-call-parenthesis t ;; TODO: investigate
  lsp-rust-analyzer-completion-add-call-argument-snippets t 
  lsp-rust-analyzer-completion-postfix-enable t ;; TODO: investigate
  lsp-rust-analyzer-call-info-full t ;; TODO: investigate
  lsp-rust-analyzer-proc-macro-enable t
  lsp-rust-analyzer-import-merge-behaviour "last"
  lsp-rust-analyzer-import-prefix "by_self")
  ;; TODO: lsp-rust-analyzer-inlay-type{,space-}-format
  ;; TODO: lsp-rust-analyzer-inlay-param{,space-}-format
  ;; TODO: lsp-rust-analyzer-inlay-chain{,space-}-format
(map! :map rustic-mode-map
      :localleader :prefix ("i" . "inlay hints")
      :desc "Toggle inlay hints"     "i" #'lsp-rust-analyzer-server-display-inlay-hints-toggle
      :desc "Toggle parameter hints" "p" #'lsp-rust-analyzer-display-parameter-hints-toggle
      :desc "Toggle chaining hints"  "c" #'lsp-rust-analyzer-display-chaining-hints-toggle)

;; python-mode
(setq!
  lsp-python-ms-executable (executable-find "python-language-server"))

;; org-mode
(use-package! ox-gfm :after-call org-export-dispatch)

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
;; (after! ledger-mode
;;   (map! :localleader
;;         :map ledger-mode-map
;;
;;         :desc "Add transaction" "q" #'add-ledger-transaction))
