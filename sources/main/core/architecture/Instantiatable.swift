
public protocol Instantiatable
{
    associatedtype Input
    associatedtype Environment
    var environment: Environment { get }
    init(with input: Input, environment: Environment)
}

public extension Instantiatable {
    public static func instantiate(_ input: Input, environment: Environment) -> Self {
        return Self.init(with: input, environment: environment)
    }
}

public extension Instantiatable where Input == Void {
    public static func instantiate(environment: Environment) -> Self {
        return Self.init(with: (), environment: environment)
    }
}
