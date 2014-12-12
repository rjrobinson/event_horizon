# Event Horizon

The point of no return.

## Importing Assigments

### Staging
- Gain access to staging environment:  [https://event-horizon-staging.herokuapp.com/](https://event-horizon-staging.herokuapp.com/)
- Run `rake` task to import assignments:
```no-highlight
heroku run rake horizon:import_lessons --app event-horizon-staging
```

### Production
- Gain access to production environment: [https://horizon.launchacademy.com/dashboard](https://horizon.launchacademy.com/dashboard)

* Run `rake` task to import assignments:
```no-highlight
heroku run rake horizon:import_lessons --app event-horizon
```

## Database Snapshots

To capture and download a snapshot of the production database, run the following commands:

```no-highlight
$ heroku pgbackups:capture --app event-horizon
$ curl -o db/dumps/latest.dump `heroku pgbackups:url --app event-horizon`
```

To restore the snapshot to your local database, run the following command:

```no-highlight
$ pg_restore --verbose --clean --no-acl --no-owner -d event_horizon_development db/dumps/latest.dump
```


[![Build Status](https://travis-ci.org/LaunchAcademy/event_horizon.svg?branch=master)](https://travis-ci.org/LaunchAcademy/event_horizon) [![Code Climate](https://codeclimate.com/github/LaunchAcademy/event_horizon.png)](https://codeclimate.com/github/LaunchAcademy/event_horizon) [![Coverage Status](https://coveralls.io/repos/LaunchAcademy/event_horizon/badge.png)](https://coveralls.io/r/LaunchAcademy/event_horizon)
