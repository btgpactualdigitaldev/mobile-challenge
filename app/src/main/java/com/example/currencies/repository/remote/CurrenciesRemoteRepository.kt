package com.example.currencies.repository.remote

import android.app.Application
import com.example.currencies.R
import com.example.currencies.constants.CurrenciesConstants
import com.example.currencies.listener.APIListener
import com.example.currencies.model.remote.CurrenciesModelRemote
import com.example.currencies.retrofit.RetrofitMobileChallenge
import com.example.currencies.service.CurrenciesService
import com.google.gson.Gson
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class CurrenciesRemoteRepository(val application: Application){

    fun loadCurrencies(listener: APIListener<CurrenciesModelRemote>) {

        var mRemote = RetrofitMobileChallenge.createService(CurrenciesService::class.java)

        val call: Call<CurrenciesModelRemote> = mRemote.getAllCurrencies()

        call.enqueue(object : Callback<CurrenciesModelRemote> {
            override fun onResponse( call: Call<CurrenciesModelRemote>, response: Response<CurrenciesModelRemote>){
                if (response.code() != CurrenciesConstants.HTTP.SUCCESS) {
                    try {
                        JSONObject(response.toString())
                            val validation =
                                Gson().fromJson(response.errorBody()!!.string(), String::class.java)
                            listener.onFailure(validation)
                    } catch (ex: JSONException) {
                            listener.onFailure(application.getString(R.string.no_records))
                        return
                    }
                } else {
                    response.body().let {
                        if (it != null) {
                            if ( it.success){
                                listener.onSuccess(it)
                                for ((k, v) in it.currencies) {
                                    println("$k = $v")
                                }
                            }else{
                                listener.onFailure(application.getString(R.string.no_success))
                            }
                        } else {
                            listener.onFailure(application.getString(R.string.no_records))
                        }
                    }
                }
            }

            override fun onFailure(call: Call<CurrenciesModelRemote>, t: Throwable) {
                listener.onFailure(application.getString(R.string.ERROR_UNEXPECTED))
            }

        })
    }

}