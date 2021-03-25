# coding_challenge


## flutter config

### This project was developed with the following configuration (pubspec.yaml)

    environment:
        sdk: ">=2.7.0 <3.0.0"

    flutter channel stable 2.0.0

### Tested in a real device

    Huawei P30 Pro

### Android / iOS support

Project is configured for both Android/iOS but only tested on Android

    Google Maps Api keys
    Geolocation permissions


## Architecture

We use Clean Architecture by [Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) adapted by [ResoCoder](https://www.youtube.com/watch?v=dc3B_mMrZ-Q)

We use package by [feature](http://www.codingthearchitecture.com/2015/03/08/package_by_component_and_architecturally_aligned_testing.html) as a code organisation.

### TDD
Every layer is tested
 - data
   - datasources
   - models
   - repo implementations
 - domain
   - usecases
 - presentation
   - bloc

We dont have UI test at the moment. If we run

     flutter test
     
in the project folder,two tests will fail, the explanation is in the test. It's basically the impossibility to test static methods (geolocator) with mockito.

## Functionality
- Uses foursquare api to search venues
- Show them in a map / listview
- Show detailed info 
- Allows you to favorite venues and stores them locally


## Instalation
If we clone the project from github, you will not be able to use the app, because the foursquare secrets and google api keys are hidden from here.

You will need to run the one submitted in the [job aplication page](https://adedelivered.com/offer/android-engineer-apks-magicians/), which have those keys.

    flutter run

If this doens't work, I will provide the needed files.

## Resources
- [Trello](https://trello.com/b/sQuq8uh5/coding-challenge)

- [Figma](https://www.figma.com/file/xVGG6dyuxzEewmaaqxy7aS/Coding-Challenge)

- [Github](https://github.com/NauzetAduen/coding-challenge)



