;; Dysmenorrhea Diagnosis System - Rule File

;;; Main entry point
(defrule start
   =>
   (printout t "Welcome to the Dysmenorrhea Diagnosis System" crlf)
   (printout t "Please provide the following information:" crlf)
   (assert (patient (name "")))
   (assert (patient (age 0)))
   (assert (patient (menstrual-cycle "")))
   (assert (patient (symptoms "")))
   (assert (patient (diagnosis "Unknown")))
   (ask-patient-name))

(defrule ask-patient-name
   (declare (salience 10))
   (patient (name ""))
   =>
   (printout t "Patient's name: ")
   (bind ?name (read))
   (assert (patient (name ?name)))
   (ask-patient-age))

(defrule ask-patient-age
   (declare (salience 10))
   (patient (age 0))
   =>
   (printout t "Patient's age: ")
   (bind ?age (read))
   (assert (patient (age ?age)))
   (ask-menstrual-cycle))

(defrule ask-menstrual-cycle
   (declare (salience 10))
   (patient (menstrual-cycle ""))
   =>
   (printout t "How would you describe your menstrual cycle?" crlf)
   (printout t "1. Regular" crlf)
   (printout t "2. Irregular" crlf)
   (printout t "3. I don't know" crlf)
   (bind ?response (read))
   (if (eq ?response 1) then (assert (patient (menstrual-cycle "Regular")))
   else (if (eq ?response 2) then (assert (patient (menstrual-cycle "Irregular")))
   else (assert (patient (menstrual-cycle "Unknown")))))
   (ask-symptoms))

(defrule ask-symptoms
   (declare (salience 10))
   (patient (symptoms ""))
   =>
   (printout t "Do you experience any of the following symptoms during your menstrual period?" crlf)
   (printout t "1. Severe menstrual cramps" crlf)
   (printout t "2. Lower abdominal pain" crlf)
   (printout t "3. Back pain" crlf)
   (bind ?response (read))
   (if (eq ?response 1) then (assert (patient (symptoms "Severe menstrual cramps")))
   else (if (eq ?response 2) then (assert (patient (symptoms "Lower abdominal pain")))
   else (if (eq ?response 3) then (assert (patient (symptoms "Back pain")))
   else (assert (patient (symptoms "None")))))
   (diagnose-dysmenorrhea))

(defrule diagnose-dysmenorrhea
   (declare (salience 10))
   (patient (diagnosis "Unknown"))
   (patient (age ?age))
   (patient (menstrual-cycle ?cycle))
   (patient (symptoms ?symptoms))
   =>
   (if (and (>= ?age 18) (<= ?age 30) (eq ?cycle "Regular") (neq ?symptoms "None"))
       then
       (assert (patient (diagnosis "Possible Dysmenorrhea")))
       (printout t "Based on the information provided, it is possible that you have Dysmenorrhea." crlf)
       (printout t "Please consult a healthcare professional for a definitive diagnosis and treatment." crlf)
   else
       (assert (patient (diagnosis "No Dysmenorrhea")))
       (printout t "Based on the information provided, it is unlikely that you have Dysmenorrhea." crlf)
       (printout t "If you are experiencing severe symptoms, please consult a healthcare professional." crlf)
   )
   (assert (patient (completed yes)))
   (printout t crlf)
)

(defrule exit
   (declare (salience 0))
   (patient (completed yes))
   =>
   (printout t "Thank you for using the Dysmenorrhea Diagnosis System." crlf)
   (printout t "Goodbye!" crlf)
   (exit))
