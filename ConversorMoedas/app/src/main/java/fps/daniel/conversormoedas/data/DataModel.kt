package fps.daniel.conversormoedas.data

import io.realm.RealmObject
import io.realm.annotations.PrimaryKey

open class DataModel (
    @PrimaryKey
    var symbol: String = "",
    var name: String = "",
    var quote: Double = 0.0
) : RealmObject()