
import Foundation

extension String
{    
    /// "123\n456~|~789".splitByStrings(["\n", "~|~"]) returns ["123", "456", "789"]
    func splitByStrings(_ separators: [String]) -> [String] {
        return separators.reduce([self]) { result, separator in
            return result.flatMap { $0.components(separatedBy: separator) }
        }
    }
}
