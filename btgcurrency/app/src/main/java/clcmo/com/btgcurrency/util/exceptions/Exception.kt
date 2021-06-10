package clcmo.com.btgcurrency.util.exceptions

import java.lang.Exception

class Exception (_status : String = String()) : Exception() {
    val status: String? = _status
}