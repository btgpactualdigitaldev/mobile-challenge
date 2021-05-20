package com.renderson.currency_converter.ui.convert

import android.view.View
import android.view.ViewGroup
import androidx.test.espresso.Espresso.onData
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.action.ViewActions.*
import androidx.test.espresso.matcher.RootMatchers
import androidx.test.espresso.matcher.ViewMatchers.*
import androidx.test.filters.LargeTest
import androidx.test.rule.ActivityTestRule
import androidx.test.runner.AndroidJUnit4
import com.renderson.currency_converter.R
import com.renderson.currency_converter.ui.main.MainActivity
import org.hamcrest.Description
import org.hamcrest.Matcher
import org.hamcrest.Matchers.*
import org.hamcrest.TypeSafeMatcher
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@LargeTest
@RunWith(AndroidJUnit4::class)
class ConvertCurrencyFragmentTest {

    @Rule
    @JvmField
    var mActivityTestRule = ActivityTestRule(MainActivity::class.java)

    @Test
    fun mainActivityTest2() {
        val appCompatSpinner = onView(
                allOf(
                        withId(R.id.spOrigin),
                        childAtPosition(
                                childAtPosition(
                                        withId(R.id.ogCurrency),
                                        0
                                ),
                                1
                        ),
                        isDisplayed()
                )
        )
        appCompatSpinner.perform(click())

        val materialTextView = onData(anything())
                .inRoot(RootMatchers.isPlatformPopup())
                .atPosition(7)
        materialTextView.perform(click())

        val textInputEditText = onView(
                allOf(
                        withId(R.id.amount),
                        isDisplayed()
                )
        )
        textInputEditText.perform(replaceText("50"), closeSoftKeyboard())

        val appCompatSpinner2 = onView(
                allOf(
                        withId(R.id.spDestination),
                        childAtPosition(
                                childAtPosition(
                                        withId(R.id.destCurrency),
                                        0
                                ),
                                1
                        ),
                        isDisplayed()
                )
        )
        appCompatSpinner2.perform(click())

        val materialTextView2 = onData(anything())
                .inRoot(RootMatchers.isPlatformPopup())
                .atPosition(5)
        materialTextView2.perform(click())

        val materialButton2 = onView(
                allOf(
                        withId(R.id.btnConverter), withText("converter"),
                        childAtPosition(
                                childAtPosition(
                                        withId(R.id.destCurrency),
                                        0
                                ),
                                2
                        ),
                        isDisplayed()
                )
        )
        materialButton2.perform(click())
    }

    private fun childAtPosition(
            parentMatcher: Matcher<View>, position: Int
    ): Matcher<View> {

        return object : TypeSafeMatcher<View>() {
            override fun describeTo(description: Description) {
                description.appendText("Child at position $position in parent ")
                parentMatcher.describeTo(description)
            }

            public override fun matchesSafely(view: View): Boolean {
                val parent = view.parent
                return parent is ViewGroup && parentMatcher.matches(parent)
                        && view == parent.getChildAt(position)
            }
        }
    }
}
