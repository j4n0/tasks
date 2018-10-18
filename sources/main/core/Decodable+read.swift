
import Foundation
import os

private final class Dummy {}

extension Decodable
{
    public static func decodeJsonFile(resource: String, withExtension ext: String, bundle: Bundle? = nil) -> Self? {
        
        guard let url = (bundle ?? Bundle(for: Dummy.self)).url(forResource: resource, withExtension: ext) else {
            os_log(.error, log: OSLog.default, "Mising JSON file %@.%@", resource, ext)
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            os_log(.error, log: OSLog.default, "Couldn’t read JSON file %@", "\(url)")
            return nil
        }
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(self, from: data)
        } catch let error {
            os_log(.error, log: OSLog.default, "Couldn’t decode %@ from file %@. Error: %@", "\(self)", "\(url)", "\(error)")
            return nil
        }
    }
}
