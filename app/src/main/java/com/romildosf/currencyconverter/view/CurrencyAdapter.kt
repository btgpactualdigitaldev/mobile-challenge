package com.romildosf.currencyconverter.view

import android.content.Context
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentPagerAdapter
import com.romildosf.currencyconverter.R
import com.romildosf.currencyconverter.view.converter.CurrencyConverterFragment
import com.romildosf.currencyconverter.view.list.CurrencyListFragment

class CurrencyAdapter(private  val context: Context, fm: FragmentManager): FragmentPagerAdapter(fm, BEHAVIOR_RESUME_ONLY_CURRENT_FRAGMENT) {
    private val TAB_TITLES = arrayOf(
        R.string.tab_name_currency_converter,
        R.string.tab_name_currency_list
    )

    override fun getItem(position: Int): Fragment {
        return when(position) {
            0 -> CurrencyConverterFragment()
            else -> CurrencyListFragment()
        }
    }

    override fun getPageTitle(position: Int): CharSequence? {
        return context.resources.getString(TAB_TITLES[position])
    }

    override fun getCount(): Int {
        // Show 2 total pages.
        return 2
    }
}