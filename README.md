# GitHubApi

This project contemplates the creation of an application to consult the GitHub API.

## Requirements
- Swift 5
- Target: iOS 13.0
- Xcode 14.1

### Run project
To execute the project you have to:

1. Clone [the repo](https://github.com/anamartinsdev/GitHubApi) or download the ZIP file on a Mac
1. If you choose to download the ZIP file, unzip it
1. Open the file `GitHubApi.xcodeproj` with Xcode 11
1. Pick a simulator (choose an iPhone with iOS 13 or later)
1. Run the project (CMD+R)

### Run tests
To run some unit tests you have to:

1. Open the file `GitHubApi.xcodeproj` with Xcode 11
1. Run tests (CMD+U)

---

## Project Patterns

### Architecture 
- MVVM with closures

```
<SCENE_NAME>
├── View
│   └── <SCENE_NAME>View.swift
└── ViewModels
│   └── <SCENE_NAME>ViewModel.swift
└── Model
└── <SCENE_NAME>Model.swift
└── Coordinator.swift

### UI development
- ViewCode

### Network Layer Pattern
- HTTP Client
- URLSessionProtocol
- Service and Protocol

### Fastlane Documentation

[Fastlane](https://docs.fastlane.tools) 
is the easiest way to automate tests, generate coverage reports, beta deployments and releases for your iOS app
#### Running the Fastlane tests

In the Terminal app execute: ```fastlane tests```

#### Running the Fastlane screenshots

In the Terminal app execute: ```fastlane```