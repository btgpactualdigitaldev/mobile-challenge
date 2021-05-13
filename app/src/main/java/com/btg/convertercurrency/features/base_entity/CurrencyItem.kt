package com.btg.convertercurrency.features.base_entity

import android.text.Spannable
import android.text.SpannableString
import android.text.style.BackgroundColorSpan
import java.time.OffsetDateTime

data class CurrencyItem(
    var code: String = "",
    var name: String = "",
    var lastUpdate: OffsetDateTime = OffsetDateTime.now(),
    val quotesList: MutableList<QuoteItem> = mutableListOf()
) {

    var filter: String = ""

    fun titleContains(title: String) =
        this.code.contains(title, ignoreCase = true) || this.name.contains(title, ignoreCase = true)

    fun codeSpan(): Spannable {
        return spanify(code)
    }

    fun nameSpan(): Spannable {
        return spanify(name)
    }

    private fun spanify(span: String): Spannable {

        val textToHighlight: String = filter
        val tvt = span
        var ofe = tvt.indexOf(span, 0)
        val wordtoSpan: Spannable = SpannableString(span)
        var ofs = 0
        while (ofs < tvt.length && ofe != -1) {
            ofe = tvt.indexOf(textToHighlight, ofs, ignoreCase = true)
            if (ofe == -1) break else {
                wordtoSpan.setSpan(
                    BackgroundColorSpan(-0x100),
                    ofe,
                    ofe + textToHighlight.length,
                    Spannable.SPAN_EXCLUSIVE_EXCLUSIVE
                )
            }
            ofs = ofe + 1
        }

        return wordtoSpan
    }
}