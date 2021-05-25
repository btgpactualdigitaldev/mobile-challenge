package br.com.btg.test.di

import br.com.btg.test.BuildConfig
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import okhttp3.*
import okhttp3.logging.HttpLoggingInterceptor
import org.koin.dsl.module
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory


object NetworkModule {

    val networkModule = module {
        factory { provideOkHttp() }
        factory {
            provideRetrofit(
                get()
            )
        }
    }

    private fun provideGson(): Gson {
        return GsonBuilder()
            .enableComplexMapKeySerialization()
            .create()
    }

    private fun provideOkHttp(): OkHttpClient {
        val builder = OkHttpClient.Builder()
            .addInterceptor(
                HttpLoggingInterceptor().apply {
                    level = HttpLoggingInterceptor.Level.BODY
                })
            .addInterceptor(object : Interceptor {
                override fun intercept(chain: Interceptor.Chain): Response {
                    val original: Request = chain.request()
                    val originalHttpUrl: HttpUrl = chain.request().url
                    val url = originalHttpUrl.newBuilder()
                        .addQueryParameter("access_key", BuildConfig.API_KEY)
                        .build()
                    val requestBuilder: Request.Builder = original.newBuilder()
                        .url(url)
                    return chain.proceed(requestBuilder.build())
                }
            })
        return builder.build()
    }

    private fun provideRetrofit(okHttpClient: OkHttpClient): Retrofit {
        return Retrofit.Builder()
            .baseUrl(BuildConfig.API_URL)
            .addConverterFactory(GsonConverterFactory.create(provideGson()))
            .client(okHttpClient)
            .build()
    }
}