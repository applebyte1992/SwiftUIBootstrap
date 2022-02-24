# SwiftUIBootstrap Project
## This project provides an insight on how to write start a project with SwiftUI
###### Below are the items that are covered in this project
- SwiftUI Basic UI for Login and Profile Display
- MVVM Architecture 
- Realm Database
- Alamofire Network Layer
- Repository Pattern to handle server and local data
- Unit Testing on all layers

### Project Structure
- SwiftUIBootStrap 
  - SwiftUIBootStrap
  - SwiftUIBootStrapApp
  - AppDelegate
  - Base
    - Base contains all the base protocols and implementations for network and database layers
  - Extensions
    - All extensions are placed with proper file name of the extension type are placed in this folder
  - Constants
    - All constants including Strings, Colors, Fonts and other constants that are being used in the application are placed in this folder
  - Custom View Modifiers
    - While using SwiftUI we might need to entertain some custom modifiers so these modifiers are placed in this folder
  - Configurations
    - Envoirnments are configured in this folder and descision will be taken on runing schemes
  - Modules
    - Project is divided into smallers modules based on their bussiness logic like Authentication, Home Screens, Profile etc and placed inside this folder.
      - Views
        - All views in a modules are placed in this folder forexample authentication contains login screen, sign up screen, forgot password screen so all of them are considered as one module
        - We are not using any factory pattery for making UI as we'll be using subclasses of for each controls and handle generic logics on parent classes.
      - ViewModel
        - Every views view model is placed in here and is responsible of interacting with Repository   
      - Models
        - Models of that module are placed in here   
      - Respository
        - Repo
          - Repository is responsible of comminucating with Service and Database and response back to View Model
        - Service
          - Service is responsible of communicating with the remote server and returned mapped data back
        - Database
          - Database is responsible of communicating with local database and returned response back to repo  


###Architecture Diagram
![alt text](https://github.com/applebyte1992/SwiftUIBootstrap/blob/master/AppArchitecture.png)
