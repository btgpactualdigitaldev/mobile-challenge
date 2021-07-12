package com.example.currencies.repository.remote

import android.app.Application
import com.example.currencies.R
import com.example.currencies.constants.CurrenciesConstants
import com.example.currencies.listener.APIListener
import com.example.currencies.model.remote.RatesModelRemote
import com.example.currencies.retrofit.RetrofitMobileChallenge
import com.example.currencies.service.RatesService
import com.google.gson.Gson
import org.json.JSONException
import org.json.JSONObject
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class RatesRemoteRepository(val application: Application){

    fun loadRates(listener: APIListener<RatesModelRemote>) {

        var mRemote =  RetrofitMobileChallenge.createService(RatesService::class.java)

        val call: Call<RatesModelRemote> = mRemote.getAllRates()

        call.enqueue(object : Callback<RatesModelRemote> {

            override fun onResponse(call: Call<RatesModelRemote>, response: Response<RatesModelRemote>) {
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
                            if(it.success){
                                listener.onSuccess(it)
                                for ((k,v) in it.quotes){
                                    println("$k = $v")
                                }
                            }else{
                                listener.onFailure(application.getString(R.string.no_success))
                            }
                        }else{
                            listener.onFailure(application.getString(R.string.no_records))
                        }
                    }
                }
            }
            override fun onFailure(call: Call<RatesModelRemote>, t: Throwable) {
                listener.onFailure(application.getString(R.string.ERROR_UNEXPECTED))
            }
        })
    }
}