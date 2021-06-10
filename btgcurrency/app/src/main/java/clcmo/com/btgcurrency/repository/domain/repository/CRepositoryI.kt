package clcmo.com.btgcurrency.repository.domain.repository

import clcmo.com.btgcurrency.repository.domain.model.*
import clcmo.com.btgcurrency.util.Result

interface CRepositoryI {
    suspend fun currencies(): Result<List<Currency>>
    suspend fun quotes(): Result<List<Quote>>
    suspend fun acl(cMap: Map<String, String>): List<Currency>
    suspend fun aql(qMap: Map<String, Float>): List<Quote>
}