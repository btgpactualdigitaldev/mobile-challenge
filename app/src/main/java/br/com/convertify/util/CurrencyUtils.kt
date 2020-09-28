package br.com.convertify.util

import br.com.convertify.models.CurrencyItem

class CurrencyUtils {
   companion object{
       fun currencyMapToCurrencyList(currencyMap: Map<String, String>): Array<CurrencyItem> {

           return currencyMap.map {
               CurrencyItem.fromMapEntry(it)
           }.toTypedArray()
       }
   }
}