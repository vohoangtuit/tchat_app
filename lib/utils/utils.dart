class Utils{
  static final Utils _singleton = Utils._internal();

  factory Utils() {
    return _singleton;
  }

  Utils._internal();
  static bool? isNotEmpty(String? string){

    if(string==null){
      return false;
    }
    if(string.isEmpty){
      return false;
    }
    if(string.isNotEmpty){
      return true;
    }
    return true;
  }
}