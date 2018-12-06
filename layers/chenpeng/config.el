
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
