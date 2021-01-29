# ItemPosterPublishPlugin

<a href="https://github.com/alexito4/ItemPosterPublishPlugin/actions?query=workflow%3ATest+branch%3Amaster
">
    <img src="https://github.com/alexito4/ReadingTimePublishPlugin/workflows/Test/badge.svg?branch=master" alt="Status" />
</a>
![Swift 5.3](https://img.shields.io/badge/Swift-5.3-orange.svg)
<a href="https://swift.org/package-manager">
    <img src="https://img.shields.io/badge/SwiftPM-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
</a>
![Mac](https://img.shields.io/badge/platforms-mac-brightgreen.svg?style=flat)
<a href="https://github.com/JohnSundell/Publish">
    <img src="https://img.shields.io/badge/Publish-Plugin-orange.svg?style=flat" alt="Publish Plugin" />
</a>
<a href="https://twitter.com/alexito4">
    <img src="https://img.shields.io/badge/twitter-@alexito4-blue.svg?style=flat" alt="Twitter: @alexito4" />
</a>

Create social images for your posts to have nice Twitter Cards. This is a plugin for [Publish](https://github.com/JohnSundell/Publish).

## Installation

Add the package to your SPM dependencies.

```swift
.package(name: "ItemPosterPublishPlugin", url: "https://github.com/alexito4/ItemPosterPublishPlugin", from: "0.0.1"),

```

## Usage

The plugin can then be used within any publishing pipeline like this:

```swift
import PublishReadingTime
...
try DeliciousRecipes().publish(using: [
    ...
    .addMarkdownFiles(),
    .installPlugin(
        .itemPosterPublishPlugin(
            viewForItem: { item in
                Poster(title: item.title)
            },
            size: CGSize(width: 1600, height: 840)
        )
    )
    ...
])
```
Note that it must be installed after the Items are created (in this case by `addMarkdownFiles()` ).

# Author

Alejandro Martinez | http://alejandromp.com | [@alexito4](https://twitter.com/alexito4)
