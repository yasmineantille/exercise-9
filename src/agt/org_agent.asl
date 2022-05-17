// Agent org_agent in project exercise-8

/* Initial beliefs and rules */
org_name("lab_monitoring_org").
group_name("monitoring_team").
sch_name("monitoring_scheme").

has_enough_players_for(R) :-
  role_cardinality(R, Min, Max) &
  .count(play(_,R,_),NP) &
  NP >= Min.

/* Initial goals */
!start.

// Initialisation Plan
@start
+!start : org_name(OrgName) &
  group_name(GroupName) &
  sch_name(SchemeName)
<-
  .print("I will initialize an organization ", OrgName, " with a group ", GroupName, " and a scheme ", SchemeName, " in workspace ", OrgName); 
  makeArtifact("crawler", "tools.HypermediaCrawler", ["https://api.interactions.ics.unisg.ch/hypermedia-environment/was/581b07c7dff45162"], CrawlerId);
  searchEnvironment("Monitor Temperature", DocumentPath);
  .print("Document for the relationType Monitor Temperature found: ", DocumentPath);

  makeArtifact("repHelper", "tools.Helper", [], HelperId);

  makeArtifact(OrgName, "ora4mas.nopl.OrgBoard", [DocumentPath], OrgArtId);
  focus(OrgArtId);

  createGroup(GroupName, GroupName, GrpArtId);
  //createGroup(GroupName, "ora4mas.nopl.GroupBoard", GrpArtId);
  focus(GrpArtId);
  //makeArtifact(GroupName, "ora4mas.nopl.GroupBoard", ["src/org/auction-os.xml"], GrpArtId);
  createScheme(SchemeName, SchemeName, SchemeArtId);
  //createScheme(SchemeName, "ora4mas.nopl.SchemeBoard", SchemeArtId);
  focus(SchemeArtId);

  .broadcast(tell, organizationDeployed(OrgName, GroupName, SchemeName));
  // .broadcast(tell, organizationDeployed(OrgName));   // Would it be enough to just send the Org without Group?

  //?formationStatus(ok).
  !manage_formation(OrgName);
  addScheme(SchemeName)[artifact_id(GrpArtId)].

+!manage_formation(OrgName) : role(R,_) & not has_enough_players_for(R)
<-
  .broadcast(tell, roleAvailable(R, OrgName));
  .print("Looking for role: ", R);
  .wait(150);
  !manage_formation(OrgName).

+!manage_formation(OrgName) : formationStatus(ok)
<-
  .print("Group is well-formed.").


// Plan to add an organization artifact to the inspector_gui
// You can use this plan after creating an organizational artifact so that you can inspect it
+!inspect(OrganizationalArtifactId) : true
<-
  debug(inspector_gui(on))[artifact_id(OrganizationalArtifactId)].

// Plan to wait until the group managed by the Group Board artifact G is well-formed
// Makes this intention suspend until the group is believed to be well-formed
+?formationStatus(ok)[artifact_id(G)] : group(GroupName,_,G)[artifact_id(OrgName)]
<-
  .print("Waiting for group ", GroupName," to become well-formed")
  .wait({+formationStatus(ok)[artifact_id(G)]}).

// Plan to react on events about an agent Ag adopting a role Role defined in group GroupId
+play(Ag, Role, GroupId) : true
<-
  .print("Agent ", Ag, " adopted the role ", Role, " in group ", GroupId).


// Thanks to Marc discovered this in book
+obligation(Ag, MCond, committed(Ag,Mission,Scheme), Deadline) : true
<-
  getCurrentTimeMillisecs(Time);
  +missionStarted(Ag, Time).

+oblFulfilled(obligation(Ag, MCond, done(Scheme,Goal,Ag), Deadline)) :
  missionStarted(Ag,MissionStartTime) &
  reputation(Ag,Reputation)
<-
  .print("Reputation for Deadline ", Deadline, " and mission started ", MissionStartTime);
  computeReputationChange(MissionStartTime, Deadline, Reputation, NewReputation);
  -reputation(Ag, Reputation);
  +reputation(Ag, NewReputation);
  .print("Reputation of Agent ", Ag, " changed from ", Reputation, " to ", NewReputation).


// Additional behavior
{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// Uncomment if you want to use the organization rules available in https://github.com/moise-lang/moise/blob/master/src/main/resources/asl/org-rules.asl
{ include("$moiseJar/asl/org-rules.asl") }
