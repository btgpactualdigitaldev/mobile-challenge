package com.example.conversordemoeda

import com.example.conversordemoeda.di.BASE_URL

class TestApp : App() {
    var url = "http://127.0.0.1:8080/"

    override fun onCreate() {
        super.onCreate()
        BASE_URL = getUrlBase()
    }

    override fun getUrlBase(): String {
        return url
    }
}