package com.guioliveiraapps.btg

import android.view.KeyEvent
import android.view.View
import android.widget.AutoCompleteTextView
import androidx.test.espresso.Espresso
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.IdlingRegistry
import androidx.test.espresso.IdlingResource
import androidx.test.espresso.action.ViewActions.*
import androidx.test.espresso.assertion.ViewAssertions
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.matcher.ViewMatchers
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
class ExchangeFragmentTest {

    @Rule
    @JvmField
    var activityRule: ActivityTestRule<MainActivity> = ActivityTestRule(MainActivity::class.java)

    @Test
    fun searchCurrency() {
        waitViewShown(withId(R.id.et_valor))

        onView(withId(R.id.et_valor)).perform(typeText("11"))

        onView(withId(R.id.txt_final_value)).check(matches(withText("11.0")))
    }

    private fun waitViewShown(matcher: Matcher<View>) {
        val idlingResource: IdlingResource =
            ViewShownIdlingResource(
                matcher,
                System.currentTimeMillis()
            )
        try {
            IdlingRegistry.getInstance().register(idlingResource)
            Espresso.onView(matcher).check(ViewAssertions.matches(ViewMatchers.isDisplayed()))
        } finally {
            IdlingRegistry.getInstance().unregister(idlingResource)
        }
    }
}