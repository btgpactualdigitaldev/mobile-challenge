package com.example.mobile_challenge.main

import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import androidx.fragment.app.Fragment
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.Observer
import com.example.mobile_challenge.MainActivity
import com.example.mobile_challenge.R
import java.text.DecimalFormat

class ResultFragment : Fragment() {

  companion object {
    fun newInstance() = ResultFragment()
  }

  private lateinit var root: View
  private lateinit var input: EditText
  private lateinit var result: TextView
  private lateinit var fromBtn: Button
  private lateinit var toBtn: Button
  private lateinit var mainActivity: MainActivity
  private val viewModel: MainViewModel by activityViewModels()
  private var currencyValue = 0.0
  val currencyFormat = "###,###.00"

  override fun onCreateView(
    inflater: LayoutInflater, container: ViewGroup?,
    savedInstanceState: Bundle?
  ): View {
    root = inflater.inflate(R.layout.result_fragment, container, false)
    findView()
    clickListeners()
    setInputFormat()
    observers()
    return root
  }

  private fun findView() {
    input = root.findViewById(R.id.value_input)
    result = root.findViewById(R.id.value_result)
    fromBtn = root.findViewById(R.id.from_currency)
    toBtn = root.findViewById(R.id.to_currency)
    mainActivity = activity as MainActivity
    mainActivity.showProgressBar(true)
  }

  private fun clickListeners() {
    fromBtn.setOnClickListener {
      openSelectionFragment(getString(R.string.from))
    }

    toBtn.setOnClickListener {
      openSelectionFragment(getString(R.string.to))
    }
  }

  private fun openSelectionFragment(type: String) {
    val bundle = Bundle()
    bundle.putString(getString(R.string.type), type)
    if (type == getString(R.string.from)) {
      bundle.putString(getString(R.string.code), fromBtn.text.toString())
    } else {
      bundle.putString(getString(R.string.code), toBtn.text.toString())
    }
    val fragment = SelectionFragment.newInstance()
    fragment.arguments = bundle
    if (activity?.supportFragmentManager?.findFragmentByTag(getString(R.string.selection_fragment)) == null) {
      activity?.supportFragmentManager?.beginTransaction()
        ?.replace(R.id.container, fragment)
        ?.addToBackStack(getString(R.string.selection_fragment))
        ?.commit()
    }
  }

  private fun setInputFormat() {
    var current = ""
    input.addTextChangedListener(object : TextWatcher {
      override fun afterTextChanged(s: Editable?) { currencyValue.setResult() }

      override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}

      override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {
        val stringText = s.toString()
        if (stringText != current) {
          input.removeTextChangedListener(this)
          val cleanString = stringText.replace("[,.]".toRegex(), "")
          val parsed = cleanString.toDouble()
          if (parsed != 0.0) {
            val formatter = DecimalFormat(currencyFormat)
            val formatted = formatter.format(parsed / 100)
            current = formatted
            input.setText(formatted)
            input.setSelection(formatted.length)
          } else {
            current = ""
            input.setText("")
            currencyValue.setResult()
          }
          input.addTextChangedListener(this)
        }
      }
    })
  }

  private fun observers() {
    viewModel.liveValue.observe(viewLifecycleOwner, Observer { value ->
      mainActivity.showProgressBar(false)
      currencyValue = value
      currencyValue.setResult()
    })

    viewModel.error.observe(viewLifecycleOwner, Observer { error ->
      mainActivity.showProgressBar(false)
      Toast.makeText(context, error?.let { getString(it) } ?: getString(R.string.connection_error), Toast.LENGTH_LONG).show()
    })

    viewModel.fromCode.observe(viewLifecycleOwner, Observer { code ->
      fromBtn.text = code
    })

    viewModel.toCode.observe(viewLifecycleOwner, Observer { code ->
      toBtn.text = code
    })
  }

  fun Double.setResult() {
    val stringText = input.text.toString()
    val finalResult = if (stringText == "") {
      1000 * this
    } else {
      val cleanString = stringText.replace("[,.]".toRegex(), "")
      val parsed = cleanString.toDouble() / 100
      parsed * this
    }
    val formatter = DecimalFormat(currencyFormat)
    result.text = formatter.format(finalResult)
  }

  override fun onPause() {
    super.onPause()
    mainActivity.showProgressBar(false)
  }
}
