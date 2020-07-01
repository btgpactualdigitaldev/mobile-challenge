fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios deploy_firebase
```
fastlane ios deploy_firebase
```
Deploy a new beta version to Firebase
### ios deploy_testflight
```
fastlane ios deploy_testflight
```
Deploy a new beta version to Test Flight
### ios run_ui_tests
```
fastlane ios run_ui_tests
```
Run project's UI tests

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
