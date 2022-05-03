// Agent sensing_agent in project exercise-9

/* Initial beliefs and rules */

/* Initial goals */
!start.

// Initialisation Plan
@start
+!start : true
<-
	.my_name(Me);
	.print("Hello from ",Me).

// Plan to achieve reading the air temperature using a robotic arm
+!read_temperature : true <-
	.print("Mock temperature reading (Celcious): 12.3").

/*
	Relevant for Exercise 9 Task 2
	React to an event of a certified reference that includes a rating signed by
	and agent. The agent reacts by printing the certified reference.

	A: The agent who has been rated
	B: The agent who interacted with agent A and provided the rating
	C: The term for which the rating was given (e.g. quality, honesty)
	I: The interaction to which agents A and B participated
	V: The rating. The range of the rating is [-1,1]

	 Ag: The agent who signed the reference. Ag does not need be equal to A or B.
*/
+certified_reference(rating(A, B, C, I, V), signedBy(Ag)) : true
<-
	.print("Received a certified reference from ", Ag, ": New ", C, " rating ", V, " for agent ", B, " who interacted with agent ", A, " in interaction ", I).


{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// Uncomment if you want to use the organization rules available in https://github.com/moise-lang/moise/blob/master/src/main/resources/asl/org-rules.asl
//{ include("$moiseJar/asl/org-rules.asl") }

{ include("inc/skills-extended.asl") }
