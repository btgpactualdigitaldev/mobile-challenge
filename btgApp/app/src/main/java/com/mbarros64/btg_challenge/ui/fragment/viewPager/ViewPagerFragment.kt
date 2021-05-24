package com.mbarros64.btg_challenge.ui.fragment.viewPager

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toolbar
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.Lifecycle
import androidx.viewpager2.adapter.FragmentStateAdapter
import androidx.viewpager2.widget.ViewPager2
import com.mbarros64.btg_challenge.R
import com.mbarros64.btg_challenge.ui.fragment.currencyList.CurrencyListFragment
import com.mbarros64.btg_challenge.ui.fragment.home.HomeFragment
import com.google.android.material.tabs.TabLayout
import com.google.android.material.tabs.TabLayoutMediator
import java.lang.IndexOutOfBoundsException


//TODO -> converter para databinding
class ViewPagerFragment : Fragment() {
    private lateinit var viewPager: ViewPager2
    private lateinit var tabLayoutMediator: TabLayoutMediator

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_view_pager, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        setupViewPager(view)
    }

    private fun setupViewPager(view: View) {
        val labels = listOf("Conversor", "Cotações")

        val navHostFragmentAdapter = NavHostFragmentAdapter(this)

        viewPager = view.findViewById(R.id.view_pager)
        viewPager.adapter = navHostFragmentAdapter

        val tabLayout = view.findViewById<TabLayout>(R.id.view_pager_tab_layout)

        tabLayoutMediator = TabLayoutMediator(tabLayout, viewPager) { tab, position ->
            tab.text = (labels[position])
        }

        tabLayoutMediator.attach()
    }


    override fun onDestroy() {
        viewPager.adapter = null
        tabLayoutMediator.detach()
        super.onDestroy()
    }

    class NavHostFragmentAdapter(fragment: Fragment) : FragmentStateAdapter(fragment) {
        private val tabFragmentsCreators: Map<Int, () -> Fragment> = mapOf(
            0 to { HomeFragment() },
            1 to { CurrencyListFragment() }
        )

        override fun getItemCount() = tabFragmentsCreators.size

        override fun createFragment(position: Int): Fragment {
            return tabFragmentsCreators[position]?.invoke() ?: throw IndexOutOfBoundsException()
        }

    }


}