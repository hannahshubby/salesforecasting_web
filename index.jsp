<!DOCTYPE html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
		<title>Signin &gt; Sales Forecasting</title>
		<link rel="stylesheet" type="text/css" href="css/login.css" />
		<!--[if lt IE 9]>
			<script type="text/javascript" src="js/html5.js"></script>
		<![endif]-->
		

		
		
	</head>

	<body>
		<!-- wrap -->
		<div id="wrap">	
		<!-- container -->
			<div id="container">
				<article>
					<div id="content">
						<div id="article">
						<article>
		                	<div class="login_area">
				                <h1 class="logo">
							<img src="images/login/logo.png" alt="" />
			         	        </h1>
								<div class="login_form"> 
			                        <form id="frm" action="login.jsp" method="post">
			                        	<fieldset>
			                            	<legend>Sales Forecasting Login</legend>
			                                <label for="login_id">ID</label>
			                                <input type="text" id="login_id" class="login_id" placeholder="id" />
			                                <label for="login_pw">Password</label>
			                                <input type="password" id="login_pw" class="login_pw" placeholder="password" />
											<div class="button-row">
												<a href="" class="btn_login" title="login">
													<span>log in </span>
												</a>
												<a href="" class="btn_login" title="guestlogin">
													<span>guest log in</span>
												</a>
											</div>

			                            </fieldset>
			                        </form>
		                        </div>
							</div>
						</article>
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
		<!-- //wrap -->
	</body>
	
	<script>
		const loginBtn = document.querySelector('a[title="login"]');
		const guestLoginBtn = document.querySelector('a[title="guestlogin"]');

		// 클릭 이벤트 핸들러 추가하기
		loginBtn.addEventListener('click', function(event) {
			// 폼 submit 로직 구현하기
			alert("coming soon. We make it.");
			//event.preventDefault(); // 기본 동작 방지
			//const loginForm = document.querySelector('#frm');
			//loginForm.action = 'login.jsp';
			//loginForm.submit();
		});

		guestLoginBtn.addEventListener('click', function(event) {
			// 폼 submit 로직 구현하기
			event.preventDefault(); // 기본 동작 방지
			const loginForm = document.querySelector('#frm');
			loginForm.action = 'guest_login.jsp';
			loginForm.submit();
		});
	
	</script>
</html>

