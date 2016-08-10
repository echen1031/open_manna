Open Manna is a Web app thath sends Bible verses via text messages.
==========



## Setup the project for the first time (Locally)

```
bundle install
```

### Setting up environment variables (Figaro)

Make a copy of the following file and rename it `application.yml`

```
application.example.yml
```

Fill in the values for each environment variables

### Setup the database (and seed it)

```
rake db:setup
```

#### Seeding the database (Locally)

  Seed tables (using seed files under db/seed/)
(this should have been taken care of by `rake db:setup` but you can run it manually as well).

  ```
  rake db:seed
  ```

(note: Only 5 verses will be created for testing purposes.)


### User for testing

  By running rake db:setup or rake db:seed, you should be able to login with:

  ```
  email: "user@example.com"
  pw: "helloworld"
  ```

