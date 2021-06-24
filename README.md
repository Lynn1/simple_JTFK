# simple_JTFK
a small pddl project

## scenario reference：
2013_基于多Agent舰艇协同防空智能规划研究_崔婧


## version 2021.06.24: 
`durative_domain.pddl` 
`durative_problem.pddl`

update `:action` to `:durative-action` (but without `:duration-inequalities` rules such as `:duration (>= ?duration 0) `) and add some numerical variables in `:functions` .

## planner tested: 

![plan_results](https://github.com/Lynn1/simple_JTFK/blob/main/result_durative/supported_planner_in_itSimple4.png?raw=true)

##### SGPlan 6(linux):

![plan_result_SGPlan6](https://github.com/Lynn1/simple_JTFK/blob/main/result_durative/sgplanpreview.png?raw=true)



## version 2021.06.21: 
`simple_domain.pddl` 
`simple_problem.pddl`

only containing the logic core part, tempol and numerical parts which need `:requirements :durative-actions` and `:requirements :fluents` support was removed.
itProject.xml is the itSIMPLE4.0-beta project file.

## planner tested: 

![plan_results](https://github.com/Lynn1/simple_JTFK/blob/main/result_simple/supported_planner_in_itSimple4.png?raw=true)

##### FFv2.3(linux):

![plan_result_FFv2.3](https://github.com/Lynn1/simple_JTFK/blob/main/result_simple/ffplanpreview.png?raw=true)





