package br.com.btg.mobile.challenge.ui.currency.list

import android.os.Bundle
import android.view.View
import android.widget.ProgressBar
import androidx.recyclerview.widget.RecyclerView
import br.com.arch.toolkit.delegate.viewProvider
import br.com.btg.mobile.challenge.R
import br.com.btg.mobile.challenge.base.BaseFragment
import br.com.btg.mobile.challenge.data.model.Price
import br.com.btg.mobile.challenge.extension.message
import br.com.btg.mobile.challenge.extension.visibleOrGone
import br.com.btg.mobile.challenge.ui.HomeViewModel
import org.koin.androidx.viewmodel.ext.android.sharedViewModel

class ListCurrencyFragment : BaseFragment(R.layout.fragment_coins) {

    private val recyclerView: RecyclerView by viewProvider(R.id.recyclerCorrected)
    private val progress: ProgressBar by viewProvider(R.id.progress)

    private val viewModel: HomeViewModel by sharedViewModel()

    private var adapter: CurrencyListAdapter? = null

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        observers()
    }

    private fun recyclerView(essays: List<Price>? = null) {
        adapter?.let {
            essays?.let { adapter?.data(it) }
        } ?: run {
            adapter = CurrencyListAdapter { }
            recyclerView.adapter = adapter
        }
    }

    private fun observers() {
        viewModel.dataPricesSuccess.observe(viewLifecycleOwner) { recyclerView(it) }
        viewModel.loading.observe(viewLifecycleOwner) { statusProgress(it) }
        viewModel.error.observe(viewLifecycleOwner) {
            activity?.message(getString(R.string.server_error))
        }
    }

    private fun statusProgress(visible: Boolean) {
        progress.visibleOrGone(visible)
        recyclerView.visibleOrGone(visible.not())
    }
}
