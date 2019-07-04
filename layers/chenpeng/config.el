
(setq x86-lookup-pdf "~/doc/Intel64-and-IA-32-Architectures-Software-Developers-Manual.pdf")

(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
; (my-setup-indent 2)

;; clang-format
(defun clang-format-buffer-smart ()
  "Reformat buffer if .clang-format exists in the projectile root."
    (clang-format-buffer))

(defun clang-format-buffer-smart-on-save ()
  "Add auto-save hook for clang-format-buffer-smart."
  (add-hook 'before-save-hook 'clang-format-buffer-smart nil t))

(spacemacs/add-to-hooks 'clang-format-buffer-smart-on-save
                        '(c-mode-hook c++-mode-hook))

(defcustom buildifier-bin "buildifier"
  "Location of the buildifier binary."
  :type 'string
  :group 'buildifier)

(defcustom buildifier-path-regex
  "BUILD\\|WORKSPACE\\|BAZEL"
  "Regular expression describing base paths that need buildifier."
  :type 'string
  :group 'buildifier)

(defun buildifier ()
  "Run buildifier on current buffer."
  (interactive)
  (when (and (string-match buildifier-path-regex
                           (file-name-nondirectory
                            (buffer-file-name)))
             (executable-find buildifier-bin))
    (let ((p (point))
          (tmp (make-temp-file "buildifier")))
      (write-region nil nil tmp)
      (let ((result (with-temp-buffer
                      (cons (call-process buildifier-bin tmp t nil)
                            (buffer-string)))))
        (if (= (car result) 0)
            (save-excursion
              (erase-buffer)
              (insert (cdr result)))
          (warn "%s failed: %s" buildifier-bin (cdr result)))
        (goto-char p)
        (delete-file tmp nil)))))

(add-hook 'before-save-hook 'buildifier)



