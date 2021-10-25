package com.leonardocruz.util

import android.content.Context
import androidx.appcompat.app.AppCompatActivity
import com.google.gson.Gson
import com.google.gson.JsonArray
import com.leonardocruz.btgteste.model.Currencies
import com.leonardocruz.util.Constants.PREFERENCES

object Util {

    fun savePreferences(context: Context, list : MutableList<Currencies>, sharedKey : String) {
        val prefs = context.getSharedPreferences(
            PREFERENCES,
            AppCompatActivity.MODE_PRIVATE
        )
        val editor = prefs.edit()
        editor.putString(sharedKey, Gson().toJson(list)).apply()
    }

    fun readPrefs(context: Context, sharedKey : String): MutableList<Currencies>? {
        val prefs = context.getSharedPreferences(
            PREFERENCES,
            AppCompatActivity.MODE_PRIVATE
        )
        val json = prefs.getString(sharedKey, null)
        if(json.isNullOrEmpty()){
            return null
        }
        val objArray = Gson().fromJson(json, JsonArray::class.java)
        return parseJsonList(objArray)
    }

    fun convertValues(currentValue : Double, currencyFrom : String, currencyTo : String, listRates : MutableList<Currencies>): Double {
        var valorFrom = 0f
        var valorTo = 0f
        var result = 0.0
            listRates.forEach {
                if (it.initials.takeLast(3) == currencyFrom) {
                    valorFrom = it.value.toString().toFloat()
                }
                if (it.initials.takeLast(3) == currencyTo) {
                    valorTo = it.value.toString().toFloat()
                }
            }
            result = (currentValue!! / valorFrom) * valorTo
            return result
        }
    }
