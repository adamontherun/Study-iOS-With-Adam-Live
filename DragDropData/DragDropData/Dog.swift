//Some text.

import UIKit
import MobileCoreServices

let dogTypeIdentifier = "com.wooffactory.test"

final class Dog: NSObject {
    
    let maxBarkVolume: Int?
    var image: UIImage
    
    init(image: UIImage, maxBarkVolume: Int?) {
        self.maxBarkVolume = maxBarkVolume
        self.image = image
    }
}

extension Dog: NSItemProviderReading {
    static var readableTypeIdentifiersForItemProvider: [String] {
       return [dogTypeIdentifier, kUTTypePNG as String]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
        switch typeIdentifier {
        case dogTypeIdentifier:
            guard let dog = NSKeyedUnarchiver.unarchiveObject(with: data) as? Dog else {
                throw DogError.cantMakeDog }
            return self.init(image: dog.image, maxBarkVolume: dog.maxBarkVolume)
        case kUTTypePNG as NSString as String:
            guard let image = UIImage(data: data) else { throw DogError.cantMakeDog }
            return self.init(image: image, maxBarkVolume: nil)
        default:
            throw DogError.cantMakeDog
        }
    }
}

extension Dog: NSItemProviderWriting {
    static var writableTypeIdentifiersForItemProvider: [String] {
        return [dogTypeIdentifier, kUTTypePNG as String]
    }
    
    func loadData(withTypeIdentifier typeIdentifier: String, forItemProviderCompletionHandler completionHandler: @escaping (Data?, Error?) -> Void) -> Progress? {
        switch typeIdentifier {
        case dogTypeIdentifier:
            let data = NSKeyedArchiver.archivedData(withRootObject: self)
            completionHandler(data, nil)
        case kUTTypePNG as NSString as String:
            completionHandler(UIImagePNGRepresentation(image), nil)
        default:
            completionHandler(nil, DogError.cantMakeDog)
        }
        return nil
    }
}

extension Dog: NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(image, forKey: "image")
        if let maxBarkVolume = maxBarkVolume {aCoder.encode(maxBarkVolume, forKey: "maxBarkVolume")}
    }
    
    convenience init?(coder aDecoder: NSCoder) {
        guard let dogImage = aDecoder.decodeObject(forKey: "image") as? UIImage else { return nil }
        let maxBarkVolume = aDecoder.decodeInteger(forKey: "maxBarkVolume")
        self.init(image: dogImage, maxBarkVolume: maxBarkVolume)
    }
    
    
}


