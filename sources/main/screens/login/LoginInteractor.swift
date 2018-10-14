
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
        environment.authenticatingClient.accessToken(authenticationCode: code) { (result) in
            switch result {
            case .success(let response):
                guard let accessToken = response.accessToken, let company = response.installation?.company.name else {
                    self.coordinator.alert(title: "Error", message: "The server didn’t return authentication data.", okAction: { (action) in
                        self.coordinator.show(screen: .login)
                    })
                    return
                }
                environment.store.authentication = Authentication(company: company, accessToken: accessToken )
                DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(2), execute: {
                    // let the user read the Login Successful message.
                    self.coordinator.show(screen: .tasks)
                })
            case .error(let e):
                os_log(.debug, log: OSLog.default, "Downloading all tasks: ", e.localizedDescription)
            }
        }
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


