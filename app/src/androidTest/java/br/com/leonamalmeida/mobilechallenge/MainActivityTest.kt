package br.com.leonamalmeida.mobilechallenge

import androidx.test.core.app.ActivityScenario
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.action.ViewActions.click
import androidx.test.espresso.intent.Intents
import androidx.test.espresso.intent.Intents.intended
import androidx.test.espresso.intent.matcher.IntentMatchers.hasComponent
import androidx.test.espresso.matcher.ViewMatchers.withId
import androidx.test.ext.junit.runners.AndroidJUnit4
import br.com.leonamalmeida.mobilechallenge.ui.currency.CurrencyActivity
import br.com.leonamalmeida.mobilechallenge.ui.main.MainActivity
import org.junit.After
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith


/**
 * Created by Leo Almeida on 30/06/20.
 */

@RunWith(AndroidJUnit4::class)
class MainActivityTest {

    @Before
    fun init() {
        Intents.init()
        ActivityScenario.launch(MainActivity::class.java)
    }

    @After
    fun release() {
        Intents.release()
    }

    @Test
    fun clickingOrigin_shouldStartCurrencyActivity() {
        onView(withId(R.id.originTv)).perform(click())
        intended(hasComponent(CurrencyActivity::class.java.name))
    }

    @Test
    fun clickingDestiny_shouldStartCurrencyActivity() {
        onView(withId(R.id.originTv)).perform(click())
        intended(hasComponent(CurrencyActivity::class.java.name))
    }
}