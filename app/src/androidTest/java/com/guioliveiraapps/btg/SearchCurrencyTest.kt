package com.guioliveiraapps.btg

import android.view.KeyEvent
import android.view.View
import android.widget.AutoCompleteTextView
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.IdlingRegistry
import androidx.test.espresso.IdlingResource
import androidx.test.espresso.action.ViewActions.*
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.matcher.ViewMatchers.*
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.filters.LargeTest
import androidx.test.rule.ActivityTestRule
import com.guioliveiraapps.wkm.utilities.RecyclerViewItemCountAssertion
import com.guioliveiraapps.wkm.utilities.ViewShownIdlingResource
import org.hamcrest.Matcher
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
@LargeTest
class SearchCurrencyTest {

    @Rule
    @JvmField
    var activityRule: ActivityTestRule<MainActivity> = ActivityTestRule(MainActivity::class.java)

    @Test
    fun searchCurrency() {
        onView(withId(R.id.navigation_currencies)).perform(click())

        waitViewShown(withId(R.id.search_view))

        onView(isAssignableFrom(AutoCompleteTextView::class.java)).perform(typeText("sem resultados"))

        onView(isRoot()).perform(pressKey(KeyEvent.KEYCODE_SEARCH))

        onView(withId(R.id.rv_currencies)).check(RecyclerViewItemCountAssertion(0))

        onView(withId(R.id.txt_no_currencies)).check(matches(isDisplayed()))

        onView(withId(androidx.appcompat.R.id.search_close_btn)).perform(click())

        onView(isAssignableFrom(AutoCompleteTextView::class.java)).perform(typeText("united states dollar"))

        onView(isRoot()).perform(pressKey(KeyEvent.KEYCODE_SEARCH))

        onView(withId(R.id.rv_currencies)).check(RecyclerViewItemCountAssertion(1))

    }

    private fun waitViewShown(matcher: Matcher<View>) {
        val idlingResource: IdlingResource =
            ViewShownIdlingResource(
                matcher,
                System.currentTimeMillis()
            )
        try {
            IdlingRegistry.getInstance().register(idlingResource)
            onView(matcher).check(matches(isDisplayed()))
        } finally {
            IdlingRegistry.getInstance().unregister(idlingResource)
        }
    }
}