(define (problem JTFK_Problem)
    (:domain JTFK)
    (:objects
      sti1 - STIR
      gun1 - GUN
      sam1 - SAM
      mis1 - Missile
      mis2 - Missile
      tar1 - Target
      tar2 - Target
      tar3 - Target
    )
    (:init
      (armempty sam1)
    )
      
    (:goal
      (and
        (destroyed tar1)
        (destroyed tar2)
        (destroyed tar3)
        (boom mis1)
        (boom mis2)
        (not (locked sti1))
      )
    )
)
