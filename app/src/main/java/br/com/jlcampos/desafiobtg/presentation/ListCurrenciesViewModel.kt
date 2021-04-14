package br.com.jlcampos.desafiobtg.presentation

import android.app.Application
import android.text.TextUtils
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import br.com.jlcampos.desafiobtg.data.model.Currency
import br.com.jlcampos.desafiobtg.utils.Constants
import java.util.regex.Matcher
import java.util.regex.Pattern

@Suppress("NULLABILITY_MISMATCH_BASED_ON_JAVA_ANNOTATIONS")
class ListCurrenciesViewModel(application: Application) : AndroidViewModel(application) {

    val listCurrLiveData: MutableLiveData<ArrayList<Currency>> = MutableLiveData()

    fun filterCurr(search: String, allCurr: ArrayList<Currency>, exactMatches: Boolean) {

        var listFilter: ArrayList<Currency> = ArrayList()

        if (TextUtils.isEmpty(search)) {
            listFilter = allCurr
        }

        if (allCurr.isNotEmpty() && !TextUtils.isEmpty(search)) {
            val patternRegex = prepareRegexPattern(search, exactMatches)
            val pattern: Pattern = Pattern.compile(patternRegex)

            for (i in allCurr) {
                val matcher1: Matcher = pattern.matcher(i.key)
                val matcher2: Matcher = pattern.matcher(i.value)

                if (matcher1.matches() || matcher2.matches()) {
                    listFilter.add(i)
                }
            }
        }

        listCurrLiveData.postValue(listFilter)
    }

    private fun prepareRegexPattern(searchValue: String, exactMatches: Boolean) = if (exactMatches) Constants.CASE_INSENSITIVITY_SIGN + searchValue else Constants.CASE_INSENSITIVITY_SIGN + ".*" + searchValue + ".*"
}