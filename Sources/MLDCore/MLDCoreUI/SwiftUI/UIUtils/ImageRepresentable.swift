
import SwiftUI

public protocol ImageRepresentableContract {
    var source: ImageRepresentableSource { get }
    var contentMode: ContentMode { get }
}

// MARK: - Builders
public extension ImageRepresentable {
    static func systemName(_ name: String, contentMode: ContentMode = .fit) -> Self{
        ImageRepresentable(source: .systemName(name), contentMode: contentMode)
    }
    static func localName(_ name: String, contentMode: ContentMode = .fit) -> Self{
        ImageRepresentable(source: .localName(name), contentMode: contentMode)
    }
    static func uiImage(_ uiImage: UIImage, contentMode: ContentMode = .fit) -> Self{
        ImageRepresentable(source: .uiImage(uiImage), contentMode: contentMode)
    }
    static func image(_ image: Image, contentMode: ContentMode = .fit) -> Self{
        ImageRepresentable(source: .image(image), contentMode: contentMode)
    }
}

// MARK: - Getters
public extension ImageRepresentableContract {
    @MainActor var image: Image? {
        switch source {
        case .systemName(let name):
            Image(systemName: name)
        case .localName(let name):
            Image(name)
        case .uiImage(let uiImage):
            Image(uiImage: uiImage)
        case .image(let image):
            image
        }
    }
    
    @MainActor var uiImage: UIImage? {
        switch source {
        case .systemName(let name):
            return UIImage(systemName: name)
        case .localName(let name):
            return UIImage(named: name)
        case .uiImage(let uiImage):
            return uiImage
        case .image(let image):
            let renderer = ImageRenderer(content: image)
            return renderer.uiImage
        }
    }
}

// MARK: - Defaults
public extension ImageRepresentableContract {
    var contentMode: ContentMode { .fit }
}

public struct ImageRepresentable: ImageRepresentableContract, Sendable {
    public let source: ImageRepresentableSource
    public let contentMode: ContentMode
    
    public init(source: ImageRepresentableSource, contentMode: ContentMode) {
        self.source = source
        self.contentMode = contentMode
    }
}

public enum ImageRepresentableSource {
    case systemName(String)
    case localName(String)
    case uiImage(UIImage)
    case image(Image)
}

struct Mec: View {
    var body: some View {
        Text("")
            .scaledToFit()
    }
}
