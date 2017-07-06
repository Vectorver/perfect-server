
import PackageDescription

let package = Package(
    name: "perfect-server",
    dependencies: [
    .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", majorVersion: 2),
    .Package(url: "https://github.com/PerfectlySoft/Perfect-Mustache.git",majorVersion: 2)
            
    ]
)
