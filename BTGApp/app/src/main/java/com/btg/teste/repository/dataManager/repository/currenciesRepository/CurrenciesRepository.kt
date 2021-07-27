package com.btg.teste.repository.dataManager.repository.currenciesRepository

import android.content.Context
import com.btg.teste.repository.dataManager.dao.CurrenciesDAO
import com.btg.teste.repository.dataManager.entity.CurrenciesEntity
import com.btg.teste.repository.dataManager.repository.AbstractRepository
import com.google.gson.reflect.TypeToken

class CurrenciesRepository(context: Context) :
    AbstractRepository<CurrenciesDAO, CurrenciesEntity>(
        context,
        object : TypeToken<CurrenciesDAO>() {}.type
    ), ICurrenciesRepository {
    override fun findViewById(id: Int): CurrenciesEntity? {
        return execute {
            _dao.findViewById(id)
        }
    }

    override fun find(): List<CurrenciesEntity>? {
        return execute {
            _dao.find()
        }
    }

    override fun findDesc(): CurrenciesEntity? {
        return execute {
            _dao.findDesc()
        }
    }

    override fun findViewByCurrency(currency: String): CurrenciesEntity? {
        return execute {
            _dao.findViewByCurrency(currency)
        }
    }

    override fun insert(type: CurrenciesEntity): Long? {
        return execute {
            _dao.insert(type)
        }
    }


    override fun update(type: CurrenciesEntity) {
        execute {
            _dao.update(type)
        }
    }

    override fun delete(type: CurrenciesEntity) {
        execute {
            _dao.delete(type)
        }
    }
}