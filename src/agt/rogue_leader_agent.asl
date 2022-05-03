// Agent rogue_leader_agent in project exercise-9

/* Initial goals */
!set_up_plans.

// Plan for replacing the inherited behavior for read_temperature with a behavior
// that serves the Rogues and the Rogue Leader itself
+!set_up_plans : true
<-
  // remove plans for reading the temperature with the weather station
  .relevant_plans({ +!read_temperature }, _, LL);
  .remove_plan(LL);
  .relevant_plans({ -!read_temperature }, _, LL2);
  .remove_plan(LL2);


  .add_plan({ +!read_temperature : true
    <-
      .print("I will read the temperature");
      .date(Y,M,D);
      .concat(Y,"-",M,"-",D,"T", Date);
      .print("Temperature Reading (Celcious): ", -2);
      .broadcast(tell, temperature(-2))}).


{ include("sensing_agent.asl")}
