//
//  OauthPlugin.swift
//  Runner
//
//  Created by Brad Campbell on 07/04/2018.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

import Foundation
import Flutter

public class OauthPlugin: NSObject, FlutterPlugin {
    private static var channel: FlutterMethodChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        channel = FlutterMethodChannel(name: "com.monzo/oauthPlugin", binaryMessenger: registrar.messenger())
        let plugin = OauthPlugin(channel: channel!)
        registrar.addMethodCallDelegate(plugin, channel: channel!)
    }
    
    public static func onRedirect(uri: String) {
        channel!.invokeMethod("onRedirect", arguments: ["uri": uri])
    }
    
    private var oauthChannel: FlutterMethodChannel?
    private var url: URL?
    
    init(channel: FlutterMethodChannel) {
        oauthChannel = channel
        super.init()
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "setUrl":
            let arguments = call.arguments as! Dictionary<String, Any?>
            url = URL(string: arguments["url"] as! String)
        case "launch":
            guard let url = url else {
                fatalError("url must be set before calling launch")
            }
            UIApplication.shared.openURL(url)
        default:
            break;
        }
    }
}
