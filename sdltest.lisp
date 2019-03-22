(ql:quickload :lispbuilder-sdl
              :silent t)
(defparameter width 500)
(defparameter height 500)
(defparameter bsize 15)
(defparameter *white* sdl:*white*)
(load "gol_algo.lisp")

(defun print-box (x y size color)
    (sdl:draw-box (sdl:rectangle-from-midpoint-* x y size size) :color color))

(defun gol-launcher ()
  (sdl:with-init ()
                 (sdl:window width height
                             :resizable t
                             :double-buffer t
                             :title-caption "Carnifex: Game Of Life")
                 (setf (sdl:frame-rate) 60)
                 (sdl:with-events ()
                                  (:quit-event () t)
                                  (:key-down-event ()
                                   (when (sdl:key-down-p :sdl-key-escape)
                                     (sdl:push-quit-event)))
                                  (:idle ()
                                   ;(sdl:clear-display (sdl:color))
                                   ;(sdl:draw-box (sdl:rectangle :x 200 :y 250 :w 15 :h 15) :color sdl:*white*)
                                   (when (sdl:mouse-left-p)
                                   ;; Draw the box having a center at the mouse x/y coordinates
                                    (print-box (sdl:mouse-x) (sdl:mouse-y) bsize *white*))
                                   ;; Redraw the display
                                    (sdl:update-display)))))
(gol-launcher)
