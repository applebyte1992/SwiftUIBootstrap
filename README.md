# Boilerplate Project
## This project provides an insight on how to write start a project with SwiftUI
###### A boilerplate project created in Swift using SwiftUI and MVVM. Boilerplate supports both iPhone and iPad
## Getting Started
The Boilerplate contains the minimal implementation required to create a new project in SwiftUI using MVVM Architecture. The repository code is preloaded with some basic components like basic app architecture, constants and required dependencies to create a new project. By using boiler plate code as standard initializer, we can have same patterns in all the projects that will inherit it. This will also help in reducing setup & development time by allowing you to use same code pattern and avoid re-writing from scratch.

## How to Use
Download or clone this repo by using the link below
```bash
https://github.com/applebyte1992/SwiftUIBootstrap.git
```
Open project folder in terminal and run Pods by using 
```bash
pod install
```

- SwiftUI Basic UI for Login and Profile List of Users
- MVVM Architecture 
- Realm Database
- Alamofire Network Layer
- Repository Pattern to handle server and local data
- Unit Testing on all layers

## Boilerplate Features
* Splash
* Login
* Listing of Users
* Remote Images Loading 
* Alamofire 
* Validations (Network Layer with OAuth Implementation)
* Database **(Realm)** (Following Protocol Oriented Programing)
* Dependency Injection
* MVVM Architecture
* Repository Pattern

## Libraries User
* [Alamofire](https://github.com/Alamofire/Alamofire)
* [SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI)
* [Alamofire](https://github.com/Alamofire/Alamofire)
* [Realm](https://realm.io/realm-swift/)

## Folder Structure
```bash
SwiftUIBootstrap/
|- SwiftUIBootstrap
|- Podfile
|- README.md
|- scripts (Script for Swift Lint)
|- SwiftUIBootstrap.xcodeproj
|- SwiftUIBootstrap.xcworkspace
|- SwiftUIBootstrapTests
|- SwiftUIBootstrapUITests
```

```bash
SwiftUIBootstrap/
|- AppDelegate.swift
|- Assets
|- Assets.xcassets
|- Base
|- Components
|- Configurations
|- Constants
|- CustomModifiers
|- Extensions
|- Info.plist
|- Modules
|- RealmDatabase

```
Lets, deep dive into each of the folders to get an idea what are 

- Components -  All the application level components are that are shared across application and used in more than one places are placed in here 
- Configurations - Environments(DEV,STAGE,PROD) are configured in this folder and decision will be taken on running schemes
- Constants - All constants including Strings, View Specific Constants, Fonts and other constants that are being used in the application are placed in this folder
- CustomModifiers - While working with SwiftUI we need custom view modifiers so all of them will be placed in this folder to be used across application
- Extensions - Extension is one of the most powerful concept in swift and in that folder we will keep all the extensions related to Swift and SwiftUI
- Modules - Modules contains all the code of the application and is modularised according to its nature so  e.g login, users listing , user profile , home screen all these things are separate modules of a single application so they will be categorised separately each module must contains Views, View Models, Models , Repository, Service. Enums and cells specific to modules are placed inside the modules otherwise placed inside shared folder of module
