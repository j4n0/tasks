
import Foundation

// Build a URLRequest with the given resource and base URL.
extension URLRequest
{
    init?(resource: Resource, baseURL: URL){
        guard let url = URLRequest.createURL(for: resource, relativeTo: baseURL) else {
            return nil
        }
        self.init(url: url)
        httpMethod = resource.method.rawValue
        httpBody = resource.httpBody
    }
    
    private static func createURL(for resource: Resource, relativeTo baseURL: URL) -> URL? {
        var url = baseURL.appendingPathComponent(resource.path)
        if !resource.query.keys.isEmpty {
            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                return nil
            }
            components.queryItems = resource.query.map { URLQueryItem(name: $0.0, value: $0.1) }
            guard let newURL = components.url else {
                return nil
            }
            url = newURL
        }
        return url
    }
}

