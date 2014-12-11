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


[![Build Status](https://travis-ci.org/LaunchAcademy/event_horizon.svg?branch=master)](https://travis-ci.org/LaunchAcademy/event_horizon) [![Code Climate](https://codeclimate.com/github/LaunchAcademy/event_horizon.png)](https://codeclimate.com/github/LaunchAcademy/event_horizon) [![Coverage Status](https://coveralls.io/repos/LaunchAcademy/event_horizon/badge.png)](https://coveralls.io/r/LaunchAcademy/event_horizon)
