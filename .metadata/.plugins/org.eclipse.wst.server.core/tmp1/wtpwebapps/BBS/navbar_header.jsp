<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<script src="//code.jquery.com/jquery-1.11.0.min.js" />
	<%   //�α��� �� ������� ������ ���� �� �ֵ��� ����
		String userID = null;
		if (session.getAttribute("userID") != null) {  //���� ������ �����ϴ� ����̶�� ID���� �״�� �޾� ������ �� �ֵ��� ����
			userID = (String) session.getAttribute("userID");
		}  //userID��� ������ �ش�ID�� ���� �׷��� ���� ������� null
	%>
	
<script type="text/javascript">
	$(document).ready(function() {
		$('.collapse navbar-collapse').find('a[href="' + document.location.pathname + '"]').parents('li').addClass('active');
	});
</script>

	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>  <!-- �޴� -->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp"><img src="images/navTitle.png" height="100%"></a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">����</a></li>  <!-- active: ���� ������ ������ -->
				<li><a href="bbs.jsp">��Ÿ</a></li>
				<li><a href="bbsLife.jsp">����/����</a>
				<li><a href="bbsAnimal.jsp">����</a>
				<li><a href="bbsPlant.jsp">�Ĺ�</a>
				<li><a href="bbsInsect.jsp">����</a>
			</ul>
			<%  //�α��� �Ǿ����� ���� ��츸 ���� �� ����
				if (userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">�����ϱ�<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">�α���</a></li>
						<li><a href="join.jsp">ȸ������</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else {   //�α��� �Ǿ����� ��
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">ȸ������<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">�α׾ƿ�</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
</body>
</html>