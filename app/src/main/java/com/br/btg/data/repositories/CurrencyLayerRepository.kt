package com.br.btg.data.repositories

import android.content.Context
import android.content.SharedPreferences
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.br.btg.BaseAsyncTask
import com.br.btg.data.models.ConverterModel
import com.br.btg.data.models.CurrencyLayerModel
import com.br.btg.data.network.webclient.CurrencyLayerWebClient
import com.br.btg.utils.CURRENCIES
import com.br.btg.utils.DEFAULT
import com.google.gson.Gson



class CurrencyLayerRepository (private val webclient: CurrencyLayerWebClient) {

    fun getAllCurrencies(context: Context): LiveData<Resource<CurrencyLayerModel?>> {

        val liveData = MutableLiveData<Resource<CurrencyLayerModel?>>()

        webclient.getAllCurrencies(
            success = { exchangesRate ->
                exchangesRate?.let {
                    liveData.postValue(Resource(it))
                    saveLocal(context, CURRENCIES, it)
                }
            }, error = { err -> liveData.postValue(Resource(data = null, error = err)) }
        );
        return liveData

    }

    fun converter(currency: String, source: String, format: String): LiveData<Resource<ConverterModel>> {
        val liveData = MutableLiveData<Resource<ConverterModel>>()

        webclient.getConverter(
            currency,
            source,
            format,
            success = { converter ->
                converter?.let {
                    liveData.postValue(Resource(it))
                }
            }, error = { err -> liveData.postValue(Resource(data = null, error = err)) }
        );

        return liveData
    }

    fun saveLocal(context: Context, name: String?, currency: CurrencyLayerModel) {

        BaseAsyncTask(
            whenExecute = { saveObjectToSharedPreference(context = context, serializedObjectKey = name, `object` = currency) },
            whenFinished = {}
        ).execute()
    }

    fun saveObjectToSharedPreference(context: Context, serializedObjectKey: String?, `object`: Any?) {
        val sharedPreferences: SharedPreferences = context.getSharedPreferences(DEFAULT, 0)
        val sharedPreferencesEditor = sharedPreferences.edit()
        val gson = Gson()
        val serializedObject = gson.toJson(`object`)
        sharedPreferencesEditor.putString(serializedObjectKey, serializedObject)
        sharedPreferencesEditor.apply()
    }

    fun getObject(context: Context): CurrencyLayerModel? {
        val sharedPreferences: SharedPreferences = context.getSharedPreferences(DEFAULT, 0)
        val json: String? = sharedPreferences.getString(CURRENCIES, "")
        val gson = Gson()
        val obj: CurrencyLayerModel? = gson.fromJson(json, CurrencyLayerModel::class.java)
        return obj
    }

}
