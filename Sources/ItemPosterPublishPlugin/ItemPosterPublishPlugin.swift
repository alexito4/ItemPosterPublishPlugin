import Publish
import Publish
import SwiftUI
import Raster
import Files

public extension Plugin {
    enum Error: Swift.Error {
        case jpegRepresentation
    }
    
    static var posterName: String { "poster.jpeg" }

    /// Generates a poster image for every item based on the given SwiftUI view.
    /// - Parameters:
    ///   - predicate: If true is returned the item imagePath is set.
    ///   - skipGeneration: If true is returned the image generation is skiped.
    ///   - viewForItem: Closure to return a SwiftUI view
    ///   - size: Size of the resulting image.
    ///   - saveImage: Closure to save the image.
    static func itemPosterPublishPlugin<V: View>(
        _ predicate: @escaping (Item<Site>, PublishingContext<Site>) -> Bool = { _, _ in true},
        skipGeneration: @escaping (Item<Site>, PublishingContext<Site>) -> Bool = { _, _ in false },
        viewForItem: @escaping (Item<Site>) -> V,
        size: CGSize = CGSize(width: 1600, height: 840),
        saveImage: @escaping (Item<Site>, Data, Publish.Path, PublishingContext<Site>) throws -> Void = Self.saveImageToOutput
    ) -> Self {
        Plugin(name: "ItemPosterPublishPlugin") { context in
            let localContext: PublishingContext<Site> = context
            try context.mutateAllSections { (section: inout Publish.Section) in
                try section.mutateItems { (item: inout Item) in
                    // Don't generate a poster if the Item already has an image associated.
                    guard item.imagePath == nil else {
                        return
                    }
                    
                    // Check if this item should have a poster
                    guard predicate(item, localContext) else {
                        return
                    }
                    
                    // Assign the poster to the item
                    let posterPath = item.path.appendingComponent(Self.posterName)
                    item.imagePath = posterPath
                    
                    // TODO: It should cache the image and avoid generating it every time, unless data has changed.
                    guard skipGeneration(item, localContext) == false else {
                        return
                    }
                                        
                    // Generate the poster
                    let image: NSBitmapImageRep = viewForItem(item).rasterizeBitmap(at: size)
                    guard let data = image.representation(using: .jpeg, properties: [:]) else {
                        throw Error.jpegRepresentation
                    }

                    // TODO: If Publish supported bundled posts and saving to the Content directory there should be
                    //       an option to save the image in the bundle.
                    
                    // Save the poster
                    try saveImage(item, data, posterPath, localContext)
                }
            }
        }
    }
    
    static func saveImageToOutput(
        item: Item<Site>,
        image data: Data,
        path: Publish.Path,
        context: PublishingContext<Site>
    ) throws {
        let file: File = try context.createOutputFile(at: path)
        try file.write(data)
    }
}
