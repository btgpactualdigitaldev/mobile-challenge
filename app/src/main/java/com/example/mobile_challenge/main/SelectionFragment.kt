package com.example.mobile_challenge.main

import android.graphics.Color
import android.os.Bundle
import android.view.*
import android.widget.EditText
import android.widget.ImageView
import androidx.activity.OnBackPressedDispatcher
import androidx.appcompat.widget.SearchView
import androidx.core.content.ContextCompat
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.mobile_challenge.MainActivity
import com.example.mobile_challenge.R
import com.example.mobile_challenge.model.CurrencyEntity
import com.example.mobile_challenge.utility.CurrencyAdapter
import com.example.mobile_challenge.utility.OnItemClickListener


class SelectionFragment : Fragment(), OnItemClickListener {

  companion object {
    fun newInstance() = SelectionFragment()
  }

  private lateinit var root: View
  private lateinit var recyclerView: RecyclerView
  private lateinit var type: String
  private lateinit var code: String
  private lateinit var mainActivity: MainActivity
  private val viewModel: MainViewModel by activityViewModels()
  private val adapter: CurrencyAdapter by lazy { CurrencyAdapter(ArrayList(), this) }

  override fun onCreateView(
    inflater: LayoutInflater, container: ViewGroup?,
    savedInstanceState: Bundle?
  ): View {
    root = inflater.inflate(R.layout.selection_fragment, container, false)
    setupVars()
    setupRecyclerView()
    setHasOptionsMenu(true)
    return root
  }

  private fun setupVars() {
    recyclerView = root.findViewById(R.id.currency_list)
    mainActivity = activity as MainActivity
    type = arguments?.getString(getString(R.string.type))!!
    code = arguments?.getString(getString(R.string.code))!!
  }

  private fun setupRecyclerView() {
    val layoutManager = LinearLayoutManager(context)
    recyclerView.layoutManager = layoutManager
    recyclerView.adapter = adapter
    setupItemsRecyclerView()
  }

  private fun setupItemsRecyclerView() {
    val list = viewModel.currencyList
    adapter.setItemsAdapter(list)
    val item = list.find { currency ->
      currency.currencyCode == code
    }
    item?.let { currency ->
      recyclerView.scrollToPosition(list.indexOf(currency))
    }
  }

  override fun onItemClicked(item: CurrencyEntity) {
    mainActivity.showProgressBar(true)
    if (type == getString(R.string.from)) {
      viewModel.setQuoteValue(
        item.currencyCode,
        getString(R.string.from)
      )
    } else {
      viewModel.setQuoteValue(
        item.currencyCode,
        getString(R.string.to)
      )
    }
    closeFragment()
  }

  private fun closeFragment() {
    val dispatcher: OnBackPressedDispatcher = requireActivity().onBackPressedDispatcher
    dispatcher.onBackPressed()
  }

  override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
    searchBarFilter(menu, inflater)
    super.onCreateOptionsMenu(menu, inflater)
  }

  private fun searchBarFilter(menu: Menu, inflater: MenuInflater) {
    inflater.inflate(R.menu.search_sort, menu)
    val searchItem = menu.findItem(R.id.action_search)
    val searchView = searchItem.actionView as SearchView
    searchView.setBackgroundColor(Color.WHITE)

    searchView.setOnQueryTextListener(object : SearchView.OnQueryTextListener {
      override fun onQueryTextSubmit(query: String?): Boolean {
        return true
      }

      override fun onQueryTextChange(newText: String?): Boolean {
        adapter.filter.filter(newText)
        return false
      }
    })

    val editText = searchView.findViewById<EditText>(androidx.appcompat.R.id.search_src_text)
    editText.setHintTextColor(Color.LTGRAY)
    editText.setTextColor(ContextCompat.getColor(context!!, R.color.colorPrimaryDark))
    val clearIcon = searchView.findViewById<ImageView>(androidx.appcompat.R.id.search_close_btn)
    clearIcon.setColorFilter(ContextCompat.getColor(context!!, R.color.colorPrimaryDark))
  }

  override fun onOptionsItemSelected(item: MenuItem): Boolean {
    when (item.itemId) {
      R.id.action_sort_by_code -> {
        sortBy(getString(R.string.sort_by_code))
      }
      R.id.action_sort_by_name -> {
        sortBy(getString(R.string.sort_by_name))
      }
    }
    return super.onOptionsItemSelected(item)
  }

  private fun sortBy(criteria: String) {
    val items = adapter.getItems()
    val sortedItems =
      if (criteria == getString(R.string.sort_by_code)) {
        items.sortedBy {
          it.currencyCode
        }
      } else {
        items.sortedBy {
          it.currencyName
        }
      }
    val arrayList = arrayListOf<CurrencyEntity>()
    adapter.setItemsAdapter(sortedItems.flatMapTo(arrayList) {
      arrayListOf(it)
    })
    recyclerView.scrollToPosition(0)
  }

}
