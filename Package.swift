// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "ItemPosterPublishPlugin",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "ItemPosterPublishPlugin",
            targets: ["ItemPosterPublishPlugin"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.9.0"),
        .package(name: "Raster", url: "https://github.com/alexito4/Raster.git", from: "0.0.2")
    ],
    targets: [
        .target(
            name: "ItemPosterPublishPlugin",
            dependencies: ["Publish", "Raster"]
        )
    ]
)
