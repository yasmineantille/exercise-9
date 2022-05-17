// Agent rogue_agent in project exercise-9

/* Initial beliefs and rules */
// initially, the agent believes that it hasn't received any temperature readings
// gradually, the list will fill, e.g., received_readings([])
//received_readings([]).

/* Initial goals */
!set_up_plans.

// Plan for replacing the inherited behavior for read_temperature with a behavior
// that serves the Rogues and the Rogue Leader
+!set_up_plans : true
<-
  // remove plans for reading the temperature with the weather station
  .relevant_plans({ +!read_temperature }, _, LL);
  .remove_plan(LL);
  .relevant_plans({ -!read_temperature }, _, LL2);
  .remove_plan(LL2);

  // add a new plan for reading the temperature that doesn't require contacting the weather station
  // the agent will pick one of the first three temperature readings that have been broadcasted,
  // it will slightly change the reading, and boradcast it
  .add_plan({ +!read_temperature : temperature(Temp)[source(sensing_agent_9)] 
    <-
      .print("Temperature reading: ", Temp);
      .my_name(Rogue);
      +certified_reference(rating(sensing_agent_9, Rogue, quality, temperature(2), 1), signedBy(Rogue));

      .broadcast(tell, temperature(Temp)) });

  // add plan for reading temperature in case fewer than 5 readings have been received
  .add_plan({ +!read_temperature : true
    <-
    // wait for 2 sec and find all beliefs about received temperature readings
    .wait(2000);

    // try again to "read" the temperature
    !read_temperature }).

+getCertification[source(Sender)] :
   certified_reference(rating(A, B, C, I, V), signedBy(Ag))
   <-
    if (V >= 0) {
      .send(Sender, tell, certified_reference(rating(A, B, C, I, V), signedBy(Ag)))
   }.


{ include("sensing_agent.asl")}