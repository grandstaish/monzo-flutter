import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        OauthPlugin.register(with: registrar(forPlugin: "FLMOauthPlugin"))
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return true
        }
        var pathComponents = components.path.components(separatedBy: "/")
        pathComponents.removeFirst()
        switch pathComponents[0] {
        case "-magic-auth":
            OauthPlugin.onRedirect(uri: url.absoluteString)
        default:
            break
        }
        return true
    }
}
