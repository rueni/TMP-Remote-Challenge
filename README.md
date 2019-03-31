# Design Document

## Goal:
* Prototype a job interview booking system for the interviewer

## Assumptions:
* One candidate and one interviewer
* No database - data will be initialized with hard coded values

## Design:
* Basic UI styled with Bootstrap

## System Dependencies:
* Rails 5
* Javascript + jQuery3
* Boostrap (CDN)
* flatpickr.js as Ruby Gem
* Git for version control
* time_difference GEM for Time comparison

## Build Plan:
* Build Rails 5 API only boilerplate
* Construct backend services
  * Create API controller and configure routes
  * Define methods for GET/POST in API controller
* Setup dependencies
  * Install GEMs
  * Configure application.js
  * Configure application.css
  * Configure application.rb
* Build UI
  * Generate Home controller + create corresponding HTML for index route 
  * Input field for slot count
  * Datetime picker
  * Search button + wired to candidate_schedules
route
  * Search results
    * Select input for slot selection
    * Submit button to book slot wired to schedule_interview
 route
  * Success/Error alerts
  * Validation checks
* Document test methodology
