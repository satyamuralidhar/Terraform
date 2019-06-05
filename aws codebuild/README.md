open project create a build-specification  clear all the data  and then enter

# give ur java code git url and also edit main.yml file

version: 0.2

phases:
  build:
    commands:
      - echo build started on `date`
      - mvn test
  post_build:
    commands:
      - echo build completed on `date`
      - mvn package


#

choose ur os as ubuntu
and i was selected java-jdk.8.0

Current build specification
Using buildspec.yml in the source code root directory
Cancel update build specification
Build specification
Use the buildspec.yml in the source code root directory
