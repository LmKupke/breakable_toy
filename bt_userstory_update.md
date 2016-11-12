# User Stories

```
As an unauthenticated User
I can't get access to the application w/o authentication
So that I have to authenticate
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [X] Link to Sign Up/Sign In with FB page on Landing Page
- [X] Cool Landing page
-------
```
As an unauthenticated User
I can sign in
So that I can access the application
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [ X ] Link to Sign Up/Sign In with FB page on Landing Page
- [ X ] Upon clicking Sign Up with FB, user enters valid FB creds
- [ X ] Upon successful credentials new user redirected to newsfeed  

------
```
As an authenticated User
I can sign out
So that I can leave the application
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [ X ] Link to Sign Out in Top Bar
- [ X ] Upon clicking Sign Out user is redirected to Landing Page

------

```
As an authenticated User
I can see mutual friends activity on the newsfeed
So that I know whats going on.
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [ X ] Newsfeed has many individual divs of mutual Friends activity
- [ X ] Mutual friends names in Newsfeed are links. To individual profile
------
```
As an authenticated User
I can access my account
So that I can see upcoming and past Events
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [X] Profile link is in nav bar
- [X] Click action on Profile link brings User to Profile page
------

```
As an authenticated User
I can create an Event
So that I can have a plan
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [ X ] Link to Create Event exists on Nav Bar
- [ X ] Create Event form requires user to specify date and name
- [ X ] Upon successful submission user is redirected to the Event#show page for the newly created event and Asks to pick a Venue and Asks to add Friends
- [ X ] User sees errors upon entering invalid input
---------

```
As the Event Organizer
I can invite friends
So that I am not going alone to a bar
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [ X ] Link for Events in Nav Bar
- [ X ] Text field to Add friends on Event show page (if current date is not passed and organizer)
- [ X ] Successful submission shows Event#show page shows message that friend has been invited
- [ X ] User sees errors about friend not existing on top page
----------
```
As an Invited Member to an Event
I can accept
So that I am included in the group
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [ X ] Link for Invitations in Nav Bar
- [ X ] Invitations#show page has all invitations (for future and present date)
- [ X ] Have a Accept Button
- [ X ] Have a Decline Button, with Confirmation
- [ X ] Accept redirects to Event show page
-------
```
As an Invited Member to an Event
I can decline
So that I am not included in the group
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [ X ] Link for Invitations in Nav Bar
- [ X ] Invitations#show page has all invitations (for future and present date)
- [ X ] Have a Accept Button
- [ X ] Have a Decline Button, with Confirmation
- [ X ] Decline Confirmation stays on invitation page

-------

```
As an invited event attendee
I select a bar an additional bar/club
So that There are more options for place to going out
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [ X ] Event#show page has button to select a Venue
- [ X ] After selecting a Venue, it appears in the Event#show page queue
- [ X ] After selecting a Venue, invite friends options is available

----
```
As an invited event attendee
I can invite mutual friends with Event Org
So that more friends going out
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [ X ] Event#show page text-field to add friends
- [ X ] After selecting a Venue, invite friends options is available
- [ X ] Invitation of a valid friend shows a success message
- [ X ] Invitation of a invalid friend or non-mutual friend shows error message
----


```
As an authenticated user
I can look at the Boston nightlife
So I know whats available
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [ X ] Boston Nightlife is in the Menu
- [ X ] I am able to view each place and see its rating & info.

```
As an authenticated user
I can search a Boston Nightlife spot
So I can find the spot I want
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [ X ] Boston Nightlife is in the Menu
- [ X ] Search bar is available in the Venue#index
- [ X ] Successful search will return Venue in the Database
- [ X ] Unsuccessful search will return possible choices from Yelp

----

```
As an authenticated User
I can see Events created by me or joined by me
So that I can see whats going on
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [X] Link to Profile exists on Nav Bar
- [ ] Profile page shows all events that belong to me and/or Events I joined(accepted)

---------

```
As an invited event attendee
I can upvote and downvote a Venue
So other attendees know whats of interest
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [ ] Event#show has venues in the queue with up and down arrows
- [ ] Clicking the up arrow will give that spot a higher vote
- [ ] Clicking the up arrow twice will reset the user's vote
- [ ] Clicking the down arrow will give that spot a lower vote
- [ ] Clicking the down arrow will reset the user's vote


----

```
As an authenticated User
I can delete my account
So that I can leave the application
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [ ] Settings link is in nav bar
- [ ] Settings Page has button delete
- [ ] Clicking button asks for confirmation of Deletion of Account
- [ ] Confirmation redirects delete User to landing page
- [ ] Deny confirmation shows User account still

--------
```
As an authenticated User
I can update my account
So that I can have correct info
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [ ] Account link is in nav bar
- [ ] User Account Page has Edit Account Button
- [ ] Edit Account Info Page has form
- [ ] Valid submissions redirects to User account page
- [ ] User sees errors upon entering invalid input on Update Info page
--------



## Extras:

```
As an authenticated user
I can see a Venues location
So that I know where it is located
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [ X ] Boston Nightlife is in the Menu
- [] The Venue#show page includes a Google Map showing its location

---
```
As an invited user or event organizer
I would like to see a countdown time for voting on a venue
So that I know how long I have left to vote on a Venue
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [] Event#show page has a clock countdown for Event
---

```
As an invited user or event organizer
I would like to see a countdown time for inviting people
So that I know how long I have left to invite friends
```
**<u>ACCEPTANCE CRITERIA:</u>**
- Event#show page has a clock countdown for Inviting
----

```
As an uninvited authenticated user
I would like to request to join an event
So that I can be included in the event
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [ X ] The newsfeed shows button "Tag Along" if not invited to an event
- [] Clicking "Tag Along" button sends a text
    to the event organizer stating they would like to be added to the event

----

```
As an authenticated admin
I would like to see how many users on the application and how many invites are used
So I know whats trending
```
**<u>ACCEPTANCE CRITERIA:</u>**
- [] Admin Access in the top bar
- [] Admin#index shows all Users
- [] Admin#index shows chart of how many events created
- [] Admin#index shows chart of how many invites

---
```
As an authenticated user
I would like to ping Tinder matches
So they know I where I am planning to go out to
```
**<u>ACCEPTANCE CRITERIA:</u>**

- [] Tinder Matches is in the Nav Bar
- [] Tinder Index shows matches.
- [] Drop down of users upcoming Attending Events next to Tinder Match (T.M.)
- [] Selection of dropdown and click of button sends message to T.M. stating the date and Time of the venue they are attending with X amount of friends. 

---
