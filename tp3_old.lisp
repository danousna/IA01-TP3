;
;     IA01 - TP3: SYSTEME EXPERT D'ORDRE 0+ - 
;     AUTOMNE 2017
;     LE GAUCHE VALENTIN & DANOUS NATAN
;


;;;     BASE DE FAITS

(setq *BF* (list
    '(= contenu theorique)
    '(= tailleSalleDuCours 100)
    '(= heure 11)
    '(= heureCouchage 1)))


;;;     BASE DE REGLES

(setq *BR* (list 
    '(R1 ((<= heure 10) (>= heureCouchage 0)) 
        (= etat fatigue)
    ) 
    '(R2 ((>= tailleSalleDuCours 50)) 
        (= salle amphi)
    ) 
    '(R3 ((= salle amphi) (= contenu theorique)) 
        (= type coursMagistral)
    ) 
    '(R4 ((= type coursMagistral) (= etat fatigue)) 
        (= volonte NIL)
    ) 
    '(R5 ((= volonte NIL)) 
        (= allerEnCours NIL))))


;;;     BUT

(setq *but* '(= allerEnCours NIL))


;;;     FONCTIONS OUTILS

; Premisses d'une regle.
(defun regle-premisse (regle)
    (cadr regle))

; Consequence d'une regle.
(defun regle-consequence (regle)
    (car (last regle)))

; Determiner les regles concluant sur un but determine.
(defun regles-candidates (but BR)
    (let (result)
        (dolist (regle BR (reverse result))
            (if (member (cadr but) (regle-consequence regle))
                (push regle result)))))

; Determiner si un fait appartient à la base de fait.
(defun connu? (fait BF)
    (if (member fait BF :test 'equal) T NIL))

; Comparer un fait a son premisse de meme type.
(defun eval-fait (fait premisse)
    (if (equal (car premisse) '=)
        (equal (nth 2 fait) (nth 2 premisse))
        (eval (list (car premisse) (nth 2 fait) (nth 2 premisse)))))

; Determiner si une règle est évaluable c'est à dire que le type est trouvable dans la BF.
(defun declenchable (premisse BF)
    (let ((OK NIL))
        (dolist (fait BF OK)
            (if (member (nth 1 premisse) fait :test 'equal)
                (setq OK (eval-fait fait premisse))))))


;;;     MOTEUR D'INFERENCE EN CHAINAGE ARRIERE

(defun verifier (but)
  (let (EC (BR *BR*) (BF *BF*) regleCourante)
    (loop
        (setq premissesValides T)
        (format t "BF_1: ~a~%" BF)
      (if (connu? but BF)
        (return "Vérifié !")
        (dolist (regle BR)
            (dolist (premisse (regle-premisse regle))
                (when (not (declenchable premisse BF))
                    (setq premissesValides NIL)))
            (if premissesValides
            (progn
                (push regle EC)
                (setq BR (remove regle BR))))))
      (format t "~%EC: ~a~%" EC)
      (if EC
        (progn
            (setq regleCourante (pop EC))
            (pushnew (regle-consequence regleCourante) BF))
        (return "Non vérifié")))))