# Homework

This repository contains a bare-bone application including basic authentication.

# To Run the application

Make sure you have Ruby (2.2 or above) and Bundler installed.

To set up the database, run

```console```
bundle install
rake db:reset
```

This will set up the database and it also create 3 users: 'teacher', 'student' and 'lazy_student'.

To start the web server, run

```console```
bundle exec rails server
```

Open your web browser and go to http://localhost:3000

There are three available users in the system:

1. teacher
2. student - A student who is on top of their homework.
3. lazy_student - A student who hasn't started their homework yet.

# Run the Tests

Unit tests have been added for the controller logic. You can run these tests with:

```console```
rspec
```
