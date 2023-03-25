<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page import ="java.io.*,java.text.*,java.util.*"%>
<%
  response.setContentType("application/octet-stream");
  String path="/home/jupyter/";    //path

  // file_name
  String filename = request.getParameter("filenm");



  String upfile_name1=filename; //"convert.20221222.csv";
  String downFile = filename; //"convert.20221222.csv"; //save filenm
  File file = new File(path + upfile_name1);
  System.out.println(file);

  if(file.exists()){
   String file_name2 = new String(downFile.getBytes("euc-kr"),"8859_1");
   response.setHeader("Content-Disposition","attachment; filename="+file_name2);
   //response.setContentType("application/octet-stream");



//2048 byte loop
byte[] bytestream = new byte[2048];
FileInputStream filestream = new FileInputStream(file);

int i = 0, j = 0;



try{
OutputStream outStream = response.getOutputStream();
while ((i = filestream.read(bytestream)) != -1) {
outStream.write(bytestream,0,i);
}
outStream.close();
}catch(IOException e){
}finally{

}






   while((i = filestream.read()) != -1) {
    bytestream[j] = (byte)i;
    j++;
   }
   OutputStream outStream = response.getOutputStream();
   outStream.write(bytestream);
   outStream.close();
  } else {%>
  <script language=javascript>
   alert("<%=upfile_name1%>" + "file not found");
   history.go(-1);
  </script>
  <%}%>
