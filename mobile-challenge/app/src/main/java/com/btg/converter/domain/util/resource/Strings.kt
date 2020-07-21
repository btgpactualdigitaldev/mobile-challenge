package com.btg.converter.domain.util.resource

import android.content.Context
import androidx.annotation.StringRes
import com.btg.converter.R

class

Strings constructor(private val context: Context) {

    val errorTitle: String get() = res(R.string.error_title)
    val errorUnknown: String get() = res(R.string.error_unknown)
    val errorNetwork: String get() = res(R.string.error_network)
    val errorNotFound: String get() = res(R.string.error_not_found)
    val errorSocketTimeout: String get() = res(R.string.error_socket_timeout)
    val errorInternalServer: String get() = res(R.string.error_internal_server)
    val errorBadRequest: String get() = res(R.string.error_bad_request)
    val errorConflict: String get() = res(R.string.error_conflict)
    val errorForbidden: String get() = res(R.string.error_forbidden)
    val errorUnauthorized: String get() = res(R.string.error_unauthorized)
    val errorUnexpected: String get() = res(R.string.error_unexpected)
    val errorUnprocessableEntity: String get() = res(R.string.error_unprocessable_entity)
    val globalTryAgain: String get() = res(R.string.global_try_again)
    val globalOk: String get() = res(R.string.global_ok)
    val emptyFieldsErrorTitle: String = res(R.string.empty_currencies_error)
    val emptyCurrenciesError: String = res(R.string.empty_currencies_error)
    val emptyValueError: String = res(R.string.empty_value_error)
    val conversionError: String = res(R.string.conversion_error)
    val currentQuotesError: String = res(R.string.current_quotes_error)
    val currencyListError: String = res(R.string.currency_list_error)

    private fun res(@StringRes stringId: Int) = context.getString(stringId)
}