package com.guioliveiraapps.wkm.utilities

import android.view.View
import androidx.recyclerview.widget.RecyclerView
import androidx.test.espresso.NoMatchingViewException
import androidx.test.espresso.ViewAssertion
import junit.framework.Assert.assertNotNull
import org.hamcrest.MatcherAssert.assertThat
import org.hamcrest.Matchers.`is`

class RecyclerViewItemCountAssertion(private val expectedCount: Int) : ViewAssertion {

    override fun check(view: View?, noViewFoundException: NoMatchingViewException?) {

        if (noViewFoundException != null) {
            throw noViewFoundException
        }

        val recyclerView: RecyclerView = view as RecyclerView
        val adapter: RecyclerView.Adapter<RecyclerView.ViewHolder>? = recyclerView.adapter
        assertNotNull(adapter)
        assertThat(adapter!!.itemCount, `is`(expectedCount))
    }
}