# EMI Coding Exercise

## Overview

The point of this exercise is to help you and the EMI team learn if we are a good fit. In this assessment, you will modify a very simple merb application. Our hope is that it only takes you a few hours to complete. When you are done, we will review it. If we like what we see, we will ask you back for a screen sharing session for about an hour with one of our engineers to make some minor modifications together pair-programming as best we can over the Atlantic Ocean.

## Required Tools and Technology

* ruby version 1.8.7
* rspec version 1.3.0
* merb version 1.0.15
* datamapper version 0.10.2
* mysql version 5.1+
* git & github.com access

## Goal

Take this existing Merb application which retrieves album price information from iTunes and add the capability to retrieve price information from Amazon.

## Steps

* Read this entire document. Before you start, send an email to Richard and Eric letting them know how long you think this will take, and when you think you will finish. Let them know if you have any concerns or limitations.
* Fork this repository to your own GitHub account
* As you do the following below, commit and *push* your code up to GitHub regularly with quality git comments that demonstrate iterative and atomic work. We may check individual check-ins in our review.
* Change the contents of the base README file to include any instructions for another engineer to configure/install/build your application.
* Do not use scaffolding or automatic code generation for your tests if you can help it.
* Ensure that your default rake task for the project runs all RSpec tests.
* Research how you would get price information from Amazon.com
* Write a test that would take an Amazon ID (called an ASIN) and get the price for that product. Sadly Amazon does not provide JSON like iTunes so things will be a little different.
* Write the code that would fulfil that test
* Change the view to supply a field where the user can enter an ASIN and save it. NOTE: we do not care about the UI design for this exercise. It can be ugly and we won’t care about the CSS/HTML.
* Add a "Lookup Amazon Price" button that gets the price from Amazon and then display it on the page. Save all the content from Amazon in the database in case we want to check other information (disk space is cheap after-all).
* Email Richard and Eric with GitHub URL that we can use to clone your project. No need to worry about securing the repo, keeping it public is just fine. If you are concerned about other's modifying it, then provide us with a tag, branch or other way to ensure we review the right check-in.

## Success Criteria

* An EMI engineer (the reviewer) will clone your git then read your README to see if anything special needs to be done to make your app work (e.g. install any special gem/software etc.) Our hope is that there be very little here to do.
* The reviewer will then run "rake" and expect to see all your tests pass.
* The reviewer will check your tests to see that they are well organised and appropriately cover all your business logic without being too brittle. We will look for clarity over cleverness. We will look for "DRY" code but do not care about "DRY" tests (for the purposes of this exercise).
* The reviewer will bring up a web browser, go to your form and enter in a few Amazon IDs to see we get back the prices we expect.
* The reviewer confirm that you use RESTful routes and they are appropriately tested
* The reviewer will check your method and variable names to see if they make sense.
* The reviewer will check for evidence that you use TDD.
* We are looking for you to demonstrate clarity more than cleverness -- that future engineers who build on your code can get up to speed quickly because your code is so incredibly easy to understand.

## Not in Scope

You do **NOT** need to code for the following:

* authentication nor authorisation
* CSS
* Images nor colours nor fonts
* UI design of the web pages (keep it very very simple)
* Javascript
* Commenting your code unless you feel it is essential
* Transaction history nor timestamps
* GemInstaller / Bundler
* Submodules nor slices

These items are important for the work you will be doing at EMI, but we want to limit the scope of this exercise to your writing quality tests of your models and controllers, and fulfil the goal of looking up data on iTunes.

Good luck!