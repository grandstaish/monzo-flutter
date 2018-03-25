package com.monzo.monzoclient

import android.content.ContentValues.TAG
import android.os.Bundle
import android.view.View

import io.flutter.app.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import android.graphics.drawable.Drawable
import android.content.pm.PackageManager
import android.content.res.Resources.NotFoundException
import android.util.Log
import android.util.TypedValue
import android.view.ViewGroup.LayoutParams
import android.view.ViewGroup
import io.flutter.view.FlutterView

private const val SPLASH_SCREEN_META_DATA_KEY = "com.monzo.monzoclient.SplashScreenUntilFirstFrame"

private val matchParent = LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT)

class MainActivity: FlutterActivity() {
  private var launchView: View? = null

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    launchView = createLaunchView()
    if (launchView != null) {
      addLaunchView()
    }
  }

  /**
   * Creates a [View] containing the same [Drawable] as the one set as the
   * `windowBackground` of the parent activity for use as a launch splash view.
   *
   * Returns null if no `windowBackground` is set for the activity.
   */
  private fun createLaunchView(): View? {
    if (!showSplashScreenUntilFirstFrame()) {
      return null
    }
    val launchScreenDrawable = getLaunchScreenDrawableFromActivityTheme() ?: return null
    val view = View(this)
    view.layoutParams = matchParent
    view.background = launchScreenDrawable
    return view
  }

  /**
   * Let the user specify whether the activity's `windowBackground` is a launch screen
   * and should be shown until the first frame via a <meta-data> tag in the activity.
  </meta-data> */
  private fun showSplashScreenUntilFirstFrame(): Boolean {
    return try {
      val activityInfo = packageManager.getActivityInfo(componentName, PackageManager.GET_META_DATA)
      val metadata = activityInfo.metaData
      metadata != null && metadata.getBoolean(SPLASH_SCREEN_META_DATA_KEY)
    } catch (e: PackageManager.NameNotFoundException) {
      false
    }
  }

  /**
   * Extracts a [Drawable] from the parent activity's `windowBackground`.
   *
   * `android:windowBackground` is specifically reused instead of a other attributes
   * because the Android framework can display it fast enough when launching the app as opposed
   * to anything defined in the Activity subclass.
   *
   * Returns null if no `windowBackground` is set for the activity.
   */
  private fun getLaunchScreenDrawableFromActivityTheme(): Drawable? {
    val typedValue = TypedValue()
    if (!theme.resolveAttribute(android.R.attr.windowBackground, typedValue, true)) {
      return null
    }
    if (typedValue.resourceId == 0) {
      return null
    }
    return try {
      resources.getDrawable(typedValue.resourceId, theme)
    } catch (e: NotFoundException) {
      Log.e(TAG, "Referenced launch screen windowBackground resource does not exist")
      null
    }
  }

  /**
   * Show and then automatically animate out the launch view.
   *
   * If a launch screen is defined in the user application's AndroidManifest.xml as the
   * activity's `windowBackground`, display it on top of the [FlutterView] and
   * remove the activity's `windowBackground`.
   *
   * Fade it out and remove it when the [FlutterView] renders its first frame.
   */
  private fun addLaunchView() {
    if (launchView == null) {
      return
    }

    addContentView(launchView, matchParent)
    flutterView.addFirstFrameListener(object : FlutterView.FirstFrameListener {
      override fun onFirstFrame() {
        (launchView?.parent as ViewGroup?)?.removeView(launchView)
        flutterView.removeFirstFrameListener(this)
      }
    })

    // Pure dark blue background
    window.setBackgroundDrawableResource(R.color.dark_blue)
  }
}
