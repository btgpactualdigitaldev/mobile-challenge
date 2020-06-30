package br.com.daccandido.currencyconverterapp.utils


fun <T1, T2> safeLet(value1: T1?, value2: T2?,
                     bothNotNull: (T1, T2) -> (Unit)) {
    if (value1 != null && value2 != null) {
        bothNotNull(value1, value2)
    }
}


fun isInternetAvailable(): Boolean {
    return try {
        val command = "ping -c 1 google.com"
        Runtime.getRuntime().exec(command).waitFor() == 0
    } catch (e: Exception) {
        false
    }
}