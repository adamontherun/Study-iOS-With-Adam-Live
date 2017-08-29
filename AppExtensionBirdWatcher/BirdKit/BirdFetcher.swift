//😘 it is 8/28/17

import Foundation

public class BirdFetcher {
    
    public static func fetchFeaturedBirds() -> [UIImageView] {
        let bundle = Bundle(for: BirdFetcher.self)
        let image1 = UIImage(named: "sapsucker.jpg", in:bundle, compatibleWith: nil)!
        let imageView1 = UIImageView(image: image1)
        imageView1.contentMode = .scaleAspectFit
        let image2 = UIImage(named: "ruddyduck.jpg", in:bundle, compatibleWith: nil)!
        let imageView2 = UIImageView(image: image2)
        imageView2.contentMode = .scaleAspectFit
        let image3 = UIImage(named: "chippingsparrow.jpg", in:bundle, compatibleWith: nil)!
        let imageView3 = UIImageView(image: image3)
        imageView3.contentMode = .scaleAspectFit
        
        return [imageView1, imageView2, imageView3]
    }
    
}
