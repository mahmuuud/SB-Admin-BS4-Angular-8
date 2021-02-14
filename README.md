# Angular SB Admin Pipeline ☄️

> SB Admin pipeline is a CI/CD pipeline built using Jenkins Open source tool to Automate Jobs from building the project till the deployment phase which could be time consuming if done manually due to frequent updates in some organizations.

### Frameworks and Tools:
> I have done my best to use as much open source technologies as possible to get the benefit of them having a wide development community and for extensibility.

* [Jenkins](#Jenkins)

* [Docker](#Docker)

* [Artifactory](#Artifactory)

* [Github](#Github)

#### Jenkins
> Jenkins was used to build the whole pipeline due its great extensibility and wide support community, The Jenkinsfile for the pipeline could be found at the project's home dir.

* I have configured Jenkins on my Localhost and then exposed that port to the Internet using `ngrok` to be able to share Webhooks between Github and Jenkins.

* The pipeline was configured to be triggered with any Github Push.

* A webhook was added later to the Github Repo of my project to notify the pipeline in case of any Checkin happens.

* I didn't use many Plugins other than the suggested on from Jenkins installation, However I needed Artifactory plugin to be able to upload The build artifacts to it (discussed later on).

* The pipeline consists of 5 main stages from which 3 stages are the main CI/CD ones (Build, Test, Deliver).

* The first stage is dedicated for SCM checkout to fetch the changes.

* At the second stage which is the build stage, the pipeline uses `npm install` to install any project dependencies on the pipeline machine, and uses `npm build` to produce the current build artifacts in `/dist` directory.

* Unit tests and code hygiene are conducted at the third stage running the command `npm test-ci` which will run the project's unit tests in non-watch mode using Karma framework for testing angular apps. And Prettier framework was used for code linting. The test results from this stage are stored in a single file named `UnitTestResultsBuild-${BUILD_NUMBER}.txt` to be uploaded later on with the artifacts to Artifactory.

* The Deliver stage is basically about running E2E tests, I have developed a simple E2E test Case to be run using `Protractor` framework and the log is also stored under the name `E2ETestResultsBuild-${BUILD_NUMBER}.txt` to be uploaded as well.

* E2E needs a pre configured Selenium server to be running and the URL to that server is provided to Protractor at `protractor.conf.js` file

* After the E2E testing phase the website is deployed to Localhost to simulate the whole process as if the Localhost is the production server.

* At this point the pipeline main flow is over, However there's one stage left for post pipeline actions which are three actions; `Always` closure which will always execute after the pipeline stages, `Success` closure which will execute its closure in case all the pipeline scripts returned an exit code of zero (Success) and `Fail` which will execute in case of failure.

* Both `success` and `failure` closures use E-mail notifications to notify the pipeline in case of pipeline success or issues

* The `Always` Closure uses the Artifactory plugin to upload the artifacts and both test logs to Artifactory.


##### Roll Back Scenario
>In case of failure or any other sudden circumstances which require a rollback, Files for the previous build could be downloaded from Artifactory and deployed on the deployment machine. Or if there's a Blue/Green mechanism it could be used for rollback as well.


#### Docker

> I used Docker to solve Any Discrepancies between development and deployment environments.

* A golden image was built using the `Node` official image as a base image and the  `Dockerfile` in the project's root directory to install any additional dependencies which are briefly discussed in the [Dependencies](#Dependencies) section.

* A container can be used from this image to be able to run the project smoothly using `docker run -dp 4200:4200 <Image name>` command which will run the image with the port 4200 exposed (out app's PORT).

* The application could be now be viewed by navigation to `Localhost:4200/` inside your favorite browser.


#### Artifactory

> Artifactory was used to store the build artifacts and test results produced by our pipeline as a tar file in a physical Repo. at `https://agilegps.jfrog.io` (could be checked in the demo videos).

#### Github
>[Github](https://github.com/mahmuuud/SB-Admin-BS4-Angular-8) was the SCM used within the whole process.


### Installation

>The recommended solution to run the project is through the docker image using the `Dockerfile` at the project's root dir. else you will have to install all the project's dependencies manually. And running `npm install` to install the package dependencies afterwards.

* [NodeJs](https://nodejs.org/en/)

* [Angular](https://angular.io/guide/setup-local)

* [Web driver](https://selenium-python.readthedocs.io/installation.html)

* [Java JRE](https://www.oracle.com/java/technologies/java-platform.html)


## Conclusion

Unfortunately this short trip of ours has came to an end but i hope you enjoyed it as much as i did! and if you already reached this part of the file i guess you did. So I wanna thank you for this and to many more adventures to come!

> Demo videos attached for the pipeline in action.
