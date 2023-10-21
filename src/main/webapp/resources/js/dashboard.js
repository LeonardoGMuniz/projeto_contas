// Dados para o gráfico Donut
var donutData = [{
name: 'Contas a Pagar',
y: 50, // Substitua com o número correto de contas a pagar
}, {
name: 'Contas a Receber',
y: 75, // Substitua com o número correto de contas a receber
}];
// Dados para o gráfico de colunas
var colunasData = [{
name: 'Data 1',
y: 10, // Substitua com o número correto de contas cadastradas para a Data 1
}, {
name: 'Data 2',
y: 20, // Substitua com o número correto de contas cadastradas para a Data 2
}, {
name: 'Data 3',
y: 15, // Substitua com o número correto de contas cadastradas para a Data 3
}];
// Configuração do gráfico Donut (Gráfico de Rosca)
Highcharts.chart('graficoDonnut', {
chart: {
type: 'pie',
},
title: {
text: 'Total de Contas',
},
plotOptions: {
pie: {
innerSize: '50%', // Ajuste o valor para controlar o tamanho do "buraco" no donut
},
},
series: [{
name: 'Contas',
data: donutData,
}],
});
// Configuração do gráfico de colunas
Highcharts.chart('graficoColunas', {
chart: {
type: 'column',
},
title: {
text: 'Contas Cadastradas por Data',
},
xAxis: {
type: 'category',
},
yAxis: {
title: {
text: 'Quantidade de Contas',
},
},
series: [{
name: 'Contas',
data: colunasData,
}],
});



