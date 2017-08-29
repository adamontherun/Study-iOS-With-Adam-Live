//😘 it is 8/28/17

import Foundation

public struct BirdNameTranslator {
    public init() {}
    public static func translate(commonName: String)-> String? {
        if commonName == "Raven" {
            return "Corvus corax"
        } else {
            return nil
        }
    }
}
