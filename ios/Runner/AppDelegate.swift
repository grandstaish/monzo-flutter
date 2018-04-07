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
}
