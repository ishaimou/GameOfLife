(ql:quickload :lispbuilder-sdl
              :silent t)
(defparameter width 800)
(defparameter height 600)
(defparameter bsize 10)
(defparameter *white* sdl:*white*)
(load "gol_algo.lisp")


(defun print-box (x y bsize color)
    (sdl:draw-box (sdl:rectangle-from-midpoint-*
                    (+ x (floor bsize 2)) 
                    (+ y (floor bsize 2)) bsize bsize)
                  :color color))

(defun print-matrix (matrix row column bsize)
  (sdl:clear-display sdl:*black*)
  (dotimes (i row)
    (dotimes (j column)
      (if (equal (aref matrix i j) 1)
          (print-box (+ 1 (* i bsize))
                     (+ 1 (* j bsize))
                     (- bsize (floor bsize 10))
                     *white*))))
  (sdl:update-display))

(defun gol-launcher ()
  (sdl:with-init ()
                 (sdl:window width height
                             :resizable t
                             :double-buffer t
                             :title-caption "Carnifex: Game Of Life")
                 (setf (sdl:frame-rate) 60)
                 ; Enable the keyboard repeat rate setting DELAY and INTERVAL to default values of SDL
                 (sdl:enable-key-repeat nil nil)
                 (sdl:with-events ()
                                  (:quit-event () t)
                                  ;; Redraw the screen when it has been modified outside (e.g window manager)
                                  (:video-expose-event ()
                                   (sdl:update-display))
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
                                    ;(sdl:update-display)
                                    ;(print (sdl:key-repeat-delay))
                                    ;(print (sdl:key-repeat-interval))
                                    (print-matrix matrix row column bsize)
                                    (gol-algo)
                                    ))))
(gol-launcher)
