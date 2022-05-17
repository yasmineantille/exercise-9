// Agent acting_agent in project exercise-9

/* Initial beliefs and rules */
role_goal(R, G) :-
	role_mission(R, _, M) & mission_goal(M, G).

can_achieve (G) :-
	.relevant_plans({+!G[scheme(_)]}, LP) & LP \== [].

i_have_plans_for(R) :-
	not (role_goal(R, G) & not can_achieve(G)).

/* Initial goals */
!start.

// Initialisation Plan
@start
+!start : true
<- 	.my_name(Me);
	.print("Hello from ",Me).

// Plan to achieve manifesting the air temperature using a robotic arm
+!manifest_temperature : .count(temperature(_)[source(_)],N) & N == 9
<-
  	.print("All measurements received");
	makeArtifact("converter", "tools.Converter", [], ConArtId);
	focus(ConArtId);

	makeArtifact("evaluator", "tools.SDBasedEvaluator", [], EvalArtId);
	focus(EvalArtId); 
	.findall([T,A], temperature(T)[source(A)], Temps);
  	evaluateDeviations(Temps, Deviations, MinDeviation, MaxDeviation);
	.my_name(MyName);

	!certification;

	// range is until 9-1 so 8
  	for (.range(I,0,8)) {
    	.nth(I, Deviations, D);
    	.nth(I, Temps, T);
    	convertExercise9(D, MinDeviation, MaxDeviation, -1, 1, Rating);
    	+rating(I, MyName, "accuracy", temperature(T), Rating); 
    	.print("Agent ", I, "with temperature ", T, " rated with ", Rating);
  	}

    .findall(r(Ag, temperature(BestValue), Rating), rating(Ag, _, "accuracy", temperature(BestValue), Rating), Ratings);
    .max(Ratings, r(_, temperature(BestValue), _));

	.print("Collected ratings", Ratings); 
	.print("Best value ", BestValue);

	convert(BestValue, -20, 200, 30, 830, RescaledValue);
	.print("Temperature value rescaled: ", RescaledValue);

	makeArtifact("robot", "wot.ThingArtifact", ["https://raw.githubusercontent.com/Interactions-HSG/example-tds/was/tds/leubot1.ttl"], RobotId);
  	setAPIKey("dbc245cc7ef7e3fe1a22b7ebae72a64f");
  	invokeAction("setWristAngle", ["value"], [RescaledValue]).

+organizationDeployed(OrgName, GroupName, SchemeName) : true <-
	.print("Joining deployed organisation: ", OrgName);
	lookupArtifact(OrgName, OrgArtId);
	focus(OrgArtId);
	lookupArtifact(GroupName, GrpArtId);
	focus(GrpArtId);
	!reasonAndAdoptRoles.

+!reasonAndAdoptRoles : role(R, _) & i_have_plans_for(R)
<-
  	.print("Adopting role: ", R);
	adoptRole(R).

+roleAvailable(R, OrgName): true
<-
  	lookupArtifact(OrgName, OrgArtId);
  	focus(OrgArtId);
  	!reasonAndAdoptRoles.


+obligation(Ag, MCond, committed(Ag,Mission,Scheme), Deadline) :
  .my_name(Ag)
  <-
  .print("My obligation is ", Mission);
  commitMission(Mission)[artifact_name(Scheme)];
  lookupArtifact(Scheme, SchemeArtId);
  focus(SchemeArtId).

+obligation(Ag, MCond, done(Scheme,Goal,Ag), Deadline) :
  .my_name(Ag)
  <-
  .print("My goal is ", Goal);
  !Goal[scheme(Scheme)];
  goalAchieved(Goal)[artifact_name(Scheme)].


+!certification : true
<-
	.findall(Agent,play(Agent,temperature_reader,_), Readers);
    for (.range(I,0,.length(Readers)-1)) {
		.nth(I, Readers, Agent);
		.print("Sending out request for certificate to ", Agent);
		.send(Agent, tell, getCertification);
    };

	.wait(2000).

/*
	The agent reacts when a new rating is added to its belief base by printing a relevant message
	A: The agent who has been rated
	B: The agent who interacted with agent A and provided the rating
	C: The term for which the rating was given (e.g. quality, honesty)
	I: The interaction to which agents A and B participated
	V: The rating. The range of the rating is [-1,1]
*/
+rating(A, B, C, I, V): true
<-
	.print("New ", C, " rating ", V, " for agent ", B, " who interacted with agent ", A, " in interaction ", I).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// Uncomment if you want to use the organization rules available in https://github.com/moise-lang/moise/blob/master/src/main/resources/asl/org-rules.asl
{ include("$moiseJar/asl/org-rules.asl") }

{ include("inc/skills-extended.asl") }
