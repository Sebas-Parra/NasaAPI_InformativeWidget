package com.example.earth_api

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews

class NasaWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {

            val views = RemoteViews(
                context.packageName,
                R.layout.nasa_widget
            )

            // Textos del widget
            views.setTextViewText(R.id.title, "NASA Space")
            views.setTextViewText(R.id.subtitle, "Galaxies & Nebulae")
            views.setTextViewText(R.id.mainText, "Explore the cosmos")
            views.setTextViewText(R.id.hint, "Tap to open the app")

            // Abrir la app al tocar el widget
            val launchIntent: Intent? =
                context.packageManager.getLaunchIntentForPackage(
                    context.packageName
                )

            val pendingIntent = PendingIntent.getActivity(
                context,
                0,
                launchIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )

            views.setOnClickPendingIntent(
                R.id.widget_root,
                pendingIntent
            )

            appWidgetManager.updateAppWidget(
                appWidgetId,
                views
            )
        }
    }
}
