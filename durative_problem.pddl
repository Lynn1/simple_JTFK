(define (problem durative_JTFK_Problem)
    (:domain durative_JTFK)
    (:objects
      sti1 - STIR
      sti2 - STIR
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
      (=(sti_range sti1) 50)
      (=(sti_angle sti1) 10)

      (=(tar_distance tar1) 80)
      (=(tar_distance tar2) 70) 
      (=(tar_distance tar3) 50)  
      (inrange tar3)
      (=(tar_angle tar1) 20)
      (=(tar_angle tar2) 20)
      (=(tar_angle tar3) 20)
      (=(tar_speed tar1) 10)
      (=(tar_speed tar2) 10)
      (=(tar_speed tar3) 10)
      (fly tar1)
      (fly tar2)
      (fly tar3)
      (= (mis_speed mis1) 10)
      (= (mis_speed mis2) 10)

    )
      
    (:goal
      (and
        (destroyed tar1)
        (destroyed tar2)
        (destroyed tar3)
        (boom mis1)
        (boom mis2)
        (not (locked sti1))
        (not (locked sti2))
      )
    )
)
