package br.com.btg.test

import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.action.ViewActions.click
import androidx.test.espresso.matcher.ViewMatchers.withId
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.rule.ActivityTestRule
import br.com.btg.test.feature.currency.ui.CurrencyActivity
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith


@RunWith(AndroidJUnit4::class)
class ExampleInstrumentedTest {

    @get:Rule
    var mActivityRule = ActivityTestRule(CurrencyActivity::class.java, false, false)

    @Test
    fun test101ClickConvert() {
        onView(withId(R.id.convertValue))
            .perform(click())
    }
}