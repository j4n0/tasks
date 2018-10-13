
import os
import WebKit

class LoginViewController: UIViewController
{
    private var webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    
    let navigationDelegate: AnyObject & WKNavigationDelegate
    private let url: URL
    
    init(url: URL, navigationDelegate: AnyObject & WKNavigationDelegate){
        self.url = url
        self.navigationDelegate = navigationDelegate
        super.init(nibName: nil, bundle: nil)
        webView.navigationDelegate = self.navigationDelegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPage(url: url)
    }
    
    private func loadPage(url: URL){
        let request = URLRequest(url: LoginDetails.loginURL)
        webView.load(request)
    }
}
