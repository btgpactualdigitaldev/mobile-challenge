package clcmo.com.btgcurrency.util.constants

object Constants {

    enum class State { LOADING, LOADED, ERROR, CONTENT_EX }

    enum class CMethodType { TO, FROM }

    //RF Config
    const val API_URL: String = "http://api.currencylayer.com/"
    const val ACCESS_KEY = "f618f91d801c2a0848a4425dd5206787"
    const val CONN_LIMIT: Long = 30000L
    const val IO_LIMIT: Long = CONN_LIMIT

    //DB NAME
    const val DB_NAME = "ChallengeDB"

    //CRepository
    const val QT_QUOTE = 1f

    //CUserCase
    const val QUOTE_USD_INDEX_DEFAULT = 3
    const val QT_NOT_CALC = 0f

    //CViewModel
    const val DEF_MIN_VALUE = QT_NOT_CALC
    const val DEF_MASK = "%1s %.3f"
    const val DEF_EMPTY_VALUE = "0,00"


}