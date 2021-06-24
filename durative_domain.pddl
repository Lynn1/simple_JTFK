(define (domain durative_JTFK)
    (:requirements :strips :typing :negative-preconditions :numeric-fluents :durative-actions :duration-inequalities)
    
    (:types
      STIR - object
      Target - object
      GUN - object
      SAM - object
      Missile - object
    )

    (:predicates
      (exist ?sti - STIR)
      (locked ?sti - STIR)
      (lockon ?sti - STIR ?tar - Target)

      (appeared ?tar - Target)
      (searched ?tar - Target)
      (destroyed ?tar - Target)
      (fly ?tar - Target)
      (inrange ?tar - Target)

      (gaimed ?gun - GUN)
      (fired ?gun - GUN)
      (gsurvice ?gun - GUN ?sti - STIR)
      (gaimto ?gun - GUN ?tar - Target)

      (armempty ?sam - SAM)
      (aimed ?sam - SAM)
      (survice ?sam - SAM ?sti - STIR)
      (aimto ?sam - SAM ?tar - Target)
      ; (available ?sam - SAM)

      (loaded ?mis - Missile)
      (launched ?mis - Missile)
      (boom ?mis - Missile)
      (onlaunch ?sam - SAM ?mis - Missile)
      (directto ?sti - STIR ?mis - Missile)
      (interceptto ?mis - Missile ?tar - Target) 
    )

    (:functions
      ; Relatice distance
      (sti_range ?sti - STIR)
      (sti_angle ?sti - STIR)

      (tar_distance ?tar - Target)
      (tar_angle ?tar - Target)
      (tar_speed ?tar - Target)

      (mis_speed ?mis - Missile)
      (mis_distance ?mis - Missile)
    )

    (:durative-action appear
        :parameters (?tar - Target ?sti - STIR)
        :duration (= ?duration 1)
        :condition (and 
            (at start (and 
                (not (appeared ?tar))
                (inrange ?tar)
                (not (destroyed ?tar))
                (not (searched ?tar))
                ; (<= (tar_distance ?tar)(sti_range ?sti))
                ; (>= (tar_angle ?tar)(sti_angle ?sti))
            ))
        )
        :effect (and 
            (at end (and 
                (appeared ?tar)
                (not (destroyed ?tar))
                (not (searched ?tar))
            ))
        )
    )
    
    ; (:action appear
    ;  :parameters (?tar - Target ?sti - STIR)
    ;  :precondition 
    ;    (and
    ;      (not (appeared ?tar))
    ;      (not (destroyed ?tar))
    ;      (not (searched ?tar))
    ;      (<= (tar_distance ?tar)(sti_range ?sti))
    ;      (>= (tar_angle ?tar)(sti_angle ?sti))
    ;    )
    ;  :effect
    ;    (and
    ;      (appeared ?tar)
    ;      (not (destroyed ?tar))
    ;      (not (searched ?tar))
    ;    )
    ; )

    ;:duration (>= ?duration 0) 
    (:durative-action moveinrange
        :parameters (?tar - Target ?sti - STIR)
        :duration (= ?duration (/ (- (tar_distance ?tar) (sti_range ?sti)) (tar_speed ?tar)))
        :condition (and 
            (at start
              (not (inrange ?tar))
              ; (< 50 (tar_distance ?tar))
            )
            (over all (and 
              (fly ?tar)
            ))
            ; (at end 
            ;   (>= 50 (tar_distance ?tar))
            ; )
        )
        :effect (and 
            (at end (and 
              (inrange ?tar)
              (assign (tar_distance ?tar) (sti_range ?sti))
            ))
        )
    )
    ; (:durative-action moveinrange
    ;     :parameters (?tar - Target ?sti - STIR)
    ;     :duration (= ?duration (/ (- (tar_distance ?tar) (sti_range ?sti)) (tar_speed ?tar)))
    ;     :condition (and 
    ;         ; (at start 
    ;         ;   (< 50 (tar_distance ?tar))
    ;         ; )
    ;         (over all (and 
    ;           (fly ?tar)
    ;         ))
    ;         ; (at end 
    ;         ;   (>= 50 (tar_distance ?tar))
    ;         ; )
    ;     )
    ;     :effect (and 
    ;         (at end (and 
    ;           (assign (tar_distance ?tar) (sti_range ?sti))
    ;         ))
    ;     )
    ; )
    
    ; (:durative-action forward
    ;     :parameters (?tar - Target)
    ;     :duration (= ?duration 2)
    ;     :condition (and 
    ;         (over all (and 
    ;           (not (destroyed ?tar))
    ;           (appeared ?tar)
    ;           ; (searched ?tar)
    ;           (fly ?tar)
    ;         ))
    ;     )
    ;     :effect (and 
    ;         (at end (and 
    ;           (decrease (tar_distance ?tar) (tar_speed ?tar))
    ;         ))
    ;     )
    ; )

    ; (:durative-action move
    ;     :parameters (?tar - Target)
    ;     :duration (= ?duration 8)
    ;     :condition (and 
    ;         (at start (and 
    ;         ))
    ;         (over all (and 
    ;         ))
    ;         (at end (and 
    ;         ))
    ;     )
    ;     :effect (and 
    ;         (at start (and 
    ;         ))
    ;         (at end (and 
    ;         ))
    ;     )
    ; )

    (:durative-action search
        :parameters (?tar - Target ?sti - STIR)
        :duration (= ?duration 1)
        :condition (and 
            (at start (and 
              (appeared ?tar)
              (not (searched ?tar))
              (not (destroyed ?tar))
              (not (locked ?sti))
              (not (exist ?sti))
            ))
        )
        :effect (and 
            (at end (and 
              (searched ?tar)
              (exist ?sti)
            ))
        )
    )
    ; (:action search
    ;  :parameters (?tar - Target ?sti - STIR)
    ;  :precondition 
    ;    (and
    ;      (appeared ?tar)
    ;      (not (searched ?tar))
    ;      (not (destroyed ?tar))
    ;      (not (locked ?sti))
    ;      (not (exist ?sti))
    ;    )
    ;  :effect
    ;    (and
    ;      (searched ?tar)
    ;      (exist ?sti)
    ;    )
    ; )

    (:durative-action lockgun
        :parameters (?sti - STIR ?g1 - GUN ?tar - Target)
        :duration (= ?duration 1)
        :condition (and 
            (at start (and 
              (exist ?sti)
              (searched ?tar)
              (not (destroyed ?tar))
              (not (locked ?sti))
              (not (gaimed ?g1))
            ))
        )
        :effect (and 
            (at end (and 
              (locked ?sti)
              (lockon ?sti ?tar)
              (gsurvice ?g1 ?sti)
              (gaimed ?g1)
              (gaimto ?g1 ?tar)
            ))
        )
    )
    

    ; (:action lockgun
    ;  :parameters (?sti - STIR ?g1 - GUN ?tar - Target)
    ;  :precondition 
    ;    (and
    ;      (exist ?sti)
    ;      (searched ?tar)
    ;      (not (destroyed ?tar))
    ;      (not (locked ?sti))
    ;      (not (gaimed ?g1))
    ;    )
    ;  :effect
    ;    (and
    ;      (locked ?sti)
    ;      (lockon ?sti ?tar)
    ;      (gsurvice ?g1 ?sti)
    ;      (gaimed ?g1)
    ;      (gaimto ?g1 ?tar)
    ;    )
    ; )

    (:durative-action KAG
        :parameters (?tar - Target ?g1 - GUN)
        :duration (= ?duration 1)
        :condition (and 
            (at start (and 
              (gaimed ?g1)
              (gaimto ?g1 ?tar)
              (not (fired ?g1))
              (not (destroyed ?tar))
            ))
        )
        :effect (and 
            (at end (and
              (fired ?g1)
              (destroyed ?tar)
              (not (gaimed ?g1))
              (not (gaimto ?g1 ?tar)) 
            ))
        )
    )
    
    ; (:action KAG
    ;  :parameters (?tar - Target ?g1 - GUN)
    ;  :precondition(and
    ;     (gaimed ?g1)
    ;     (gaimto ?g1 ?tar)
    ;     (not (fired ?g1))
    ;     (not (destroyed ?tar))
    ;  )
    ;  :effect(and
    ;     (fired ?g1)
    ;     (destroyed ?tar)
    ;     (not (gaimed ?g1))
    ;     (not (gaimto ?g1 ?tar))
    ;  )
    ; )

    (:durative-action ghand_off
        :parameters (?g1 - GUN ?sti - STIR ?tar - Target)
        :duration (= ?duration 1)
        :condition (and 
            (at start (and 
              (gsurvice ?g1 ?sti)
              (locked ?sti)
              (lockon ?sti ?tar)
              (fired ?g1)
              (destroyed ?tar)
            ))
        )
        :effect (and 
            (at end (and 
              (not (gsurvice ?g1 ?sti))
              (not (locked ?sti))
              (not (lockon ?sti ?tar))
              (not (fired ?g1))
            ))
        )
    )

    ; (:action ghand_off
    ;  :parameters (?g1 - GUN ?sti - STIR ?tar - Target)
    ;  :precondition 
    ;    (and
    ;      (gsurvice ?g1 ?sti)
    ;      (locked ?sti)
    ;      (lockon ?sti ?tar)
    ;      (fired ?g1)
    ;      (destroyed ?tar)
    ;    )
    ;  :effect
    ;    (and
    ;      (not (gsurvice ?g1 ?sti))
    ;      (not (locked ?sti))
    ;      (not (lockon ?sti ?tar))
    ;      (not (fired ?g1))
    ;    )
    ; )

    (:durative-action fill_in
        :parameters (?sam - SAM ?mis - Missile)
        :duration (= ?duration 1)
        :condition (and 
            (at start (and 
              (armempty ?sam)
              (not (aimed ?sam))
              (not (loaded ?mis))
              (not (launched ?mis))
              (not (boom ?mis))
            ))
        )
        :effect (and 
            (at end (and 
              (not (armempty ?sam))
              (loaded ?mis)
              (onlaunch ?sam ?mis)
            ))
        )
    )
    

    ; (:action fill_in
    ;  :parameters (?sam - SAM ?mis - Missile)
    ;  :precondition 
    ;    (and
    ;      (armempty ?sam)
    ;      (not (aimed ?sam))
    ;      (not (loaded ?mis))
    ;      (not (launched ?mis))
    ;      (not (boom ?mis))
    ;    )
    ;  :effect
    ;    (and
    ;      (not (armempty ?sam))
    ;      (loaded ?mis)
    ;      (onlaunch ?sam ?mis)
    ;    )
    ; )

    (:durative-action lock
        :parameters (?sti - STIR ?sam - SAM ?tar - Target ?mis - Missile)
        :duration (= ?duration 1)
        :condition (and 
            (at start (and 
              (not (armempty ?sam))
              (not (aimed ?sam))
              (onlaunch ?sam ?mis)
              (loaded ?mis)
              (not (launched ?mis))
              (exist ?sti)
              (not (locked ?sti))
              (searched ?tar)
              (not (destroyed ?tar))
            ))
        )
        :effect (and 
            (at end (and 
              (locked ?sti)
              (lockon ?sti ?tar)
              (survice ?sam ?sti)
              (aimed ?sam)
              (aimto ?sam ?tar)
            ))
        )
    )
    

    ; (:action lock
    ;  :parameters (?sti - STIR ?sam - SAM ?tar - Target ?mis - Missile)
    ;  :precondition 
    ;    (and
    ;      (not (armempty ?sam))
    ;      (not (aimed ?sam))
    ;      (onlaunch ?sam ?mis)
    ;      (loaded ?mis)
    ;      (not (launched ?mis))
    ;      (exist ?sti)
    ;      (not (locked ?sti))
    ;      (searched ?tar)
    ;      (not (destroyed ?tar))
    ;    )
    ;  :effect
    ;    (and
    ;      (locked ?sti)
    ;      (lockon ?sti ?tar)
    ;      (survice ?sam ?sti)
    ;      (aimed ?sam)
    ;      (aimto ?sam ?tar)
    ;    )
    ; )

    (:durative-action launch
        :parameters (?sam - SAM ?mis - Missile ?tar - Target ?sti - STIR)
        :duration (= ?duration 1)
        :condition (and 
            (at start (and
              (aimed ?sam)
              (aimto ?sam ?tar)
              (onlaunch ?sam ?mis)
              (loaded ?mis)
              (not (launched ?mis))
              (not (boom ?mis))
              (survice ?sam ?sti)
              (lockon ?sti ?tar)
              (searched ?tar)
              (fly ?tar)              
            ))
        )
        :effect (and 
          (at start (not (fly ?tar)))
            (at end (and
              (directto ?sti ?mis)
              (launched ?mis)
              ; (interceptto ?mis ?tar)
              (armempty ?sam)
            ))
        )
    )
    
    ; (:action launch
    ;     :parameters (?sam - SAM ?mis - Missile ?tar - Target ?sti - STIR)
    ;     :precondition (and 
    ;       (aimed ?sam)
    ;       (aimto ?sam ?tar)
    ;       (onlaunch ?sam ?mis)
    ;       (loaded ?mis)
    ;       (not (launched ?mis))
    ;       (not (boom ?mis))
    ;       (survice ?sam ?sti)
    ;       (lockon ?sti ?tar)
    ;       (searched ?tar)
    ;       (fly ?tar)
    ;     )
    ;     :effect (and 
    ;       (directto ?sti ?mis)
    ;       (launched ?mis)
    ;       ; (interceptto ?mis ?tar)
    ;       (armempty ?sam)
    ;       (not (fly ?tar))
    ;     )
    ; )

    (:durative-action mforward
        :parameters (?mis - Missile ?tar - Target)
        :duration (= ?duration (/ (tar_distance ?tar) (mis_speed ?mis)))
        :condition (and 
            (at start (and 
              (launched ?mis)
              (not (boom ?mis))
              (searched ?tar)
              (not (destroyed ?tar))
            ))
        )
        :effect (and 
            (at end (and 
              (interceptto ?mis ?tar)
            ))
        )
    )

    ; (:action mforward
    ;  :parameters (?mis - Missile ?tar - Target)
    ;  :precondition 
    ;    (and
    ;      (launched ?mis)
    ;     ;  (interceptto ?mis ?tar)
    ;      (not (boom ?mis))
    ;      (searched ?tar)
    ;      (not (destroyed ?tar))
    ;    )
    ;  :effect
    ;    (and
    ;      (launched ?mis)
    ;      (interceptto ?mis ?tar)
    ;      (not (boom ?mis))
    ;    )
    ; )

    (:durative-action KA
        :parameters (?mis - Missile ?tar - Target)
        :duration (= ?duration 1)
        :condition (and 
            (at start (and 
              (appeared ?tar)
              (searched ?tar)
              (not (destroyed ?tar))
              (launched ?mis)
              (not (boom ?mis))
              (interceptto ?mis ?tar)
            ))
        )
        :effect (and 
            (at end (and 
              (boom ?mis)
              (destroyed ?tar)
            ))
        )
    )
  
    ; (:action KA
    ;  :parameters (?mis - Missile ?tar - Target)
    ;  :precondition 
    ;    (and
    ;      (appeared ?tar)
    ;      (searched ?tar)
    ;      (not (destroyed ?tar))
    ;      (launched ?mis)
    ;      (not (boom ?mis))
    ;      (interceptto ?mis ?tar)
    ;    )
    ;  :effect
    ;    (and
    ;      (boom ?mis)
    ;      (destroyed ?tar)
    ;    )
    ; )

    (:durative-action hand_off
        :parameters (?sti - STIR ?sam - SAM ?tar - Target ?mis - Missile)
        :duration (= ?duration 1)
        :condition (and 
            (at start (and 
              (locked ?sti)
              (lockon ?sti ?tar)
              (survice ?sam ?sti)
              (directto ?sti ?mis)
              (boom ?mis)
              (exist ?sti)
            ))
        )
        :effect (and 
            (at end (and 
              (not (locked ?sti))
              (not (lockon ?sti ?tar))
              (not (survice ?sam ?sti))
              (not (directto ?sti ?mis))
              (not (exist ?sti))
              (not (aimed ?sam))
            ))
        )
    )
  
    ; (:action hand_off
    ;  :parameters (?sti - STIR ?sam - SAM ?tar - Target ?mis - Missile)
    ;  :precondition 
    ;    (and
    ;      (locked ?sti)
    ;      (lockon ?sti ?tar)
    ;      (survice ?sam ?sti)
    ;      (directto ?sti ?mis)
    ;      (boom ?mis)
    ;      (exist ?sti)
    ;    )
    ;  :effect
    ;    (and
    ;      (not (locked ?sti))
    ;      (not (lockon ?sti ?tar))
    ;      (not (survice ?sam ?sti))
    ;      (not (directto ?sti ?mis))
    ;      (not (exist ?sti))
    ;      (not (aimed ?sam))
    ;    )
    ; )
)
