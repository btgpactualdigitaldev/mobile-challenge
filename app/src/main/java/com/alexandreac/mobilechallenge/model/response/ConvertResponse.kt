package com.alexandreac.mobilechallenge.model.response

import java.sql.Timestamp

data class ConvertResponse (var success:Boolean? = false,
                            var quotes: Map<String, Double>? = null,
                            var error:ErrorResponse? = null)