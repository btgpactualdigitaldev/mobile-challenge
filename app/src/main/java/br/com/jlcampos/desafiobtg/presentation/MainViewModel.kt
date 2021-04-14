package br.com.jlcampos.desafiobtg.presentation

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import br.com.jlcampos.desafiobtg.data.model.*
import br.com.jlcampos.desafiobtg.data.repository.MainRepository
import br.com.jlcampos.desafiobtg.utils.AppPrefs
import br.com.jlcampos.desafiobtg.utils.Constants
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.json.JSONException
import org.json.JSONObject

@Suppress("NULLABILITY_MISMATCH_BASED_ON_JAVA_ANNOTATIONS")
class MainViewModel(application: Application) : AndroidViewModel(application) {

    val mainGetListLiveData: MutableLiveData<ResponseAPIList> = MutableLiveData()
    val mainGetQuoteLiveData: MutableLiveData<ResponseAPIQuote> = MutableLiveData()
    val mainGetQuoteOfflineLiveData: MutableLiveData<String> = MutableLiveData()

    fun getList() {

        lateinit var resp: ResponseAPIList

        CoroutineScope(Dispatchers.IO).launch {
            withContext(Dispatchers.Default) {

                val json = MainRepository().getListRepo()

                try {

                    val data = JSONObject(json)

                    if (data.optBoolean(Constants.list_success)) {

                        val session = AppPrefs(getApplication())

                        session.setListCurrencies(data.getJSONObject(Constants.list_currencies).toString())

                        resp = ResponseAPIList(
                                success = data.optBoolean(Constants.list_success),
                                errorApi = null
                        )

                    } else {

                        resp = ResponseAPIList(
                                success = data.optBoolean(Constants.list_success),
                                errorApi = ErrorApi(code = data.getJSONObject(Constants.ERROR).optInt(Constants.CODE),
                                                    info = data.getJSONObject(Constants.ERROR).optString(Constants.INFO))
                        )

                    }

                } catch (e: JSONException) {

                    resp = ResponseAPIList(false, ErrorApi(Constants.ERROR_JSON, e.message.toString()))
                }

                mainGetListLiveData.postValue(resp)
            }
        }
    }

    fun getQuote(curr: String, source: String, valor: String) {

        lateinit var resp: ResponseAPIQuote

        CoroutineScope(Dispatchers.IO).launch {
            withContext(Dispatchers.Default) {

                val json = MainRepository().getQuote(currencies = curr, source = source)

                try {

                    val data = JSONObject(json)

                    if (data.optBoolean(Constants.live_success)) {

                        val keyItr: Iterator<String> = data.getJSONObject(Constants.live_quotes).keys()
                        lateinit var quote: Quote

                        keyItr.forEach {
                            quote = Quote(key = it, value = data.getJSONObject(Constants.live_quotes).optString(it))

                            addQuotes(quote)
                        }

                        resp = ResponseAPIQuote(
                                success = data.optBoolean(Constants.live_success),
                                quote = quote,
                                calc = calcular(valor, quote.value),
                                errorApi = null
                        )

                    } else {

                        resp = ResponseAPIQuote(
                                success = data.optBoolean(Constants.live_success),
                                quote = null,
                                calc = "",
                                errorApi = ErrorApi(code = data.getJSONObject(Constants.ERROR).optInt(Constants.CODE),
                                                    info = data.getJSONObject(Constants.ERROR).optString(Constants.INFO))
                        )

                    }

                } catch (e: JSONException) {
                    resp = ResponseAPIQuote(false, null, "", ErrorApi(Constants.ERROR_JSON, e.message.toString()))
                }
                mainGetQuoteLiveData.postValue(resp)
            }
        }
    }

    private fun addQuotes(quote: Quote) {
        val session = AppPrefs(getApplication())
        val myQuotes = JSONObject(session.getMyQuotes())

        myQuotes.put(quote.key, quote.value)

        session.setMyQuotes(myQuotes.toString())
    }

    private fun calcular(valor: String, quote: String): String {
        return (valor.toDouble() * quote.toDouble()).toString()
    }

    fun quoteOff(valor: String, quote: String) {
        val session = AppPrefs(getApplication())
        val myQuotes = JSONObject(session.getMyQuotes())

        mainGetQuoteOfflineLiveData.postValue(calcular(valor, myQuotes.optString(quote)))
    }

    fun getListAll(): ArrayList<Currency> {
        val currencies: MutableList<Currency> = mutableListOf()

        val data = JSONObject(AppPrefs(getApplication()).getListCurrencies())

        val keyItr: Iterator<String> = data.keys()

        keyItr.forEach {
            val key: String = it
            val value: String = data.optString(key)

            currencies.add(Currency(key, value))
        }

        return currencies as ArrayList<Currency>
    }
}