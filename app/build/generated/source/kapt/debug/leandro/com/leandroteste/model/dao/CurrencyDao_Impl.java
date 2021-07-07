package leandro.com.leandroteste.model.dao;

import android.database.Cursor;
import androidx.room.EntityDeletionOrUpdateAdapter;
import androidx.room.EntityInsertionAdapter;
import androidx.room.RoomDatabase;
import androidx.room.RoomSQLiteQuery;
import androidx.sqlite.db.SupportSQLiteStatement;
import java.lang.Override;
import java.lang.String;
import java.lang.SuppressWarnings;
import java.util.ArrayList;
import java.util.List;
import leandro.com.leandroteste.model.data.Currency;

@SuppressWarnings("unchecked")
public final class CurrencyDao_Impl implements CurrencyDao {
  private final RoomDatabase __db;

  private final EntityInsertionAdapter __insertionAdapterOfCurrency;

  private final EntityDeletionOrUpdateAdapter __deletionAdapterOfCurrency;

  public CurrencyDao_Impl(RoomDatabase __db) {
    this.__db = __db;
    this.__insertionAdapterOfCurrency = new EntityInsertionAdapter<Currency>(__db) {
      @Override
      public String createQuery() {
        return "INSERT OR REPLACE INTO `Currency`(`initials`,`name`) VALUES (?,?)";
      }

      @Override
      public void bind(SupportSQLiteStatement stmt, Currency value) {
        if (value.getInitials() == null) {
          stmt.bindNull(1);
        } else {
          stmt.bindString(1, value.getInitials());
        }
        if (value.getName() == null) {
          stmt.bindNull(2);
        } else {
          stmt.bindString(2, value.getName());
        }
      }
    };
    this.__deletionAdapterOfCurrency = new EntityDeletionOrUpdateAdapter<Currency>(__db) {
      @Override
      public String createQuery() {
        return "DELETE FROM `Currency` WHERE `initials` = ?";
      }

      @Override
      public void bind(SupportSQLiteStatement stmt, Currency value) {
        if (value.getInitials() == null) {
          stmt.bindNull(1);
        } else {
          stmt.bindString(1, value.getInitials());
        }
      }
    };
  }

  @Override
  public void insertAll(Currency... currencies) {
    __db.beginTransaction();
    try {
      __insertionAdapterOfCurrency.insert(currencies);
      __db.setTransactionSuccessful();
    } finally {
      __db.endTransaction();
    }
  }

  @Override
  public void delete(Currency currency) {
    __db.beginTransaction();
    try {
      __deletionAdapterOfCurrency.handle(currency);
      __db.setTransactionSuccessful();
    } finally {
      __db.endTransaction();
    }
  }

  @Override
  public List<Currency> getAll() {
    final String _sql = "SELECT * FROM currency";
    final RoomSQLiteQuery _statement = RoomSQLiteQuery.acquire(_sql, 0);
    final Cursor _cursor = __db.query(_statement);
    try {
      final int _cursorIndexOfInitials = _cursor.getColumnIndexOrThrow("initials");
      final int _cursorIndexOfName = _cursor.getColumnIndexOrThrow("name");
      final List<Currency> _result = new ArrayList<Currency>(_cursor.getCount());
      while(_cursor.moveToNext()) {
        final Currency _item;
        final String _tmpInitials;
        _tmpInitials = _cursor.getString(_cursorIndexOfInitials);
        final String _tmpName;
        _tmpName = _cursor.getString(_cursorIndexOfName);
        _item = new Currency(_tmpInitials,_tmpName);
        _result.add(_item);
      }
      return _result;
    } finally {
      _cursor.close();
      _statement.release();
    }
  }
}
