package com.hotmail.fignunes.btg.presentation.currencies

import android.content.Intent
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.action.ViewActions.click
import androidx.test.espresso.action.ViewActions.swipeUp
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.matcher.ViewMatchers.*
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.filters.LargeTest
import androidx.test.rule.ActivityTestRule
import com.hotmail.fignunes.btg.R
import com.hotmail.fignunes.btg.model.ChooseCurrency
import com.hotmail.fignunes.btg.presentation.quotedollar.QuoteDollarActivity
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@LargeTest
@RunWith(AndroidJUnit4::class)
class CurrenciesTest {
    @Rule
    @JvmField
    var activityTestRule = ActivityTestRule(CurrenciesActivity::class.java, false, false)

    @Before
    fun setup() {
        val intent = Intent()
        intent.putExtra(QuoteDollarActivity.CHOOSE_CURRENCY, ChooseCurrency.SOURCE.toString())
        activityTestRule.launchActivity(intent)
    }

    @Test
    fun fieldsVisible() {
        onView(withText(activityTestRule.activity.getString(R.string.list_of_currencies))).check(matches(isDisplayed()))
        onView(withId(R.id.currenciesChooseCurrency)).check(matches(isDisplayed()))
        onView(withId(R.id.recyclerviewCurrencies)).check(matches(isDisplayed()))
        Thread.sleep(1000)
    }

    @Test
    fun swipeList() {
        Thread.sleep(1000)
        onView(withId(R.id.recyclerviewCurrencies)).perform(swipeUp(), click())
        Thread.sleep(1000)
    }
}