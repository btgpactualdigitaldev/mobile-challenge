package br.com.btg.mobile.challenge.data.remote

import br.com.btg.mobile.challenge.BuildConfig
import com.squareup.moshi.JsonAdapter
import com.squareup.moshi.JsonReader
import com.squareup.moshi.JsonWriter
import com.squareup.moshi.Moshi
import com.squareup.moshi.adapters.Rfc3339DateJsonAdapter
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import io.reactivex.schedulers.Schedulers
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory.createWithScheduler
import retrofit2.converter.moshi.MoshiConverterFactory
import java.lang.reflect.Type
import java.util.Date
import java.util.concurrent.TimeUnit

private const val TIMEOUT = 60L
private const val TIMEOUT_DEBUG = 90L

object RetrofitConfig {

    fun buildApi(url: String): Retrofit {
        return Retrofit.Builder()
            .baseUrl(url)
            .client(getHttpClient().build())
            .addConverterFactory(MoshiConverterFactory.create(MoshiBuilder.create()).asLenient())
            .addCallAdapterFactory(createWithScheduler(Schedulers.io()))
            .build()
    }

    private object MoshiBuilder {
        fun create(): Moshi = Moshi.Builder()
            .add(DefaultIfNullFactory)
            .add(Date::class.java, Rfc3339DateJsonAdapter())
            .add(KotlinJsonAdapterFactory())
            .build()
    }

    private fun getHttpClient(): OkHttpClient.Builder {
        val timeout = if (BuildConfig.DEBUG) TIMEOUT_DEBUG else TIMEOUT
        return OkHttpClient.Builder()
            .connectTimeout(timeout, TimeUnit.SECONDS)
            .writeTimeout(timeout, TimeUnit.SECONDS)
            .readTimeout(timeout, TimeUnit.SECONDS)
            .addInterceptor(getHttpLogging())
    }

    private fun getHttpLogging(): HttpLoggingInterceptor =
        HttpLoggingInterceptor().setLevel(
            if (BuildConfig.DEBUG) {
                HttpLoggingInterceptor.Level.BODY
            } else HttpLoggingInterceptor.Level.NONE
        )

    private object DefaultIfNullFactory : JsonAdapter.Factory {
        override fun create(
            type: Type,
            annotations: MutableSet<out Annotation>,
            moshi: Moshi
        ): JsonAdapter<*> {
            val delegate = moshi.nextAdapter<Any>(this, type, annotations)
            return object : JsonAdapter<Any>() {
                override fun fromJson(reader: JsonReader): Any? {
                    val blob1 = reader.readJsonValue()
                    return try {
                        val blob = blob1 as? Map<*, *>
                        blob?.let {
                            val noNulls = blob.filterValues { it != null }
                            delegate.fromJsonValue(noNulls)
                        } ?: delegate.fromJsonValue(blob1)
                    } catch (e: Exception) {
                        delegate.fromJsonValue(blob1)
                    }
                }

                override fun toJson(writer: JsonWriter, value: Any?) {
                    return delegate.toJson(writer, value)
                }
            }
        }
    }
}
