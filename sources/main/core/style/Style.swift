
import UIKit

protocol Style {
    var headline: (UILabel)->() { get }
}

public struct StyleElements: Codable
{
    let separator: HexColor
    let background: HexColor
    let button: HexColor
    
    enum CodingKeys: String, CodingKey {
        case background
        case button
        case separator
    }
    
    init(separator: HexColor, background: HexColor, button: HexColor){
        self.separator = separator
        self.background = background
        self.button = button
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.background  = HexColor(stringLiteral: try container.decode(String.self, forKey: .background))
        self.button  = HexColor(stringLiteral: try container.decode(String.self, forKey: .button))
        self.separator  = HexColor(stringLiteral: try container.decode(String.self, forKey: .separator))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.background.stringValue, forKey: .background)
        try container.encode(self.button.stringValue, forKey: .button)
        try container.encode(self.separator.stringValue, forKey: .separator)
    }
}

public struct HexColor: Codable, ExpressibleByStringLiteral
{
    private let string: String
    
    public var stringValue: String {
        return string
    }
    
    public init(stringLiteral value: String) {
        string = value
    }
    
    public func color() -> UIColor {
        return UIColor.init(hexString: string)
    }
}
