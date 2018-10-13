
//- all results will be encapsulated in this enum so we can switch on it
enum ApiResult<T> {
    case success(T)
    case error(RequestError)
}

//- the response block always passes the result as input parameter and returns nothing
typealias ApiResultCompletion<T> = (ApiResult<T>) -> Void
