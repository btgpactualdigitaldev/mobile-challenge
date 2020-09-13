package br.com.rcp.currencyconverter.activities

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.navigation.NavController
import androidx.navigation.Navigation
import androidx.navigation.fragment.NavHostFragment
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.navigateUp
import br.com.rcp.currencyconverter.R

class MainActivity : AppCompatActivity() {
	private	val	controller : NavController by lazy { (supportFragmentManager.findFragmentById(R.id.host) as NavHostFragment).navController }

	override fun onCreate(savedInstanceState: Bundle?) {
		super.onCreate(savedInstanceState)
		setContentView(R.layout.activity_main)
		setNavigationGraph()
	}

	override fun onSupportNavigateUp(): Boolean {
		return controller.navigateUp() || super.onSupportNavigateUp()
	}

	private fun setNavigationGraph() {
		controller.navInflater.inflate(R.navigation.graph_main)
	}
}