;;; cedar-mode.el --- Major mode for Cedar language syntax highlighting -*- lexical-binding: t; -*-

;;; Commentary:
;; Provides syntax highlighting for Cedar policy language files

;;; Code:

(require 'rx)

(defvar cedar-mode-syntax-table
  (let ((table (make-syntax-table)))
    ;; C-style comment for // comments
    (modify-syntax-entry ?/ ". 12" table)
    (modify-syntax-entry ?\n ">" table)
    table)
  "Syntax table for `cedar-mode'.")

(defconst cedar-font-lock-keywords
  `(
    ;; Effect keywords
    ,(regexp-opt '("permit" "forbid") 'words)
    
    ;; Operators
    ,(regexp-opt '("in" "has" "containsAll" "containsAny" 
                   "isIpv4" "isIpv6" "isLoopback" "isMulticast" 
                   "isInRange" "lessThan" "lessThanOrEqual" 
                   "greaterThan" "greaterThanOrEqual" 
                   "ip" "like" "decimal" "contains") 'words)
    
    ;; Scope and Condition Keywords
    (,(regexp-opt '("principal" "action" "resource" "context") 'words)
     . font-lock-preprocessor-face)
    
    ;; Conditional Keywords
    (,(regexp-opt '("unless" "when") 'words)
     . font-lock-keyword-face)
    
    ;; Template Keywords
    (,(regexp-opt '("?principal" "?resource") 'words)
     . font-lock-variable-name-face)
    
    ;; Strings
    '("\".*?\"" . font-lock-string-face)
    
    ;; Comments
    '("//.*$" . font-lock-comment-face)
  )
  "Syntax highlighting for Cedar mode.")

;;;###autoload
(define-derived-mode cedar-mode prog-mode "Cedar"
  "Major mode for editing Cedar policy language files."
  :syntax-table cedar-mode-syntax-table
  (setq-local comment-start "// ")
  (setq-local comment-end "")
  (setq-local font-lock-defaults 
              '(cedar-font-lock-keywords nil nil nil nil)))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.cedar\\'" . cedar-mode))

(provide 'cedar-mode)

;;; cedar-mode.el ends here