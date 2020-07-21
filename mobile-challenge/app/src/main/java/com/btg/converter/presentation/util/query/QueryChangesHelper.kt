package com.btg.converter.presentation.util.query

import androidx.appcompat.widget.SearchView

class QueryChangesHelper(private val callback: (String) -> Unit) : SearchView.OnQueryTextListener {
    override fun onQueryTextSubmit(p0: String?): Boolean {
        return true
    }

    override fun onQueryTextChange(p0: String?): Boolean {
        p0?.let { callback(it) }
        return true
    }
}