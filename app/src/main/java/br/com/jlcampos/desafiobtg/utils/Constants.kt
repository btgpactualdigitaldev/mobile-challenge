package br.com.jlcampos.desafiobtg.utils

class Constants private constructor(){
    companion object{

        const val IDENTIFICATION = "DesafioBTG"

        const val URL = "http://api.currencylayer.com"
        const val URL_QUOTE = "http://apilayer.net/api"
        const val MY_KEY = "cb5df390d2007202974ebcd551db6b6d"
        const val ACCESS_KEYS = "access_key="

        const val CASE_INSENSITIVITY_SIGN = "(?i)"

        const val ERROR = "error"
        const val CODE = "code"
        const val INFO = "info"
        const val SUCCESS = "success"

        const val ERROR_CONNECT = 999
        const val ERROR_JSON = 998

        /** /list **/
        const val list_ws = "$URL/list?$ACCESS_KEYS$MY_KEY"
        const val list_success = SUCCESS
        const val list_currencies = "currencies"

        /** /live **/
        const val live_ws = "$URL_QUOTE/live?$ACCESS_KEYS$MY_KEY"
        const val live_success = SUCCESS
        const val live_quotes = "quotes"
        const val live_currencies = "&currencies="
        const val live_source = "&source="

    }
}