<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.UUID"%>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
		<title>Sales Forecasting</title>
		<!--<link rel='icon' type='images/png' href='images/common/ci_belkin_logo.jpg'>-->
		<!--<link rel='icon' type='images/png' href='images/common/belkin-pip.png'>-->


		<link rel="stylesheet" href="css/pyscript.css" />
	    <script defer src="js/pyscript.js"></script>

		<link rel="stylesheet" type="text/css" href="css/default.css" />
		<link rel="stylesheet" type="text/css" href="css/common.css" />
		<link rel="stylesheet" type="text/css" href="css/table.css" />
		<link rel="stylesheet" type="text/css" href="css/layout.css" />
		<link rel="stylesheet" type="text/css" href="css/sub.css" />
		<!--[if lt IE 9]>
			<script type="text/javascript" src="js/html5.js"></script>
		<![endif]-->

<%
String strProd = "";
String str_filenm = "";
String strStDt = "0";
String strPeriodCnt = "6";

if (request.getParameter("prod")==null) {
  strProd = "";  
} else {
  strProd = request.getParameter("prod").toUpperCase();  
}

if (request.getParameter("st_dt")==null) {
  strStDt = "0";
}
else if (request.getParameter("st_dt").trim().equals("")) {
  strStDt = "0";
} else {
  strStDt = request.getParameter("st_dt").toUpperCase();
}

if (request.getParameter("period_cnt")==null) {
  strPeriodCnt="6"; 
}
else if (request.getParameter("period_cnt").trim().equals("")) {
  strPeriodCnt="6";
} else {
  strPeriodCnt = request.getParameter("period_cnt").toUpperCase();
}



 try {
  if (!strProd.equals("")) {
 
	  UUID one = UUID.randomUUID();
	  str_filenm = strProd + "_" + one.toString() + ".csv";

          //out.println("/home/jupyter/sell_thru.sh " + strProd + " " + str_filenm + " " + strStDt.replaceAll("-", "") + " " + strPeriodCnt);

	  Process child =  Runtime.getRuntime().exec("/home/jupyter/sell_thru.sh " + strProd + " " + str_filenm + " " + strStDt.replaceAll("-", "") + " " + strPeriodCnt);

	  InputStream in = child.getInputStream();
	  String strResult = new String();
	  int c;

	  while ((c = in.read()) != -1) {
	   strResult = strResult + new String(new Character((char)c).toString());
	  }
	  in.close();

	  child.destroy();
	  child.waitFor();
   }

 } catch (IOException ex) {
  ex.printStackTrace();
 }


%>





<% if(!str_filenm.equals("")) { %>

    <py-config type="json">
        {
          "packages": ["mpld3", "pandas", "matplotlib"]
        }
    </py-config>


	<py-script >
#from js import document
#from pyodide import create_proxy
#import pandas as pd
#import matplotlib.pyplot as plt
#from pyodide.http import open_url


#def button_click(event):
def run_predict():
        from js import document
        from pyodide import create_proxy

        import pandas as pd
        import matplotlib.pyplot as plt
        from pyodide.http import open_url

        url = (
     	   "http://salesforecasting.info/download.jsp?filenm=<%=str_filenm%>"
        )
        df_full_forecast = pd.read_csv(open_url(url))

        c = document.getElementById("table_area")
        c.innerHTML = df_full_forecast[["ds_y", "y", "yhat"]].to_html(col_space=[200, 100, 300], na_rep="0", classes="list fixed")
        
        plt.figure(figsize=(15, 10))
        fcst_t = df_full_forecast["ds_y"].to_list()
        plt.plot(fcst_t, df_full_forecast["y"].to_list(), "o-")
        plt.fill_between(fcst_t, df_full_forecast["yhat_lower"], df_full_forecast["yhat_upper"], color="#0072B2", alpha=0.2)
        plt.grid()
        plt.xticks(rotation=90)        
        
        display(plt, target="div_plot")



def setup():
	# The page is ready, clear the "page loading"
	
	# Create a JsProxy for the callback function
	click_proxy = create_proxy(button_click)
 
	# Set the listener to the callback
	e = document.getElementById("btn_search")
	e.addEventListener("click", click_proxy)
 
#setup()
run_predict()

  </py-script>
<% } %>

  <script>
    function frm_submit()
    {
       frm.submit();
    }		     

  </script>		     

	</head>

	<body>
        <form id="frm" name="frm" action="main.jsp" method="post">

	<div id="wrap">
		<!-- skip_nav --> 
		<div id="skip_nav">  
		</div>
		<!-- //skip --> 
		
		<!-- header -->
		<div id="header">
		<header>
			<h1 class="home_logo"><img width="185" height="45" src="images/common/logo.png" alt="Belkin" /></h1>
			<!-- gnb_menu -->
			<div id="nav">
			<nav>
				<ul class="menu">
				</ul>
			</nav>
			</div>
			<!-- hsection -->
			<div class="hsection_area">
				
			</div>
			<!-- //hsection -->
		</header>
		</div>
		<!-- //header -->
		<!-- container -->
		<div id="container">
		<article>
			<!-- left_area -->
			<div class="left_area">
				<div class="lnb_area">
					<!-- left_info_area -->
					<div class="left_info_area">

					</div>
					<!--// left_info_area -->
					<!-- lnb -->
					<div class="lnb_area">

						<ul class="lnb">
							<li class="on">
								<a href="#">
									<span>Managing Sell Product</span>
								</a>
								<ul class="lnb_submenu">
									<li class="on">
										<a href="#">
											<span>Predict Sell-Thru</span>
										</a>
									</li>
									<li>
										<a href="#">
											<span>Predict Sell-In</span>
										</a>
									</li>
									<li>
										<a href="#">
											<span>Managing Product</span>
										</a>
									</li>
									<li>
										<a href="#">
											<span>Manageing Inventory</span>
										</a>
									</li>

								</ul>
							</li>
						</ul>
					</div>
					<!--// lnb -->
				</div>
			</div>
			<!--// left_area -->
			<div class="content_area">
				<div class="location">
					<ul>
						<li>HOME</li>
						<li>Managing Product</li>
						<li>
							<strong>Sell-Thru Predict</strong>
						</li>
					</ul>
				</div>
				<div id="content">
					<!-- main_title -->
					<div class="main_title">
						<h3 class="title">Predict Sell-Thru</h3>
					</div>
					<!--// main_title -->



					<div class="button_area">
						Product Name : <input type="text" id="prod" name="prod" value="<%=strProd%>"/>
						Cut Date : <input type="text" id="st_dt" name="st_dt" value="<%out.println(strStDt.equals("0") ? "" : strStDt);%>"/>
						Period Count : <input type="text" id="period_cnt" name="period_cnt" value="<%out.println(strPeriodCnt.equals("") ? "6" : strPeriodCnt);%>"/>

						<div class="float_right">
							<button class="btn save" title="search" id="btn_search" onclick="javascript:frm_submit();" > 
								<span>search</span>
							</button>
						</div>
					</div>


					<!-- table 1dan list -->
					<div class="table_area">
                                                <div id="table_area"></div>
						<div id="div_plot"></div>

					</div>
					<!--// table 1dan list -->
					<!-- button_area -->
					<!--<div class="button_area">
						<div class="float_right">
							<button class="btn save" title="추가하기">
								<span>추가하기</span>
							</button>
						</div>
					</div>-->
					<!--// button_area -->
				</div>
			</div>
		</article>	
		</div>
		<!-- //container -->
		<!-- footer --> 
		<div id="footer">
		<footer>
			
		</footer>
		</div>
		<!-- //footer -->
	</div>
        </form> 
	</body>
</html>
