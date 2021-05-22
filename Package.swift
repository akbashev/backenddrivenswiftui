// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "backenddrivenswiftui",
    platforms: [.iOS(.v13), .macOS(.v11), .tvOS(.v13), .watchOS(.v7)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        // .target(
        //     name: "CodableView",
        //     dependencies: ["Kingfisher"]),
        // .testTarget(
        //     name: "CodableViewTests",
        //     dependencies: ["CodableView", "Kingfisher"]),
    ]
)

// Server
package.dependencies.append(contentsOf: [
    .package(url: "https://github.com/vapor/vapor.git", from: "4.45.5"),
    .package(url: "https://github.com/akbashev/CodableView.git", .branch("main"))
])
package.products.append(contentsOf: [
    .executable(name: "server", targets: ["server"]),
    .library(name: "ServerApp", targets: ["ServerApp"]),
    .library(name: "Models", targets: ["Models"]),
])
package.targets.append(contentsOf: [
    .target(
        name: "Models",
        dependencies: [
            "CodableView"
        ]
    ),
    .target(
        name: "ServerApp",
        dependencies: [
            "Models",
            .product(name: "Vapor", package: "vapor")
        ],
        swiftSettings: [
            // Enable better optimizations when building in Release configuration. Despite the use of
            // the `.unsafeFlags` construct required by SwiftPM, this flag is recommended for Release
            // builds. See <https://github.com/swift-server/guides#building-for-production> for details.
            .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
        ]
    ),
    .target(
        name: "server",
        dependencies: [
            "ServerApp",
            .product(name: "Vapor", package: "vapor")
        ]
    )
])
