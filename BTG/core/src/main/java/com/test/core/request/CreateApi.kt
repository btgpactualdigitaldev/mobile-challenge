package com.test.core.request

import com.test.core.provider.provideRetrofit

inline fun <reified T> createApi(): T {
    return provideRetrofit().create(T::class.java)
}