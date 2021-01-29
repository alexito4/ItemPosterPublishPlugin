// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ItemPosterPublishPlugin",
    platforms: [.macOS(.v11)],
    products: [
        .library(
            name: "ItemPosterPublishPlugin",
            targets: ["ItemPosterPublishPlugin"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.7.0"),
        .package(name: "Raster", url: "https://github.com/alexito4/Raster.git", from: "0.0.1")
    ],
    targets: [
        .target(
            name: "ItemPosterPublishPlugin",
            dependencies: ["Publish", "Raster"]
        )
    ]
)
