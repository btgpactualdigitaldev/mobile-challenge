package com.leonardo.convertcoins.config
import android.view.View
import androidx.recyclerview.widget.RecyclerView
import androidx.recyclerview.widget.RecyclerView.AdapterDataObserver

class RecyclerViewEmptyObserver(private val recyclerView: RecyclerView, ev: View?) : AdapterDataObserver() {

    private val emptyView: View? = ev

    init {
        checkIfEmpty()
    }

    /**
     * check if the adapter is empty and toggle visibility of recycler view and empty view
     */
    private fun checkIfEmpty() {
        if (emptyView != null && recyclerView.adapter != null) {
            val emptyViewVisible = recyclerView.adapter!!.itemCount == 0
            emptyView.visibility = (if (emptyViewVisible) View.VISIBLE else View.GONE)
            recyclerView.visibility = (if (emptyViewVisible) View.GONE else View.VISIBLE)
        }
    }

    /**
     * check if adapter is empty every time a item is removed
     */
    override fun onItemRangeRemoved(positionStart: Int, itemCount: Int) {
        checkIfEmpty()
    }

    /**
     * check if adapter is empty every time data set is changed
     */
    override fun onChanged() {
        checkIfEmpty()
    }

}