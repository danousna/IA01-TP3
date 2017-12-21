;
;     IA01 - TP3: SYSTEME EXPERT D'ORDRE 0+ - 
;     AUTOMNE 2017
;     LE GAUCHE VALENTIN & DANOUS NATAN
;


;;;     BASE DE FAITS

; (defparameter *BF* (list
;     '(= contenu theorique)
;     '(= tailleSalleDuCours 100)
;     '(= heure 11)
;     '(= heureCouchage 1)))

; (defparameter *BF* (list
;     '(= lieuPresenceSoirPrecedent bar)
;     '(= tailleSalleDuCours 100)
;     '(= heure 11)))

; (defparameter *BF* (list
;     '(= natureRessourcesSuffidantes poly)
;     '(= travail regulier)))

(defparameter *BF* (list
    '(= caracteristiqueMedian moyen)
    '(= heure 12)
    '(= travail enGroupe)))


;;;     BASE DE REGLES

; (setq *BR* (list 
;     '(R1 ((<= heure 10) (>= heureCouchage 0)) (= etat fatigue)) 
;     '(R2 ((>= tailleSalleDuCours 50)) (= salle amphi)) 
;     '(R3 ((= salle amphi) (= contenu theorique)) (= type coursMagistral)) 
;     '(R4 ((= type coursMagistral) (= etat fatigue)) (= volonte NIL)) 
;     '(R5 ((= volonte NIL)) (= allerEnCours NIL))))

(defparameter *BR* (list         
    '(R1 ((= sortie PIC)) (>= heureCouchage 0))
    '(R2 ((= sortie evenementUTC)) (>= heureCouchage 0))
    '(R3 ((= sortie soiree)) (>= heureCouchage 1))
    '(R4 ((= lieuPresenceSoirPrecedent tremplin)) (= sortie evenementUTC))
    '(R5 ((= lieuPresenceSoirPrecedent estu)) (= sortie evenementUTC))
    '(R6 ((= lieuPresenceSoirPrecedent bar)) (= sortie soiree))
    '(R7 ((= lieuPresenceSoirPrecedent boiteDeNuit)) (= sortie soiree))
    '(R8 ((= lieuPresenceSoirPrecedent colocAmis)) (= sortie soiree))
    '(R9 ((= lieuPresenceSoirPrecedent culture)) (= sortie soiree))
    '(R10 ((= lieuPresenceSoirPrecedent chezSoi)) (= heureCouchage -23))
    '(R11 ((= natureRessourcesSuffisantes poly)) (= provenanceRessourcesSuffisantes UV))
    '(R12 ((= natureRessourcesSuffisantes slides)) (= provenanceRessourcesSuffisantes UV))
    '(R13 ((= natureRessourcesSuffisantes Moodle)) (= provenanceRessourcesSuffisantes UV))
    '(R14 ((= natureRessourcesSuffisantes Memorae)) (= provenanceRessourcesSuffisantes UV))
    '(R15 ((= natureRessourcesSuffisantes Mattermost)) (= provenanceRessourcesSuffisantes UV))
    '(R16 ((= natureRessourcesSuffisantes forumWeb)) (= provenanceRessourcesSuffisantes internet))
    '(R17 ((= natureRessourcesSuffisantes coursEnLigneHorsUTC)) (= provenanceRessourcesSuffisantes internet))
    '(R18 ((= natureRessourcesSuffisantes coursHorsLigneHorsUTC)) (= provenanceRessourcesSuffisantes profParticulier))
    '(R19 ((= provenanceRessourcesSuffisantes UV)) (= qualiteRessources suffisantes))
    '(R20 ((= provenanceRessourcesSuffisantes internet)) (= qualiteRessources suffisantes))
    '(R21 ((= provenanceRessourcesSuffisantes profParticulier)) (= qualiteRessources suffisantes))
    '(R22 ((= travail regulier)) (= autonomie importante))
    '(R23 ((= qualiteRessources suffisantes) (= autonomie importante)) (= volonte NIL))
    '(R24 ((= pedagogie pasStructuree)) (= natureContenu ininteressant))
    '(R25 ((= pedagogie diapoLus)) (= natureContenu ininteressant))
    '(R26 ((= pedagogie pasDynamique)) (= natureContenu ininteressant))
    '(R27 ((= passione pasDuTout)) (= natureContenu ininteressant))
    '(R28 ((= passione fortement)) (= resultatMedian excellent))
    '(R29 ((= passione fortement)) (= travailUV parSoiMeme))
    '(R30 ((= resultatMedian mediocre)) (= caracteristiqueUV abandon))
    '(R31 ((= ECTS 300)) (= caracteristiqueUV abandon))
    '(R32 ((= caracteristiqueMedian difficile)) (= resultatMedian mediocre))
    '(R33 ((= travailFourniMedian insuffisant)) (= resultatMedian mediocre))
    '(R34 ((= caracteristiqueMedian differentAnnales)) (= resultatMedian mediocre))
    '(R35 ((= passionne fortement)) (= travailUV parSoiMeme))
    '(R36 ((= natureContenu rencontreDansAutreUV)) (= travailUV parSoiMeme))
    '(R37 ((= passionne fortement)) (= resultatMedian excellent))
    '(R38 ((= travailFourniMedian important)) (= resultatMedian excellent))
    '(R39 ((= caracteristiqueMedian facile)) (= resultatMedian excellent))
    '(R40 ((= natureContenu rencontreDansAutreUV)) (= confiance importante))
    '(R41 ((= travailUV parSoiMeme)) (= confiance importante))
    '(R42 ((= resultatmedian excellent)) (= confiance importante))
    '(R43 ((= confiance importante)) (= volonte NIL))
    '(R44 ((= caracteristiqueUV imposee)) (= natureContenu initeressant))
    '(R45 ((= choixUV nonSatisfait)) (= caracteristiqueUV imposee))
    '(R46 ((= ECTS insuffisant)) (= caracteristiqueUV imposee))
    '(R47 ((= cursusPrecedent autre)) (= ECTS 300))
    '(R48 ((= diplome nonVoulu)) (= ECTS 300))
    '(R49 ((<= heure 10) (>= heureCouchage 0)) (= etat fatigue)) 
    '(R50 ((>= tailleSalleDuCours 50)) (= salle amphi)) 
    '(R51 ((= salle amphi) (= contenu theorique)) (= type coursMagistral)) 
    '(R52 ((= type coursMagistral) (= etat fatigue)) (= volonte NIL)) 
    '(R53 ((= volonte NIL)) (= allerEnCours NIL))
    ))


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

; Determiner si un fait appartient ?la base de fait.
(defun connu? (fait BF)
    (if (member fait BF :test 'equal) T NIL))

; Comparer un fait a son premisse de meme type.
(defun eval-fait (fait premisse)
    (if (equal (car premisse) '=)
        (equal (nth 2 fait) (nth 2 premisse))
        (eval (list (car premisse) (nth 2 fait) (nth 2 premisse)))))

; Determiner si une r?le est ?aluable c'est ?dire que l'attribut est trouvable dans la BF.
(defun declenchable (premisse BF)
    (let ((OK NIL))
        (dolist (fait BF OK)
            (if (member (nth 1 premisse) fait :test 'equal)
                (setq OK (eval-fait fait premisse))))))


;;;     MOTEUR D'INFERENCE EN CHAINAGE ARRIERE

(defun verifier (but)
    (let (EC (BR *BR*) (BF *BF*) premissesValides regleCourante)
        (loop
            (format t "~%BF: ~a~%~%" BF)
            (if (connu? but BF)
                (return "Sechage !")
                (dolist (regle BR)
                    (dolist (premisse (regle-premisse regle))
                        (setq premissesValides T)
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
                (return "Non sechage")))))