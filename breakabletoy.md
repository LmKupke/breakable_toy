# Breakable Toys Deliverable


##Breakable Toy #1
**Possible Names:**
* Who's Out?
* Night Out
* NightOwl
* FOMO-NO


**Description:** <br>

<p>This webapp solves the millennial's problem of FOMO (Fear Of Missing Out)! The webapp has User models and Bar/Club models, Friends (see about Omni-auth Facebook takes users friends/Koala gem).

After a user signs in through Facebook, they are able to see what mutual friends are going out in the newsfeed and able to initialize a group to go with. Once a group is initialized it allows members in the group to Vote (like Launch Votes) on each bar a member of the group submits. Bar/Club with highest votes wins. Declared on to mutual friends on news feed.
</p>

**Features:**
* Facebook login, Omni-auth Facebook w/ Devise
* Friends in initialized group vote on Bars/Clubs (highest votes win).

**CRUD FEATURES:**
* Friends in an initialized leave group or not accept invitation. (DELETE)
* User creates group (CREATE)
* Friends in group can (READ) data
* User can update date for going out (UPDATE)

**Special Features:**
* Bar/Club DB data seeded from Yelp API
* Vote on Bar/Club (in initialized group) is submitted via AJAX
* AJAX GET request on newsfeed
* Look into GEM PUSHER (Free account), it is for Notifications
* Friend not initially invited can request to join.
* Connect User with Tinder API and ping matches with Default one line about going out to "XYZ" Bar/Club with "X" friends and that he/she would like to see them out.

## Breakable Toy 2
**Possible Names:**
* GymBuddy
* LiftPal
* Thinking of other names

**Description:**
<p>This webapp allows Facebook authenticated users to find somebody to workout with at the same gym or make a friend. A user adds their gym goal (Gain Weight/Muscle, Weight loss, Performance), their gym (Yelp API Boston Gym names and locations), usual time of going.

Users are able to see other User's First Name and Last initial that go to their gym and request to be their GymBuddy. Users can deny requests.
</p>

**Features:**
* Authenticated user created through FB Omni-auth
* User can see members at current gym
* If member does not belong to gym can see count of members at each gym as well as male/female ratio, avg. age of gym.
* Info taken from FB (profile photo, name, location, sex, age).
* User has individual profile, with bio and schedule to go to gym (morning, midday, afternoon, evening)
* User can request to be connection with other users at set gym location. If accepted user can see Profile.


**CRUD FEATURES:**
* User creates profile
* User requests to be friends with Other Users in same gym
* User can have a gym.
* Users have a bio and can Update info (except for name, age, sex (only able to from FB))
* User able to add gym then see possible users first name and last initial.

**Special Features:**
* Connected Users are able to message each other.
