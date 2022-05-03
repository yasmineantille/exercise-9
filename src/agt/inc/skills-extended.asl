/*
	Additional agent skills for reacting to events
*/


/*
  React to an event of a group board artifact with id GroupArtId being
  available. React by focusing on the artifact
*/
+group(_,_,GroupArtId) : not focused(GroupArtId)
<-
  focus(GroupArtId).
