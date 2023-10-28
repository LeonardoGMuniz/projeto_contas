<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
				
		<div class="row">
			<div class="col">
				
				<h4>Dashboard principal</h4>
				<p>Seja bem vindo ao sistema de controle de contas.</p>
				
				<div class="card">
					<div class="card-body">
					
						<form id="formDashboard" action="dashboard" method="get">
						
							<div class="row">
								<div class="col">
									<select id="mes" name="mes" class="form-select">
										<option value="1" ${mesAtual == 1 ? "selected" : ""}>Janeiro</option>
										<option value="2" ${mesAtual == 2 ? "selected" : ""}>Fevereiro</option>
										<option value="3" ${mesAtual == 3 ? "selected" : ""}>Março</option>
										<option value="4" ${mesAtual == 4 ? "selected" : ""}>Abril</option>
										<option value="5" ${mesAtual == 5 ? "selected" : ""}>Maio</option>
										<option value="6" ${mesAtual == 6 ? "selected" : ""}>Junho</option>
										<option value="7" ${mesAtual == 7 ? "selected" : ""}>Julho</option>
										<option value="8" ${mesAtual == 8 ? "selected" : ""}>Agosto</option>
										<option value="9" ${mesAtual == 9 ? "selected" : ""}>Setembro</option>
										<option value="10" ${mesAtual == 10 ? "selected" : ""}>Outubro</option>
										<option value="11" ${mesAtual == 11 ? "selected" : ""}>Novembro</option>
										<option value="12" ${mesAtual == 12 ? "selected" : ""}>Dezembro</option>
									</select>
								</div>
								<div class="col">
									<select id="ano" name="ano" class="form-select">
										<option value="2020" ${anoAtual == 2020 ? "selected" : ""}>2020</option>
										<option value="2021" ${anoAtual == 2021 ? "selected" : ""}>2021</option>
										<option value="2022" ${anoAtual == 2022 ? "selected" : ""}>2022</option>
										<option value="2023" ${anoAtual == 2023 ? "selected" : ""}>2023</option>
										<option value="2024" ${anoAtual == 2024 ? "selected" : ""}>2024</option>
										<option value="2025" ${anoAtual == 2025 ? "selected" : ""}>2025</option>
									</select>
								</div>
								<div class="col d-grid">
									<input type="submit" class="btn btn-primary" value="Filtrar Dados"/>
								</div>
							</div>
						</form>
					</div>
				</div>
				
				<div class="mt-3 card">
					<div class="card-body bg-success text-white">
						<div class="row">
							<div class="col">
								<h5 class="mt-1">Total de contas a receber:</h5>						
							</div>
							<div class="col">
								<h4>
									<strong>
										<fmt:formatNumber value="${totalContasAReceber}"
											type="currency" currencySymbol="R$"/>
									</strong>
								</h4>
							</div>
						</div>
					</div>
				</div>
				
				<div class="mt-2 card">
					<div class="card-body bg-danger text-white">
						<div class="row">
							<div class="col">
								<h5 class="mt-1">Total de contas a pagar:</h5>						
							</div>
							<div class="col">
								<h4>
									<strong>
										<fmt:formatNumber value="${totalContasAPagar}"
											type="currency" currencySymbol="R$"/>
									</strong>
								</h4>
							</div>
						</div>
					</div>
				</div>
				
				<div class="mt-2 card">
					<div class="card-body bg-light">
						<div class="row">
							<div class="col">
								<c:choose>
									<c:when test="${totalContasAReceber - totalContasAPagar > 0}">
										<h5 class="mt-1">Saldo positivo:</h5>
									</c:when>
									<c:otherwise>
										<h5 class="mt-1">Saldo negativo:</h5>
									</c:otherwise>
								</c:choose>						
							</div>
							<div class="col">
								<h4>
									<strong>
										<fmt:formatNumber value="${totalContasAReceber - totalContasAPagar}"
											type="currency" currencySymbol="R$"/>
									</strong>
								</h4>
							</div>
						</div>
					</div>
				</div>
				
			</div>
			<div class="col">
				<div id="graficoDonnut"></div>
			</div>
		</div>
		
	</div>
	<!-- Referência do arquivo JS do bootstrap -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	
	<!-- Highcharts -->
	<script src="https://code.highcharts.com/highcharts.js"></script>
	
	<!-- Conteúdo JS -->
	<script>
	
		// Dados para o gráfico Donut
		var donutData = [{
				name: 'Contas a Pagar',
				y: ${totalContasAPagar},
			}, {
				name: 'Contas a Receber',
				y: ${totalContasAReceber},
			}];
		
		var successColor = '#28a745';
		var dangerColor = '#dc3545';
	
		// Configuração do gráfico Donut (Gráfico de Rosca)
		Highcharts.chart('graficoDonnut', {
			chart: {
				type: 'pie',
			},
			title: {
				text: 'Total de Contas Pagar/Receber',
			},
			subtitle: {
				text: 'Comparativo de contas a receber e contas a pagar<br/>do mês ${mesAtual}/${anoAtual}'
			},
			plotOptions: {
				pie: {
					innerSize: '60%',
					colors: [dangerColor, successColor],
					dataLabels: {
						enabled: false
					},
					showInLegend: true
				},
			},
			tooltip: {
				pointFormat: '<b>{point.name}</b>: {point.y}',
			},
			series: [{
				name: 'Contas',
				data: donutData,
			}],
			credits: false
		});
	
	</script>
	
</body>
</html>



