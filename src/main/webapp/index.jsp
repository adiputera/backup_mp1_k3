<script>
	var role = "${userLogin.role.name}";
	var superr = "${superr}";
	if(superr == 1 || role == 'ROLE_ADMIN'){
		window.location = '${pageContext.request.contextPath}/dashboard';
	}
</script>
<%@ include file="/WEB-INF/view/masterPage/layout.jsp"%>
<section class="content">
	<div class="row text-center">
		<h1>SELAMAT DATANG</h1>
		<h2>POINT OF SALES KELOMPOK 3</h2>
		<h3>Batch 137 - PT XSIS MITRA UTAMA</h3>
	</div>
</section>
</body>
</html>
