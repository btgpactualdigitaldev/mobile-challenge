package br.com.mobilechallenge.model

interface Tables {
    companion object {
        const val TB_CURRENCIES = "tb_currencies"
        const val TB_PRICE = "tb_price"
        const val SCRIPT_TB_CUR = "CREATE TABLE tb_currencies " +
                                  "(id   integer             NOT NULL PRIMARY KEY autoincrement, " +
                                  " cd_currency char(3)      NOT NULL default '', " +
                                  " nm_currency varchar(100)          default '');"
        const val SCRIPT_TB_PRI = "CREATE TABLE tb_price " +
                                  "(id            integer       NOT NULL PRIMARY KEY autoincrement, " +
                                  " id_currencies integer       NOT NULL default '0'   , " +
                                  " cd_price      char(3)                default ''    , " +
                                  " vl_price      decimal(14,2)          default '0.00');"
    }
}