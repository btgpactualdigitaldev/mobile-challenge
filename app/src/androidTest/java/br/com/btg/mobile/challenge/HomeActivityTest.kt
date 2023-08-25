package br.com.btg.mobile.challenge

import androidx.test.core.app.ActivityScenario
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.Espresso.pressBack
import androidx.test.espresso.action.ViewActions.click
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.matcher.ViewMatchers.isDisplayed
import androidx.test.espresso.matcher.ViewMatchers.withId
import androidx.test.internal.runner.junit4.AndroidJUnit4ClassRunner
import br.com.btg.mobile.challenge.ui.HomeActivity
import org.junit.Assert
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4ClassRunner::class)
class HomeActivityTest {

    @Before
    fun setUp() {
        ActivityScenario.launch(HomeActivity::class.java)
    }

    @Test
    fun givenLaunchActivity_whenLauncher_thenCheckComponents() {

        Assert.assertNotNull(R.id.appBar)
        Assert.assertNotNull(R.id.toolbar)
        Assert.assertNotNull(R.id.nav_host_fragment_content)

        onView(withId(R.id.appBar)).check(matches(isDisplayed()))
        onView(withId(R.id.toolbar)).check(matches(isDisplayed()))
        onView(withId(R.id.nav_host_fragment_content)).check(
            matches(
                isDisplayed()
            )
        )
    }

    @Test
    fun givenLaunchActivity_whenInflateFragment_thenCheckComponentsFragment() {
        onView(withId(R.id.tv_title)).check(matches(isDisplayed()))
        onView(withId(R.id.sp_coin1)).check(matches(isDisplayed()))
        onView(withId(R.id.edt_value)).check(
            matches(
                isDisplayed()
            )
        )
        onView(withId(R.id.sp_coin2)).check(
            matches(
                isDisplayed()
            )
        )
        onView(withId(R.id.tv_result)).check(
            matches(
                isDisplayed()
            )
        )
        onView(withId(R.id.fab_list_coins)).check(
            matches(
                isDisplayed()
            )
        )
    }

    @Test
    fun givenLaunchActivity_whenFragmentAndNavigation_thenCheckComponentsFragment() {

        onView(withId(R.id.fab_list_coins)).perform(click())

        onView(withId(R.id.recyclerCorrected)).check(matches(isDisplayed()))
        onView(withId(R.id.progress)).check(matches(isDisplayed()))

        pressBack()

        onView(withId(R.id.tv_title)).check(matches(isDisplayed()))
        onView(withId(R.id.sp_coin1)).check(matches(isDisplayed()))
        onView(withId(R.id.edt_value)).check(
            matches(
                isDisplayed()
            )
        )
        onView(withId(R.id.sp_coin2)).check(
            matches(
                isDisplayed()
            )
        )
        onView(withId(R.id.tv_result)).check(
            matches(
                isDisplayed()
            )
        )
        onView(withId(R.id.fab_list_coins)).check(
            matches(
                isDisplayed()
            )
        )
    }
}
