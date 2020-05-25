package com.guioliveiraapps.wkm.utilities

import android.util.Log
import android.view.View
import androidx.test.espresso.Espresso
import androidx.test.espresso.IdlingResource
import androidx.test.espresso.IdlingResource.ResourceCallback
import androidx.test.espresso.ViewFinder
import org.hamcrest.Matcher


class ViewShownIdlingResource(private val viewMatcher: Matcher<View>, private var startTime: Long) :
    IdlingResource {
    private var resourceCallback: ResourceCallback? = null

    override fun isIdleNow(): Boolean {
        val view: View? =
            getView(
                viewMatcher
            )
        var idle: Boolean = view == null || view.isShown

        val now: Long = System.currentTimeMillis()

        val seconds = (now - startTime) / 1000

        if (seconds > 30) {
            Log.d("Test", "Took more than 30 seconds to find the search_view.")
            idle = true
        }

        if (idle && resourceCallback != null) {
            resourceCallback!!.onTransitionToIdle()
        }
        return idle
    }

    override fun registerIdleTransitionCallback(resourceCallback: ResourceCallback) {
        this.resourceCallback = resourceCallback
    }

    override fun getName(): String {
        return this.toString() + viewMatcher.toString()
    }

    companion object {
        private fun getView(viewMatcher: Matcher<View>): View? {
            return try {
                val viewInteraction = Espresso.onView(viewMatcher)
                val finderField = viewInteraction.javaClass.getDeclaredField("viewFinder")
                finderField.isAccessible = true
                val finder = finderField[viewInteraction] as ViewFinder
                finder.view
            } catch (e: Exception) {
                null
            }
        }
    }

}