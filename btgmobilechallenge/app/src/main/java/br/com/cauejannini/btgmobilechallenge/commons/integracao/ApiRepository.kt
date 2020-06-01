package br.com.cauejannini.btgmobilechallenge.commons.integracao

import android.content.Context

class ApiRepository(private val context: Context?) {

    fun get(): Api {
        return RetrofitService(context).createService(Api::class.java)
    }

}