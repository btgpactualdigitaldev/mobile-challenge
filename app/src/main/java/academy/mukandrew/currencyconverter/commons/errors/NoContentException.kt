package academy.mukandrew.currencyconverter.commons.errors

import java.lang.Exception

class NoContentException(_message: String = String()) : Exception() {
    override val message: String? = _message
}