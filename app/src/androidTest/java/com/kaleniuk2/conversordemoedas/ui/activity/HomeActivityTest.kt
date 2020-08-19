package com.kaleniuk2.conversordemoedas.ui.activity

import androidx.test.espresso.intent.rule.IntentsTestRule
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.kaleniuk2.conversordemoedas.data.remote.CurrencyRemoteDataSource
import com.kaleniuk2.conversordemoedas.util.loadData
import okhttp3.mockwebserver.Dispatcher
import okhttp3.mockwebserver.MockResponse
import okhttp3.mockwebserver.MockWebServer
import okhttp3.mockwebserver.RecordedRequest
import org.junit.After
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith


@RunWith(AndroidJUnit4::class)
class HomeActivityTest {

    @Rule
    @JvmField
    val rule = IntentsTestRule(HomeActivity::class.java, true, false)

    private fun prepare(func: HomeActivityPrepare.() -> Unit) =
        HomeActivityPrepare(rule).apply(func)

    private fun execute(func: HomeActivityRobots.() -> Unit) = HomeActivityRobots().apply(func)

    private fun validate(func: HomeActivityRobotsValidate.() -> Unit) =
        HomeActivityRobotsValidate().apply(func)

    private lateinit var server: MockWebServer

    @Before
    fun before() {
        server = MockWebServer()
        server.start(8080)
        CurrencyRemoteDataSource.changeUrlForTesting()
    }

    @After
    fun after() {
        server.shutdown()
    }

    @Test
    fun when_select_correct_options_and_put_correct_data_should_show_converted_value() {
        prepare {
            launch()
            mockSuccessResponses()
        }

        execute {
            clickFromButton()
            clickToOptionBR()
        }

        validate {
            validateDisplayedButtonBR()
        }

        execute {
            clickToButton()
            clickToOptionUSD()
        }

        validate {
            validateDisplayedButtonUSD()
        }

        execute {
            typeTextInEditTextCurrency()
        }

        validate {
            validateEditTextCurrency()
        }

        execute {
            clickInConvert()
        }

        validate {
            validateResultRealToDolar()
        }

        execute {
            clickInInvert()
            clickInConvert()
        }

        validate {
            validateResultDolarToReal()
        }


    }

    private fun mockSuccessResponses() {
        server.dispatcher = object : Dispatcher() {
            override fun dispatch(request: RecordedRequest): MockResponse {
                return if (request.path!!.contains("list")) {
                    MockResponse().setResponseCode(200)
                        .setBody(loadData("listcurrency_success.json")!!)
                } else {
                    MockResponse().setResponseCode(200)
                        .setBody(loadData("convert_currencies_success.json")!!)
                }

            }
        }
    }
}