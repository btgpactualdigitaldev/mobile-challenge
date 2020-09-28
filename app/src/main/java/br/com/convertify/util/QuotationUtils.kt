package br.com.convertify.util

import br.com.convertify.models.QuotationItem

class QuotationUtils {
   companion object{
       fun quotationMapToCurrencyList(currencyMap: Map<String, Double>): Array<QuotationItem> {

           return currencyMap.map {
               QuotationItem.fromMapEntry(it)
           }.toTypedArray()
       }
   }
}