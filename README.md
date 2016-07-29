# Breakable Toy
![Build Status](https://codeship.com/projects/a8436420-0bc4-0134-e391-16fbb5fd4d7e/status?branch=master)
![Code Climate](https://codeclimate.com/github/LmKupke/breakable_toy.png)
[![Coverage Status](https://coveralls.io/repos/github/LmKupke/breakable_toy/badge.svg?branch=master)](https://coveralls.io/github/LmKupke/breakable_toy?branch=master)

<b>
Demo Site:</b> http://nomo-fomo.herokuapp.com/

### About
---

NOMO FOMO (No More Fear Of Missing Out) is a social networking web application that helps people pick possible places they and their friends can go out to.

The web app is build with Ruby on Rails, JQuery, and Foundations CSS.

All photos are from the User are stored on the database through their Facebook sign in.

I integrated Facebook OAuth and the Facebook API ([Koala Gem](https://github.com/arsduo/koala)) to allow users to interact with their friends. I added integrated the [Yelp Api](https://github.com/Yelp/yelp-ruby) and Google Places Embed API to retrieve possible bar & clubs and their mapped locations.

Lastly I integrated the [Twillio API](https://github.com/twilio/twilio-ruby) so a user's uninvited friend can ping the event organizer and request to join.

### Why Did I Build NOMO-FOMO?
----

I decided to build NOMO FOMO to get rid of those chaotic moments before going out, when everyone is asking, "Where are we going? The Uber is here!".

### Cloning this repos

In order to clone this repo, several API keys are needed:
Twillio
YELP
GMAIL Places Embed.

To set up Facebook OAuth go the [Facebook Developer site](https://developers.facebook.com)
and create a Facebook App.

#### Testing

For the testing suite, you will need to create Facebook Test Users (that are friends with each other) on the Facebook Developers Site.

Place a `binding.pry` in the `from_omniauth` method in the [User's model](https://github.com/LmKupke/breakable_toy/blob/master/app/models/user.rb) and log in as the Test User and retrieve the authorization hash. Write `puts auth` to see the structure. It should look like the OmniAuth mock auth hash in [rails_helper.rb](https://github.com/LmKupke/breakable_toy/blob/master/spec/rails_helper.rb).

This Test user info will need to be placed into the [rails_helper.rb](https://github.com/LmKupke/breakable_toy/blob/master/spec/rails_helper.rb) file.

At the beginning of each test file it calls the Mock Auth method and signs in as your test user. The before method in each most files calls finds the test user and assigns it to the variable.

Lastly You will need to create the hash of friends the Test User has and a hash of mutual friends with another Test User and place them both in [support/koala_fake.rb file](https://github.com/LmKupke/breakable_toy/blob/master/spec/support/koala_fake.rb).

If you need further information LinkedIn Message me at https://www.linkedin.com/in/lincolnkupke
