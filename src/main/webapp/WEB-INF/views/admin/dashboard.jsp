<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Projeto Contas - Dashboard</title>
<!-- Referência da folha de estilos CSS do bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<!-- menu navbar -->
	<jsp:include page="/WEB-INF/views/admin/components/navbar.jsp"></jsp:include>
	<div class="container mt-3">
		
		<h4>Dashboard principal</h4>
		<p>Seja bem vindo ao sistema</p>
		<hr/>
		
		<div class="row">
			<div class="col">
				<div id="graficoDonnut"></div>
			</div>
			<div class="col">
				<div id="graficoColunas"></div>
			</div>
		</div>
		
	</div>
	<!-- Referência do arquivo JS do bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	
	<!-- Highcharts -->
	<script src="https://code.highcharts.com/highcharts.js"></script>
	
	<!-- Arquivo JS -->
	<script src="../resources/js/dashboard.js"></script>
	
</body>
</html>



