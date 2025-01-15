package app.nextlevel

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetPlugin

class TaskWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        for (appWidgetId in appWidgetIds) {
            val widgetData = HomeWidgetPlugin.getData(context)
            val taskCount = widgetData.getInt("taskCount", -1)
            val taskCountText = if (taskCount == -1) "Waiting" else "Uncompleted Tasks\n$taskCount"
            
            val views = RemoteViews("app.nextlevel", R.layout.task_widget).apply {
                setTextViewText(R.id.task_count_text, taskCountText)
            }
            
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}