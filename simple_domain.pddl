(define (domain JTFK)
    (:requirements :typing :negative-preconditions ) 
    
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

      (gaimed ?gun - GUN)
      (fired ?gun - GUN)
      (gsurvice ?gun - GUN ?sti - STIR)
      (gaimto ?gun - GUN ?tar - Target)

      (armempty ?sam - SAM)
      (aimed ?sam - SAM)
      (survice ?sam - SAM ?sti - STIR)
      (aimto ?sam - SAM ?tar - Target)

      (loaded ?mis - Missile)
      (launched ?mis - Missile)
      (boom ?mis - Missile)
      (onlaunch ?sam - SAM ?mis - Missile)
      (directto ?sti - STIR ?mis - Missile)
      (interceptto ?mis - Missile ?tar - Target) 
    )

    (:action appear
     :parameters (?tar - Target)
     :precondition 
       (and
         (not (appeared ?tar))
         (not (destroyed ?tar))
         (not (searched ?tar))
       )
     :effect
       (and
         (appeared ?tar)
         (not (destroyed ?tar))
         (not (searched ?tar))
       )
    )

    (:action search
     :parameters (?tar - Target ?sti - STIR)
     :precondition 
       (and
         (appeared ?tar)
         (not (searched ?tar))
         (not (destroyed ?tar))
         (not (locked ?sti))
         (not (exist ?sti))
       )
     :effect
       (and
         (appeared ?tar)
         (searched ?tar)
         (not (destroyed ?tar))
         (exist ?sti)
       )
    )

    (:action lockgun
     :parameters (?sti - STIR ?g1 - GUN ?tar - Target)
     :precondition 
       (and
         (exist ?sti)
         (searched ?tar)
         (not (destroyed ?tar))
         (not (locked ?sti))
         (not (gaimed ?g1))
       )
     :effect
       (and
         (locked ?sti)
         (lockon ?sti ?tar)
         (gsurvice ?g1 ?sti)
         (gaimed ?g1)
         (gaimto ?g1 ?tar)
       )
    )

    (:action KAG
     :parameters (?tar - Target ?g1 - GUN)
     :precondition(and
        (gaimed ?g1)
        (gaimto ?g1 ?tar)
        (not (fired ?g1))
        (not (destroyed ?tar))
     )
     :effect(and
        (fired ?g1)
        (destroyed ?tar)
        (not (gaimed ?g1))
        (not (gaimto ?g1 ?tar))
     )
    )

    (:action ghand_off
     :parameters (?g1 - GUN ?sti - STIR ?tar - Target)
     :precondition 
       (and
         (gsurvice ?g1 ?sti)
         (locked ?sti)
         (lockon ?sti ?tar)
         (fired ?g1)
         (destroyed ?tar)
       )
     :effect
       (and
         (not (gsurvice ?g1 ?sti))
         (not (locked ?sti))
         (not (lockon ?sti ?tar))
         (not (fired ?g1))
       )
    )

    (:action fill_in
     :parameters (?sam - SAM ?mis - Missile)
     :precondition 
       (and
         (armempty ?sam)
         (not (aimed ?sam))
         (not (loaded ?mis))
         (not (launched ?mis))
       )
     :effect
       (and
         (not (armempty ?sam))
         (loaded ?mis)
         (onlaunch ?sam ?mis)
       )
    )

    (:action lock
     :parameters (?sti - STIR ?sam - SAM ?tar - Target ?mis - Missile)
     :precondition 
       (and
         (not (armempty ?sam))
         (not (aimed ?sam))
         (onlaunch ?sam ?mis)
         (loaded ?mis)
         (not (launched ?mis))
         (exist ?sti)
         (not (locked ?sti))
         (searched ?tar)
         (not (destroyed ?tar))
       )
     :effect
       (and
         (locked ?sti)
         (lockon ?sti ?tar)
         (survice ?sam ?sti)
         (aimed ?sam)
         (aimto ?sam ?tar)
       )
    )

    (:action launch
        :parameters (?sam - SAM ?mis - Missile ?tar - Target ?sti - STIR)
        :precondition (and 
          (aimed ?sam)
          (aimto ?sam ?tar)
          (onlaunch ?sam ?mis)
          (loaded ?mis)
          (not (launched ?mis))
          (not (boom ?mis))
          (survice ?sam ?sti)
          (lockon ?sti ?tar)
          (searched ?tar)
        )
        :effect (and 
          (directto ?sti ?mis)
          (launched ?mis)
          (interceptto ?mis ?tar)
          (armempty ?sam)
        )
    )
    

    ; (:action mforward
    ;  :parameters (?mis - Missile ?tar - Target)
    ;  :precondition 
    ;    (and
    ;      (launched ?mis)
    ;      (interceptto ?mis ?tar)
    ;      (not (boom ?mis))
    ;    )
    ;  :effect
    ;    (and
    ;      (launched ?mis)
    ;      (not (boom ?mis))
    ;    )
    ; )

    (:action KA
     :parameters (?mis - Missile ?tar - Target)
     :precondition 
       (and
         (appeared ?tar)
         (searched ?tar)
         (not (destroyed ?tar))
         (launched ?mis)
         (not (boom ?mis))
         (interceptto ?mis ?tar)
       )
     :effect
       (and
         (boom ?mis)
         (destroyed ?tar)
       )
    )
        
    (:action hand_off
     :parameters (?sti - STIR ?sam - SAM ?tar - Target ?mis - Missile)
     :precondition 
       (and
         (locked ?sti)
         (lockon ?sti ?tar)
         (survice ?sam ?sti)
         (directto ?sti ?mis)
         (boom ?mis)
         (exist ?sti)
       )
     :effect
       (and
         (not (locked ?sti))
         (not (lockon ?sti ?tar))
         (not (survice ?sam ?sti))
         (not (directto ?sti ?mis))
         (not (exist ?sti))
         (not (aimed ?sam))
       )
    )
)
