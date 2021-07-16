package br.com.conversordemoedas.model

import androidx.lifecycle.MutableLiveData

class Database {

    private val mDatabase: MutableLiveData<MutableList<List>> = MutableLiveData()

    fun getDatabe() = mDatabase

}