package com.leonardo.convertcoins.config

/**
 * Class used as interface to load cpp file native-lib.cpp
 * and expose apiKey() function that returns the value on that function.
 *
 * To properly use this application and access updated currency values you
 * need to generate a private key on https://currencylayer.com/ and return
 * it inside native-lib.cpp function
 */
class Keys {

    init {
        System.loadLibrary("native-lib")
    }

    external fun apiKey(): String
}