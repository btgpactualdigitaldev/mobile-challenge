package com.kaleniuk2.conversordemoedas.ui.activity

import android.content.Intent
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.action.ViewActions.click
import androidx.test.espresso.action.ViewActions.typeText
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.contrib.RecyclerViewActions
import androidx.test.espresso.matcher.ViewMatchers.*
import androidx.test.rule.ActivityTestRule
import com.kaleniuk2.conversordemoedas.R
import com.kaleniuk2.conversordemoedas.ui.adapter.ListCurrencyViewHolder


class HomeActivityPrepare(private val activity: ActivityTestRule<HomeActivity>) {
    fun launch() {
        activity.launchActivity(Intent())
    }
}

class HomeActivityRobots {
    fun clickFromButton() {
        onView(withText("Moeda de Origem")).perform(click())
    }

    fun clickToButton() {
        onView(withText("Moeda Destino")).perform(click())
    }

    fun clickToOptionBR() {
        onView(withId(R.id.recycler_currency)).perform(RecyclerViewActions.actionOnItem<ListCurrencyViewHolder>(
            hasDescendant(withText("BRL")),click()))
    }

    fun clickToOptionUSD() {
        onView(withId(R.id.recycler_currency)).perform(RecyclerViewActions.actionOnItem<ListCurrencyViewHolder>(
            hasDescendant(withText("USD")),click()))
    }

    fun typeTextInEditTextCurrency() {
        onView(withId(R.id.et_select_value))
            .perform(typeText("100"))
    }

    fun clickInConvert() {
        onView(withText("Converter")).perform(click())
    }

    fun clickInInvert() {
        onView(withId(R.id.invert)).perform(click())
    }

}

class HomeActivityRobotsValidate {
    fun validateDisplayedButtonBR() {
        onView(withText("Brazilian Real"))
            .check(matches(isDisplayed()))
    }

    fun validateDisplayedButtonUSD() {
        onView(withText("United States Dollar"))
            .check(matches(isDisplayed()))
    }

    fun validateEditTextCurrency() {
        onView(withId(R.id.et_select_value)).check(matches(withText("1,00")))
    }

    fun validateResultRealToDolar() {
        onView(withId(R.id.tv_result)).check(matches(withText("USD 0.19")))
    }

    fun validateResultDolarToReal() {
        onView(withId(R.id.tv_result)).check(matches(withText("BRL 5.50")))
    }
}


