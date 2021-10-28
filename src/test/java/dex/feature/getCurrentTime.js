 function getCurrentTime() {
    var SimpleDateFormat = Java.type('java.text.SimpleDateFormat');
    var sdf = new SimpleDateFormat('yyyyMMddHHmmss');
    var date = new java.util.Date();
    return sdf.format(date);
  }