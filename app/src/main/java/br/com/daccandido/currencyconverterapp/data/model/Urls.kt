package br.com.daccandido.currencyconverterapp.data.model

enum class Url constructor(val description: String) {

    live ("live?access_key=$ACCESS_KEY"),
    list ("list?access_key=$ACCESS_KEY");


//    fun getDescription(): String {
//        return "$description?access_key=$ACCESS_KEY"
//    }

}