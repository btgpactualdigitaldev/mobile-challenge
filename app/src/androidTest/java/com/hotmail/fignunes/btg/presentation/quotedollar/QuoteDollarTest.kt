package com.hotmail.fignunes.btg.presentation.quotedollar

import androidx.test.espresso.Espresso.*
import androidx.test.espresso.action.ViewActions.*
import androidx.test.espresso.assertion.ViewAssertions.*
import androidx.test.espresso.matcher.ViewMatchers.*
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.filters.LargeTest
import androidx.test.rule.ActivityTestRule
import com.hotmail.fignunes.btg.R
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@LargeTest
@RunWith(AndroidJUnit4::class)
class QuoteDollarTest {

    @Rule
    @JvmField
    var activityTestRule = ActivityTestRule(QuoteDollarActivity::class.java)

    @Test
    fun fieldsVisible() {
        onView(withText(activityTestRule.activity.getString(R.string.currency_converter))).check(matches(isDisplayed()))
        onView(withId(R.id.quoteDollarImage)).check(matches(isDisplayed()))
        onView(withId(R.id.buttonCurrencySource)).check(matches(isDisplayed()))
        onView(withId(R.id.buttonCurrencyDestiny)).check(matches(isDisplayed()))
        onView(withId(R.id.quoteDollarValue)).check(matches(isDisplayed()))
        onView(withId(R.id.quoteDollarValue)).check(matches(withHint(activityTestRule.activity.getString(R.string.insert_value))))
        onView(withId(R.id.quoteDollarConvertCurrencies)).check(matches(isDisplayed()))
        onView(withId(R.id.quoteDollarResult)).check(matches(isDisplayed()))
    }

    @Test
    fun buttonSourceClick() {
        onView(withId(R.id.buttonCurrencySource)).perform(click())

        Thread.sleep(2000)

        val message = activityTestRule.activity.getString(R.string.choose_the_currency_of_origin)
        onView(withId(R.id.currenciesChooseCurrency))
            .check(matches(withText(message)))
    }

    @Test
    fun buttonDestinyClick() {
        onView(withId(R.id.buttonCurrencyDestiny)).perform(click())

        Thread.sleep(2000)

        val message = activityTestRule.activity.getString(R.string.choose_the_target_currency)
        onView(withId(R.id.currenciesChooseCurrency))
            .check(matches(withText(message)))
    }
}