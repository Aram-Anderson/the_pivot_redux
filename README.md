# The Pivot

This project was inherited from @mimilettd's [Little Shop](https://github.com/mimilettd/little_shop_of_funsies) project from mod 2 at Turing.

The aim of this project was to take a brownfield app written by someone else, which did single tenancy e-commerce and turn it into a multi-tenant e-commerce platform.

This project was done by a group of four, over a 1.5 week sprint (collaborators at the bottom of this readme).

This was, by far, the hardest project I've done while attending Turing, but also one of the most valuable. I'm not proud of the outcome, but I am proud of the lessons I learned through the process.

In the original app, the main points of functionality were:

* An unregistered user could visit the site, add items to a cart, filter items by category, and create an account or log in. If an unregistered user visits the cart page, they see a login or create account link rather than a checkout link.

* A registered user can do all the things an unregistered user can do, as well as checkout from the cart page, which generates an order in the DB.

* An admin user has all the above functionality, as well as the ability to create, update, and delete items and categories.

The major changes in functionality required for this project were:

* The app should host multiple stores, which each have items for sale.

* There should be five user roles
  * Unregistered user (no change)
  * Registered user
    * Added functionality of a password reset and two factor auth (using Twilio).
  * Business Manager
    * Can create, update, and delete items only for the store they manage.
  * Business Administrator
    * All the functionality of a business manager, but additionally able to update or delete only their own store.
    * Business Manager and Business Administrator can also have multiple store associations.
  * Platform Administrator
    * Has all the functionality of the other roles, but also has a dashboard giving them analytic data about the site as a whole, and the ability to update or delete items from any store, and to take stores offline.
  * In addition, we were introduced to JQuery a few days ago, and needed to build out the platform admin dashboard using that new tech.

This was a big shift from the functionality of the original app, and it was quite the project to do so.

We didn't get the project completely finished, which was disappointing. However, there were some great lessons in the process, and I feel like that was worth the price of admission.

Learning how to do handrolled authorization for multiple permission levels for different users was sometimes frustrating, but a great learning experience. We ended up building out a PORO that handled all the permissions, which was a little ugly, but worked well.

We built out the platform admin dashboard using our Rails backend as just an API. We built out authentication on a API calls as well, so a token is needed to hit those endpoints. We built the frontend API calls using `fetch`, which is new in ES6. That gave us a little bit of trouble with the asset pipeline, but we got it ironed out.

The biggest challenge we faced was keeping a green test suite on the existing functionality as we made the necessary changes. Because we were adding new relationships where existing models were now dependent on new models, our changes caused problems throughout the test suite. Additionally, we inherited a code base with a test data creation strategy that was highly inflexible. The group that built the original project had essentially created a very complex version of factory_girl in a helper file in the spec directory. Eventually, we decided the upfront cost of going in and rewriting the tests to use factories would be worth it, and we did that.

Testing Twilio was another challenge, but also a great learning experience. There were quite a few things in Twilio that needed to be stubbed in testing, but sorting out what the return value should be in a stub was sometimes difficult.

All in all, I feel like this really was a good learning experience, and even though as a finished product it's not the work I'm most proud of, as a platform for learning new things it was a great success. It also thrust us into working with a codebase we didn't have control over, and learning to work in someone else's code. I think that's useful as a practical lesson, as well as a lesson in empathy.

If you'd like to get the app stood up locally, clone it down, cd into the directory, bundle, rake db:{create,migrate,seed}, rails s, and go to localhost:3000. There is a user in the seed file with all permissions with the login of 'mimi@mimi.com', and password 'mimi'.

Twilio and Twitter OAuth will not work unless you create an `application.yml` file and add your own keys for those services. 

<b>Collaborators:</b> Aram Anderson (@Aram-Anderson), Danny Trujillo (@djtrujillo), Joan Harrington (@sidewinder2020), Sam Nayrouz (@snayrouz)
