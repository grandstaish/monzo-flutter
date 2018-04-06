package com.monzo.monzoclient

import android.support.customtabs.CustomTabsClient
import android.support.customtabs.CustomTabsServiceConnection
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import android.content.ComponentName
import android.net.Uri
import android.support.customtabs.CustomTabsSession
import android.support.customtabs.CustomTabsIntent

class OauthPlugin private constructor(private val registrar: Registrar) :
    CustomTabsServiceConnection(),
    MethodCallHandler
{
  companion object {
    private lateinit var channel: MethodChannel
    private lateinit var plugin: OauthPlugin

    fun registerWith(registrar: Registrar) {
      plugin = OauthPlugin(registrar)
      channel = MethodChannel(registrar.messenger(), "com.monzo/oauthPlugin")
      channel.setMethodCallHandler(plugin)
    }

    fun onRedirect(uri: String) {
      channel.invokeMethod("onRedirect", mapOf("uri" to uri))
    }
  }

  private var uri: Uri? = null
  private var tabsSession: CustomTabsSession? = null

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "connect" -> {
        connect()
      }
      "setUrl" -> {
        uri = Uri.parse(call.argument("url"))
        tryLoad()
      }
      "launch" -> {
        checkNotNull(uri) { "Must call setUrl before launch!" }
        val tabsIntent = CustomTabsIntent.Builder(tabsSession)
            .setToolbarColor(registrar.activeContext().getColor(R.color.dark_blue))
            .build()
        tabsIntent.launchUrl(registrar.activeContext(), uri)
      }
      "disconnect" -> {
        disconnect()
      }
    }
  }

  override fun onCustomTabsServiceConnected(name: ComponentName, client: CustomTabsClient) {
    client.warmup(0)
    tabsSession = client.newSession(null)
    if (uri != null) {
      tryLoad()
    }
  }

  override fun onServiceDisconnected(name: ComponentName) {
    tabsSession = null
  }

  private fun tryLoad() {
    tabsSession?.mayLaunchUrl(uri, null, null)
  }

  private fun connect() {
    val tabsPackage = CustomTabsClient.getPackageName(registrar.activeContext(), null)
    CustomTabsClient.bindCustomTabsService(registrar.activeContext(), tabsPackage, this)
  }

  private fun disconnect() {
    registrar.activeContext().unbindService(this)
  }
}
