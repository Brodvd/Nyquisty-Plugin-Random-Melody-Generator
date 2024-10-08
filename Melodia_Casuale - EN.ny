;nyquist plug-in
;version 4
;type generate
;name "Random Melody"

; Aggiungi semitoni alla melodia casuale
;control Gen "N. Notes" int "60 (Max)" 30 1 60
;control Choice "Type Of Generation" choice "Only Tones,Tones and Semitones" Only Tones

(defun random-note ()
  (let ((notes (if (equal Choice "Only Tones")
                   '(60 62 64 65 67 69 71 72) ; Note della scala di Do maggiore
                   '(60 61 62 63 64 65 66 67 68 69 70 71 72)))) ; Note della scala cromatica
    (nth (random (length notes)) notes)))

(defun random-duration ()
  (let ((durations '(0.5 1 1.5 2)))
    (nth (random (length durations)) durations)))

(defun midi-to-hz (midi-note)
  (* 440 (expt 2 (/ (- midi-note 69) 12.0))))

(defun generate-melody (length)
  (if (<= length 0)
      (osc 0 0)
      (seq (osc (hz-to-step (midi-to-hz (random-note))) (random-duration))
           (generate-melody (- length 1)))))

(generate-melody Gen)

