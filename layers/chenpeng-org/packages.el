;;; packages.el --- chenpeng-org layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: ChenPeng <chenpeng@CPVM1604>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:


(defconst chenpeng-org-packages
  `(
    org
    ;;(org :location build-in)
    ;;; (org-pomodoro)
    (blog-admin :location (recipe
                           :fetcher github
                           :repo "codefalling/blog-admin"))
    )
)

(defun chenpeng-org/init-blog-admin ()
  (use-package blog-admin
    :defer t
    :commands blog-admin-start
    :init
    (progn
      ;; do your configuration here
      (setq blog-admin-backend-path "~/blog"
            blog-admin-backend-type 'hexo
            blog-admin-backend-path blog-admin-dir
            blog-admin-backend-new-post-with-same-name-dir nil
            blog-admin-backend-hexo-config-file "_config.yml"
      )
      (add-hook 'blog-admin-backend-after-new-post-hook 'find-file)
    )
  )
)


;; (defun chenpeng-org/post-init-org-pomodoro ()
;;   (progn
;;     ;;(add-hook 'org-pomodoro-finish-hook '(lambda () ()))
;;   ))
  
;;; packages.el ends here
