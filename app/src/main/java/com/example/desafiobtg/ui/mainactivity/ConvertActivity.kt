package com.example.desafiobtg.ui.mainactivity

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.fragment.app.FragmentManager
import com.example.desafiobtg.databinding.ActivityConvertBinding
import com.example.desafiobtg.ui.convert.ConvertFragment
import com.example.desafiobtg.ui.listcurrency.CurrencyListFragment

class ConvertActivity : AppCompatActivity(), ConvertFragment.OnButtonClicked {
    companion object {
        lateinit var fm: FragmentManager
        var NAV_CONTROL = false
    }

    private lateinit var binding: ActivityConvertBinding
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityConvertBinding.inflate(layoutInflater)
        setContentView(binding.root)
        fm = supportFragmentManager

        fm.beginTransaction().add(binding.fragmentContainer.id, ConvertFragment.newInstance())
                .commit()
    }

    override fun onclicked() {
        fm.beginTransaction()
                .replace(binding.fragmentContainer.id, CurrencyListFragment.newInstance())
                .addToBackStack(null)
                .commit()
    }

}