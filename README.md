# Splittable

A simple iOS application that pull data from an API endpoint (https://sheetsu.com/apis/v1.0/aaf79d4763af), and display the name and image in a list. When an item is selected, it will open a webpage inside the app.

## Prerequisites
- Xcode 8
- Swift 3.0
- CocoaPods

## Installation
From the command line:
```
$ git clone https://github.com/yyl29/splittable.git
$ cd splittable
$ pod install
```

Then launch and run the app in Simulator through Xcode.

## Tools
The app is written in Swift 3.0 and uses CocoaPods to manage dependencies. The following libraries are used:
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) - to parse JSON data
- [Alamofire](https://github.com/Alamofire/Alamofire) - to handle HTTP request
- [SDWebImage](https://github.com/rs/SDWebImage) - for async image downloads and caching management