package academy.mukandrew.currencyconverter.commons.errors

class NetworkException(_message: String = String()) : Exception() {
    override val message: String? = _message
}