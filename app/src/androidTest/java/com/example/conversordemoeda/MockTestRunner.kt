package com.example.conversordemoeda

import android.app.Application
import android.content.Context
import androidx.test.runner.AndroidJUnitRunner

class MockTestRunner : AndroidJUnitRunner() {
    override fun newApplication(cl: ClassLoader?,className: String?,context: Context?): Application {
        return super.newApplication(cl, TestApp::class.java.name, context)
    }
}