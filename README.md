# cs561-swift
Jan 3, 2022 - an example from a lecture on code coverage, unit tests, and dependency injection
--- 
## Dependencies
- WeatherServiceImpl integration tests use [this mock API server](https://github.com/adeviney/mock-api-weather) run on localhost:3000. I had to run the tests using a docker container so I used the base URL `http://host.docker.internal:3000` but this may be changed to `http://localhost:3000` in WeatherService.swift file if you are running the mock API on your local machine. 
