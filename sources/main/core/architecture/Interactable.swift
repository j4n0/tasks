
public protocol Interactable {
    associatedtype Output
    var output: ((Output) -> Void) { get set }
}
