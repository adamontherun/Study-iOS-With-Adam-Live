//Some text.

import UIKit
import MobileCoreServices

class Photo: NSObject {

    let image: UIImage
    
    required init(image: UIImage) {
        self.image = image
    }
}

extension Photo: NSItemProviderReading {
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [kUTTypePNG as String, kUTTypeJPEG as String]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
        switch typeIdentifier {
        case kUTTypePNG as NSString as String, kUTTypeJPEG as NSString as String:
            guard let image = UIImage(data: data) else { throw PhotoError.cantMakePhoto }
            return self.init(image: image)
        default:
            throw PhotoError.cantMakePhoto
        }
    }
}

extension Photo: NSItemProviderWriting {
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [kUTTypePNG as String, kUTTypeJPEG as String]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        switch typeIdentifier {
        case kUTTypePNG as NSString as String:
            DispatchQueue.main.asyncAfter(deadline: .now()+2.5, execute: {
                completionHandler(UIImagePNGRepresentation(self.image), nil)
            })
        case kUTTypeJPEG as NSString as String:
             completionHandler(UIImageJPEGRepresentation(image, 0.70), nil)
        default:
            completionHandler(nil, PhotoError.cantMakePhoto)
        }
        return nil
    }
    
}
