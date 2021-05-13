package br.com.btg.btgchallenge.network.api

import com.instacart.library.truetime.TrueTime
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class GetTrueTime {
    companion object{
        suspend fun getTrueTime()
        {
            withContext(Dispatchers.IO) {
                TrueTime.build().withServerResponseDelayMax(4000000).withLoggingEnabled(false).withRootDelayMax(300000000f) .initialize();
            }
        }
    }
}