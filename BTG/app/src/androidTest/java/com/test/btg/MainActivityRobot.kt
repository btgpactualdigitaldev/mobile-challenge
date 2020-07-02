package com.test.btg

import android.content.Intent
import androidx.test.espresso.Espresso.onView
import androidx.test.espresso.assertion.ViewAssertions.matches
import androidx.test.espresso.matcher.RootMatchers.withDecorView
import androidx.test.espresso.matcher.ViewMatchers.isDisplayed
import androidx.test.espresso.matcher.ViewMatchers.withText
import androidx.test.rule.ActivityTestRule
import com.google.gson.Gson
import com.test.btg.repository.CurrencyApi
import com.test.core.model.Lives
import com.test.core.provider.provideRetrofit
import io.mockk.every
import io.mockk.mockk
import io.mockk.mockkStatic
import io.reactivex.Observable
import org.hamcrest.Matchers.`is`
import org.hamcrest.Matchers.not
import retrofit2.Response
import retrofit2.Retrofit


object MainActivityRobot {

    private const val MESSAGE_FAILURE = "falha"

    fun prepareSuccessCase(rule: ActivityTestRule<MainActivity>): MainActivityRobot {
        mockRequest(false)
        rule.launchActivity(Intent())
        Thread.sleep(1000)
        return this
    }

    fun prepareFailureCase(rule: ActivityTestRule<MainActivity>): MainActivityRobot {
        mockRequest(true)
        rule.launchActivity(Intent())
        return this
    }

    fun assertFirstItemListIsVisible(): MainActivityRobot {
        onView(withText("USDAED")).check(matches(isDisplayed()))
        onView(withText("3.672982")).check(matches(isDisplayed()))

        return this
    }

    fun assertLastItemIsVisible() {
        onView(withText("USDAZN")).check(matches(isDisplayed()))
        Thread.sleep(1000)
    }

    fun assertToastMessage(
        rule: ActivityTestRule<MainActivity>,
        message: String = MESSAGE_FAILURE
    ) {
        onView(withText(message)).inRoot(
            withDecorView(
                not(
                    `is`(
                        rule.activity.window.decorView
                    )
                )
            )
        ).check(matches(isDisplayed()))
    }

    private fun mockRequest(isFailure: Boolean) {
        mockkStatic("com.test.core.provider.RetrofitProviderKt")

        val mockLives = Gson().fromJson(json, Lives::class.java)
        val mockResponse = mockk<Response<Lives>>()
        val observable = Observable.just(mockResponse)
        val mockCurrencyApi = mockk<CurrencyApi>()

        val mockRetrofit = mockk<Retrofit>()

        every { provideRetrofit() } returns mockRetrofit
        every { mockRetrofit.create(CurrencyApi::class.java) } returns mockCurrencyApi
        every { mockCurrencyApi.requestLive() } returns if (isFailure) {
            Observable.error(IllegalStateException(MESSAGE_FAILURE))
        } else observable

        every { mockResponse.isSuccessful } returns true
        every { mockResponse.body() } returns mockLives
    }

    //deveria estar dentro de um file.json e ser lido de la...
    val json = "{\n" +
            "    \"success\": true,\n" +
            "    \"terms\": \"https://currencylayer.com/terms\",\n" +
            "    \"privacy\": \"https://currencylayer.com/privacy\",\n" +
            "    \"timestamp\": 1430401802,\n" +
            "    \"source\": \"USD\",\n" +
            "    \"quotes\": {\n" +
            "        \"USDAED\": 3.672982,\n" +
            "        \"USDAFN\": 57.8936,\n" +
            "        \"USDALL\": 126.1652,\n" +
            "        \"USDAMD\": 475.306,\n" +
            "        \"USDANG\": 1.78952,\n" +
            "        \"USDAOA\": 109.216875,\n" +
            "        \"USDARS\": 8.901966,\n" +
            "        \"USDAUD\": 1.269072,\n" +
            "        \"USDAWG\": 1.792375,\n" +
            "        \"USDAZN\": 1.04945\n" + " }}"

}