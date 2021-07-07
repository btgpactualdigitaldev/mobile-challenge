package androidx.databinding;

public class DataBinderMapperImpl extends MergedDataBinderMapper {
  DataBinderMapperImpl() {
    addMapper(new leandro.com.leandroteste.DataBinderMapperImpl());
  }
}
