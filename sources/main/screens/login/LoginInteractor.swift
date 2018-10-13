
import Foundation
import os
import WebKit

struct LoginDetails {
    static let scheme = "tasks"
    static let loginCallback = "\(scheme)://logincallback"
    static let loginCodeQueryItem = "code"
    static let loginURL = URL(string: "https://www.teamwork.com/launchpad/login?redirect_uri=\(loginCallback)")!
}

class LoginInteractor: NSObject
{
    var coordinator: Coordinator
    
    init(coordinator: Coordinator){
        self.coordinator = coordinator
    }
    
    func update(with request: URLRequest) {
        guard let code = request.valueOfQueryItem(name: LoginDetails.loginCodeQueryItem) else {
            return
        }
        os_log("%@",code)
    }
}

extension LoginInteractor: WKNavigationDelegate
{
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
        update(with: navigationAction.request)
    }
}

fileprivate extension URLRequest
{
    /// - Returns the authentication code or nil
    func valueOfQueryItem(name: String) -> String? {
        return url
            .flatMap { URLComponents(url: $0, resolvingAgainstBaseURL: false) }
            .flatMap { $0.scheme == LoginDetails.scheme ? $0 : nil }
            .flatMap { $0.queryItems?.first { $0.name == name } }
            .flatMap { $0.value }
    }
}
