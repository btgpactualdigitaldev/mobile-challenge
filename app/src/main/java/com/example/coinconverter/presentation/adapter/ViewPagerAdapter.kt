package com.example.coinconverter.presentation.adapter

import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentActivity
import androidx.viewpager2.adapter.FragmentStateAdapter
import com.example.coinconverter.presentation.view.ConverterFragment
import com.example.coinconverter.presentation.view.ListFragment


class ViewPagerAdapter(fragmentActivity: FragmentActivity?) : FragmentStateAdapter(fragmentActivity!!) {
    override fun createFragment(position: Int): Fragment {
            return if (position == 0) {
                ConverterFragment.newInstance()
            }else {
                ListFragment.newInstance()
            }
    }

    override fun getItemCount(): Int {
        return 2
    }
}