package br.com.leonamalmeida.mobilechallenge

import androidx.test.core.app.ActivityScenario
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.action.ViewActions
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.matcher.ViewMatchers
import androidx.test.espresso.matcher.ViewMatchers.isDisplayed
import androidx.test.espresso.matcher.ViewMatchers.withText
import androidx.test.ext.junit.runners.AndroidJUnit4
import br.com.leonamalmeida.mobilechallenge.ui.currency.CurrencyActivity
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Created by Leo Almeida on 30/06/20.
 */

@RunWith(AndroidJUnit4::class)
class CurrencyActivityTest {

    @Before
    fun init() {
        ActivityScenario.launch(CurrencyActivity::class.java)
    }

    @Test
    fun searchInvalidCurrency_shouldDisplayNotFoundError() {
        onView(ViewMatchers.withId(R.id.searchTv)).perform(ViewActions.typeText("11111"))
        onView(withText(R.string.default_empty_list_text)).check(matches(isDisplayed()))
    }

    @Test
    fun searchCurrency_shouldDisplayResults() {
        onView(ViewMatchers.withId(R.id.searchTv)).perform(ViewActions.typeText("USD"))
        onView(withText("USD")).check(matches(isDisplayed()))
    }
}