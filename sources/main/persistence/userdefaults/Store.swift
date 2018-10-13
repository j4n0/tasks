
import Foundation

public protocol StoreType: CustomDebugStringConvertible {
    var authentication: Authentication? { get set }
    func removeEverything()
}

public class Store<store: KeyValueStore>: NSObject, StoreType
{
    private func read<T>(for key: String) -> T? {
        return store.serializer.read(key) as? T
    }
    
    private func write(for key: String, value: Any?) {
        store.serializer.write(key, value)
    }
    
    @objc dynamic var company: String? {
        get { return read(for: #keyPath(company)) }
        set { write(for: #keyPath(company), value: newValue) }
    }
    
    @objc dynamic var authorizationHeader: [String: String]? {
        get { return read(for: #keyPath(authorizationHeader)) }
        set { write(for: #keyPath(authorizationHeader), value: newValue) }
    }
    
    // MARK: - StoreType
    
    @objc dynamic public var authentication: Authentication? {
        set {
            company = newValue?.company
            authorizationHeader = newValue?.authorizationHeader
        }
        get {
            guard let company = company, let header = authorizationHeader else { return nil }
            return Authentication(company: company, authorizationHeader: header)
        }
    }
    
    public func removeEverything(){
        authentication = nil
    }
}
