# User Stories

```
As an unauthenticated User
I can't get access to the application w/o authentication
So that I have to authenticate
```
**<u>ACCEPTANCE CRITERIA:</u>**
* navigate to the landing page to sign in/login
* attempting to bypass the sign page will redirect me the landing page

-------
```
As an unauthenticated User
I can sign in
So that I can access the application
```
**<u>ACCEPTANCE CRITERIA:</u>**
* navigate to the landing page
* sign in and be redirected to the newsfeed/homepage

------
```
As an authenticated User
I can see mutual friends activity
So that I know whats going on.
```
**<u>ACCEPTANCE CRITERIA:</u>**
* Go to the landing page
* Click button to Sign in with Facebook
* Redirect to Newsfeed, Homepage
* See mutual friends in the newsfeed

------
```
As an authenticated User
I can access my account
So that I can see past Events or Delete & Update Account
```
**<u>ACCEPTANCE CRITERIA:</u>**
* From the newsfeed or any other page click the account link in nav bar
* Be redirected to the account that displays information
* See link for past events
* See link for Delete Account
* See link for Update Account

------
```
As an authenticated User
I can delete my account
So that I can leave the application
```
**<u>ACCEPTANCE CRITERIA:</u>**
* From the newsfeed or any other page click the account link in nav bar
* Show the user's account page
* Click link for Delete
* Returned to the Landing page
* Show flash message that you deleted account

--------
```
As an authenticated User
I can update my account
So that I can have correct info
```
**<u>ACCEPTANCE CRITERIA:</u>**
* From the newsfeed or any other page click the account link in nav bar
* Show the user's account page
* Click link for Update
* Returned to the Account page
* Show flash message that Account update
--------
```
As an authenticated User
I can create an Event
So that I can have a plan
```
**<u>ACCEPTANCE CRITERIA:</u>**
* **Happy Path:**
  * From any page click on the nav bar and click on Create Event
  * Expect to be redirected to Create Event page
  * Page has form for Date, Venue
  * Submission of form redirects me to the newly created Event
* **Sad Path:**
  * Expect to be redirected to Create Event page
  * Page has form for Date, Venue
  * Invalid Submission of Data will return the user to the form page
  * Top of Page will have a Flash message for incorrect data.
---------
```
As the Event Organizer
I can invite friends
So that I am not going alone to a bar
```
**<u>ACCEPTANCE CRITERIA:</u>**
* After creation of an Event, click on Nav Bar for Events
* Page shows Events that I am either organizer or attendee of
* Click the recently created Event
* The page shows event details and a link for inviting friends (if organizer)
* Click link and see form for adding friends to an Event.
* **Happy Path:**
  * User adds friends and is redirected to Event details page
  * Event details page shows list of Friends with Status
* **Sad Path:**
  * User adds a friend that they are not friends with.
  * Page should redirect to Invite Friends page with Flash message
----------
```
As an Invited Member to an Event
I can accept
So that I am included in the group
```
**<u>ACCEPTANCE CRITERIA:</u>**
* From any page click the nav bar and click invitations
* The invitation page should show Event Location, Date, Attending Friends, Declined Friends, and Pending Friends.
* Button to Decline Invitation and Button to Accept Invitation.
* Click Accept
* Expect to see Event details page
-------
```
As an Invited Member to an Event
I can decline
So that I am not included in the group
```
**<u>ACCEPTANCE CRITERIA:</u>**
* From any page click the nav bar and click invitations
* The invitation page should show Event Location, Date, Attending Friends, Declined Friends, and Pending Friends.
* Button to Decline Invitation and Button to Accept Invitation.
* Click Decline
* Redirect to newsfeed

-------
