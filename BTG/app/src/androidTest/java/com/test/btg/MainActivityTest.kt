package com.test.btg

import androidx.test.rule.ActivityTestRule
import androidx.test.runner.AndroidJUnit4
import com.test.btg.MainActivityRobot.prepareFailureCase
import com.test.btg.MainActivityRobot.prepareSuccessCase
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
class MainActivityTest {

    @get :Rule
    var rule: ActivityTestRule<MainActivity> =
        ActivityTestRule(MainActivity::class.java, false, false)


    @Test
    fun whenCallIsSuccessful_ShouldShowValuesOnList() {
        prepareSuccessCase(rule)
            .assertFirstItemListIsVisible()
            .assertLastItemIsVisible()
    }

    @Test
    fun whenCallIsFailure_ShouldShowErrorType() {
        prepareFailureCase(rule)
            .assertToastMessage(rule)
    }

}
