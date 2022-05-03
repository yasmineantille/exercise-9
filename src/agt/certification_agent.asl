// Agent certification_agent in project exercise-9
// Relevant for Exercise 9 Task 2

/* Initial goals */
!start.

// Initialisation Plan
@start
+!start : .my_name(Me)
<-
  .print("Hello from ",Me);

  // Rating the Loyals
  +rating(sensing_agent_1, Me, quality, temperature(10), 0.8);
  +rating(sensing_agent_2, Me, quality, temperature(10), 0.8);
  +rating(sensing_agent_3, Me, quality, temperature(10), 0.8);
  +rating(sensing_agent_4, Me, quality, temperature(10), 0.8);

  // Rating the Rogues
  +rating(sensing_agent_5, Me, quality, temperature(1), -0.4);
  +rating(sensing_agent_6, Me, quality, temperature(1), -0.4);
  +rating(sensing_agent_7, Me, quality, temperature(1), -0.4);
  +rating(sensing_agent_8, Me, quality, temperature(1), -0.4);

  // Rating the Rogue Leader
  +rating(sensing_agent_9, Me, quality, temperature(-2), -0.8).


// The agent reacts when a new rating is added to its belief base by
// sending a reference to the rated agent
+rating(A, B, C, I, V): .my_name(Me)
<-
.send(A, tell, certified_reference(rating(A, B, C, I, V), signedBy(Me))).

{ include("$jacamoJar/templates/common-cartago.asl") }
