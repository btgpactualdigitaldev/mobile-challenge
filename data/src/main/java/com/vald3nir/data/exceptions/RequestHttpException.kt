package com.vald3nir.data.exceptions

class RequestHttpException(code: Int) : Exception("Request fall, code $code")