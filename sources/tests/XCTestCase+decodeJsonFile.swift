
import Foundation
import XCTest

extension XCTestCase
{
    private final class Dummy {}
    
    static func decodeJsonFile<T: Decodable>(resource: String, withExtension ext: String) -> T? {
        guard let url = Bundle(for: Dummy.self).url(forResource: resource, withExtension: ext) else {
            XCTFail("Mising JSON file.")
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            XCTFail("Couldn’t read JSON file \(url)")
            return nil
        }
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(T.self, from: data)
        } catch let error {
            XCTFail("Couldn’t decode \(T.self) from file \(url). Error: \(error)")
            return nil
        }
    }
}
