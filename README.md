# PermissionsKit

[![CI Status](http://img.shields.io/travis/Multinerd-Swift/PermissionsKit.svg?style=flat)](https://travis-ci.org/Multinerd-Swift/PermissionsKit)
[![codebeat badge](https://codebeat.co/badges/066bdbfe-2670-41a0-86e0-a1afab3f2be8)](https://codebeat.co/projects/github-com-multinerd-swift-permissionskit-master)

`PermissionsKit` is a simple to use wrapper to request any kind of permission.  

Every goal could be easily reached using `PermissionsKit`.
* Show a alert to avoid burning your **ONLY** system request.
* Show a alert to re-enable the permission if it has been denied.
* Manage request frequency via `PermissionsKitConfigurations`
* Implemented Permissions
  - [x] Camera
  - [x] Bluetooth
  - [x] CloudKit
  - [x] Contacts
  - [x] Events (Calendar)
  - [x] Health
  - [x] Location (Always)
  - [x] Location (When in use)
  - [x] Media Library
  - [x] Microphone
  - [x] Motion
  - [x] Notifications
  - [x] Photo
  - [x] Reminders
  - [x] Speech Recognizer





## Table of contents

* [Example](#example)
* [Requirements](#requirements)
* [Installation](#installation)
* [Usage](#usage)
* [License](#license)





<a name="example"></a>
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.





<a name="requirements"></a>
## Requirements

![Requires iOS 10.0 or higher.][iosBadge]
![Support for macOS is unknown.][macBadge]
![Support for tvOS is unknown.][tvBadge]
![Support for watchOS is unknown.][watchBadge]

![Requires Swift 4.0 or higher.][swiftBadge]
![Support for Objective-C is unknown.][objcBadge]

![Requires Xcode 9.0 or higher.][xcodeBadge]

[iosBadge]: https://img.shields.io/badge/ios-10.0+-a.svg?style=flat&colorA=212121&colorB=616161
[macBadge]: https://img.shields.io/badge/macos-unknown-a.svg?style=flat&colorA=212121&colorB=616161
[tvBadge]: https://img.shields.io/badge/tvos-unknown-a.svg?style=flat&colorA=212121&colorB=616161
[watchBadge]: https://img.shields.io/badge/watchos-unknown-a.svg?style=flat&colorA=212121&colorB=616161

[swiftBadge]: https://img.shields.io/badge/swift-4.0+-a.svg?style=flat&colorA=212121&colorB=FD7935
[objcBadge]: https://img.shields.io/badge/objective--c-unknown-a.svg?style=flat&colorA=212121&colorB=616161

[xcodeBadge]: https://img.shields.io/badge/xcode-9.0+-a.svg?style=flat&colorA=212121&colorB=00B0FF





<a name="installation"></a>
## Installation

[![Mia is compatible with cocoapods.][cocoapodsBadge]][cocoapodsURL]
[![Mia is incompatible with carthage.][carthageBadge]][carthageURL]
[![Mia is incompatible with swift package manager.][spmBadge]][spmURL]


### [CocoaPods][cocoapodsURL]

To integrate Mia into your project using `cocoapods`, specify it in your `podfile`.

```ruby
pod 'PermissionsKit', :git => 'https://github.com/Multinerd-Swift/PermissionsKit.git'
```


### [Carthage][carthageURL]

Not yet compatible with `carthage`. Feel free to submit a pull request.


### [Swift Package Manager][spmURL]

Not yet compatible with `swift package manager`. Feel free to submit a pull request.


### Manually

1. Clone this repo.
2. Drag and drop the contents of `Core` and the permission files you will request.

[cocoapodsBadge]: https://img.shields.io/badge/cocoapods-compatible-a.svg?style=flat&colorA=212121&colorB=00C853
[carthageBadge]: https://img.shields.io/badge/carthage-incompatible-red.svg?style=flat&colorA=212121&colorB=E53935
[spmBadge]: https://img.shields.io/badge/spm-incompatible-red.svg?style=flat&colorA=212121&colorB=E53935

[cocoapodsURL]: http://cocoapods.org
[carthageURL]: https://github.com/Carthage/Carthage
[spmURL]: https://swift.org/package-manager/





<a name="usage"></a>
## Usage

### Check permission status
```swift
let permission = PermissionsKitPhoto()
permission.status { (status) in
    switch status {
        case .authorized:    
            print("Can use the camera.")
        case .denied:        
            print("Camera access is denied.")
        case .notDetermined: 
            print("Unable to get camera permissions.")
        case .notAvailable:  
            print("Camera was not detected.")
    }
}
```

### Request a permission
```swift
let permission = PermissionsKitCamera()
permission.manage { (status) in
    switch status {
        case .authorized:    
            self.setupCamera()
            
        case .denied:        
            self.showMessage("Camera access is denied.")
            
        case .notDetermined: 
            self.showMessage("Unable to get camera permissions.")
            
        case .notAvailable:  
            self.showMessage("Camera was not detected.")
    }
}        
```

### General configuration
Each permission type included in `PermissionsKit` is configurable through the `PermissionsKitConfiguration` struct. Each permission has a default configuration, so if you are happy with the basic configuration you don't have to care about how it works behind the scenes.





<a name="license"></a>
## License

![License][licenseBadge]

PermissionsKit is available under the MIT license. See the [license][licenseURL] file for more information.

[licenseBadge]: https://img.shields.io/badge/license-MIT-a.svg?style=flat&colorA=212121&colorB=616161
[licenseURL]: https://github.com/Multinerd-Swift/PermissionsKit/blob/master/LICENSE
