package academy.mukandrew.currencyconverter.commons.extensions

import androidx.appcompat.app.AppCompatActivity
import androidx.fragment.app.Fragment

fun Fragment.showBackButton(show: Boolean) {
    (activity as? AppCompatActivity)?.supportActionBar?.setDisplayHomeAsUpEnabled(show)
}