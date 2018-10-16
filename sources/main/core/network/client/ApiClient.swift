
import os
import UIKit

//- A generic API client. This will be subclassed for real clients.
public class ApiClient
{
    let session: URLSessionProtocol
    let baseURL: URL
    
    init(session: URLSessionProtocol, baseURL: URL) {
        self.session = session
        self.baseURL = baseURL
    }
    
    // Fetch the given HTTP resource and call completion.
    func fetch<T: Decodable>(resource: Resource, completion: @escaping ApiResultCompletion<T>)
    {
        // invalid request
        guard let request = URLRequest(resource: resource, baseURL: baseURL) else {
            completion(.error(RequestError.invalidEndpointDefinition(resource, baseURL)))
            return
        }
        
        os_log("Request URL: %@", "\(request.url as Any)")
        os_log("Request method: %@", "\(request.httpMethod as Any)")
        os_log("Request headers: %@", "\(request.allHTTPHeaderFields as Any)")
        
        let task: URLSessionDataTaskProtocol = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in

            // error executing the request
            if let e = error {
                completion(ApiResult.error(RequestError.urlLoading(e)))
                return
            }
            
            // request executed correctly but it reported an HTTP error
            let httpResponse = response as! HTTPURLResponse
            guard 200...299 ~= httpResponse.statusCode else {
                self.logResponse(data: data, response: httpResponse)
                completion(ApiResult.error(RequestError.httpStatus(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                self.logResponse(data: nil, response: httpResponse)
                completion(ApiResult.error(RequestError.noDataReturned))
                return
            }
            
            // parse and return the response
            let result: ApiResult<T> = self.parse(data)
            self.logResponse(data: data, response: httpResponse)
            completion(result)
        }
        
        task.resume()
    }
    
    private func parse<T: Decodable>(_ data: Data) -> ApiResult<T> {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let object = try decoder.decode(T.self, from: data)
            return .success(object)
        } catch let e {
            let wrappedError = RequestError.parsing(e)
            return .error(wrappedError)
        }
    }
    
    // remove-me
    private func logResponse(data: Data?, response: HTTPURLResponse){
        response.url.flatMap {
            os_log(.debug, log: OSLog.default, "URL %@", $0.absoluteString)
        }
        os_log(.debug, log: OSLog.default, "HTTP status: %d", response.statusCode)
        os_log(.debug, log: OSLog.default, "Response headers: %@", response.allHeaderFields)
        if let data = data {
            os_log(.debug, log: OSLog.default, "Data: %d bytes", data.count)
            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers),
                let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions.prettyPrinted),
                let string = String(data: jsonData, encoding: String.Encoding.utf8)
            {
                os_log(.debug, log: OSLog.default, "%@", string)
            }
            else if let body = String(data: data, encoding: .utf8)
            {
                os_log(.debug, log: OSLog.default, "Response body: %@", body)
            }
        }
    }
}
