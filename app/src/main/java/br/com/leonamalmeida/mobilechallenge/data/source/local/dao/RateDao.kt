package br.com.leonamalmeida.mobilechallenge.data.source.local.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import br.com.leonamalmeida.mobilechallenge.data.Rate
import io.reactivex.Completable
import io.reactivex.Flowable

/**
 * Created by Leo Almeida on 29/06/20.
 */

@Dao
interface RateDao {

    @Query("SELECT * FROM rate")
    fun getRates(): Flowable<List<Rate>>

    @Query("SELECT * FROM rate WHERE code = :code")
    fun getRateByCode(code: String): Rate

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insertRates(rates: List<Rate>): Completable
}