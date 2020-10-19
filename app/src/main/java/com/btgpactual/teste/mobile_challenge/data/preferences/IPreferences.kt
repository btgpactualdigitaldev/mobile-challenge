package com.btgpactual.teste.mobile_challenge.data.preferences

/**
 * Created by Carlos Souza on 16,October,2020
 */
interface IPreferences {

    fun setLastUpdate(value: String)
    fun getLastUpdate(): String

    fun setOrigin(value: String)
    fun getOrigin(): String

    fun setTarget(value: String)
    fun getTarget(): String

    fun setQuotation(value: Float)
    fun getQuotation(): Float
}