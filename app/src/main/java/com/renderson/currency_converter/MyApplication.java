package com.renderson.currency_converter;

import android.app.Application;
import android.content.Context;

import androidx.appcompat.app.AppCompatDelegate;

import dagger.hilt.android.HiltAndroidApp;

@HiltAndroidApp
public class MyApplication extends Application {
    private static MyApplication instance;

    public void onCreate() {
        instance = this;
        super.onCreate();
        AppCompatDelegate.setDefaultNightMode(
                AppCompatDelegate.MODE_NIGHT_NO);
    }

    public static Context getContext() {
        return instance;
    }
}
