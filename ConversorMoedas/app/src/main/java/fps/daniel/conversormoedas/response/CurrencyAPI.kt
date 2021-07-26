package fps.daniel.conversormoedas.response

import io.reactivex.Observable
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.GET

interface CurrencyAPI {

    @GET("list?access_key=$API_KEY")
    fun getCurrencyList(): Observable<ListAPI>

    @GET("live?access_key=$API_KEY")
    fun getLiveQuotes(): Observable<LiveAPI>

    companion object {

        fun create(): CurrencyAPI {
            val interceptor = HttpLoggingInterceptor()
            interceptor.level = HttpLoggingInterceptor.Level.BODY

            val client = OkHttpClient.Builder()
            client.addInterceptor(interceptor)

            val retrofit = Retrofit.Builder()
                .addConverterFactory(GsonConverterFactory.create())
                .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                .baseUrl(BASE_URL)
                .client(client.build())
                .build()

            return retrofit.create(CurrencyAPI::class.java)
        }
    }
}