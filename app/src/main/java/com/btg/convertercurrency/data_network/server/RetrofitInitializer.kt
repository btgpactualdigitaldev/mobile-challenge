package  com.btg.convertercurrency.data_network.server

import com.btg.convertercurrency.data_network.server.endpoints.EndPointCurrencyLayer
import com.btg.convertercurrency.data_network.server.endpoints.response.*
import com.btg.convertercurrency.data_network.server.endpoints.serializers.JsonDeserializerCurrencyAdapter
import com.btg.convertercurrency.data_network.server.endpoints.serializers.JsonDeserializerQuoteAdapter
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import okhttp3.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit


object RetrofitInitializer : Interceptor {

    private val servers = HashMap<Servers, Retrofit>()
    private const val connectTimeout = 5
    private const val writeTimeout = 5
    private const val readTimeout = 50
    private var token = ""
    private val listTypeCurrency = object : TypeToken<MutableList<CurrenciesResponse>>() {}.type
    private val listTypeQuotes = object : TypeToken<MutableList<QuotesResponse>>() {}.type

    fun getService(server: Servers): EndPointCurrencyLayer {

        if (!servers.containsKey(server)) {

            val gson = GsonBuilder()
                .registerTypeAdapter(listTypeCurrency,
                    JsonDeserializerCurrencyAdapter()
                )
                .registerTypeAdapter(listTypeQuotes,
                    JsonDeserializerQuoteAdapter()
                )
                .setDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                .create()

            servers[server] = Retrofit
                .Builder()
                .baseUrl(server.url)
                .client(createOkHttpClient(this))
                .addConverterFactory(GsonConverterFactory.create(gson)).build()
        }

        return servers[server]!!.create(EndPointCurrencyLayer::class.java)
    }

    private fun createOkHttpClient(interceptor: Interceptor?): OkHttpClient {

        val client: OkHttpClient

        if (interceptor == null) {
            client = OkHttpClient
                .Builder()
                .connectTimeout(connectTimeout.toLong(), TimeUnit.SECONDS)
                .writeTimeout(writeTimeout.toLong(), TimeUnit.SECONDS)
                .readTimeout(readTimeout.toLong(), TimeUnit.SECONDS)
                .build()
        } else {
            client = OkHttpClient
                .Builder()
                .connectTimeout(connectTimeout.toLong(), TimeUnit.SECONDS)
                .writeTimeout(writeTimeout.toLong(), TimeUnit.SECONDS)
                .readTimeout(readTimeout.toLong(), TimeUnit.SECONDS)
                .addInterceptor(interceptor)
                .build()
        }

        return client
    }

    fun setToken(token: String) {
        RetrofitInitializer.token = token
    }

    override fun intercept(chain: Interceptor.Chain): Response {

        var request = chain.request()

        request = if (token.isNotEmpty())
            request.newBuilder().addHeader("Authorization", "Bearer $token").build()
        else {

            val url = request.url()
                .newBuilder()
                .addQueryParameter("access_key", "322d8258228c115912523f109fa171d6")
                .build()

            request.newBuilder().url(url).build()
        }

        return chain.proceed(request)
    }

    enum class Servers(val url: String) {
        CurrencyLayer_API("http://api.currencylayer.com/"),

    }
}