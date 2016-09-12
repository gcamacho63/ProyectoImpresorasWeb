<!DOCTYPE html>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="es">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<title>ACGM</title>
<!-- Bootstrap Core CSS -->
<link href="bower_components/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- MetisMenu CSS -->
<link href="bower_components/metisMenu/dist/metisMenu.min.css"
	rel="stylesheet">
<!-- Timeline CSS -->
<link href="dist/css/timeline.css" rel="stylesheet">
<!-- Custom CSS -->
<link href="dist/css/sb-admin-2.css" rel="stylesheet">
<!-- Morris Charts CSS -->
<link href="bower_components/morrisjs/morris.css" rel="stylesheet">
<!-- Custom Fonts -->
<link href="bower_components/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.10.1/themes/base/jquery-ui.css" />
<link media="screen" rel="stylesheet" href="css/colorbox.css" />
</head>
<%@page import="model.Usuario"%>
<%@page import="controller.Inicio.Login"%>
<%!
private Usuario userLog=null;
private String destino=null;
private String query=null;
%>
<%  
	
    userLog=(Usuario) request.getSession().getAttribute("userLog");
    if(userLog==null)
    {
        destino="login.jsp";
    }
    else
    {
    	Login.iniciaUserLog(request);
    	userLog=(Usuario) request.getSession().getAttribute("userLog");
    	if(userLog==null)
    	{
    		destino="login.jsp";
    		request.getSession().setAttribute("errorInicio", "Usuario Inactivo");
    	}
    	else
    	{
    		Login.inicializaMenu(request);
        	destino="applogin.jsp";
    	}  	
    }  
%>
<body>
	<!-------------Pagina Principal-------------->
	<div id="content">
		<jsp:include page="<%=destino%>" flush="true" />
	</div>

	<!-- jQuery -->
	<script src="bower_components/jquery/dist/jquery.min.js"></script>
	<!-- Highcharts -->
	<script src="http://code.highcharts.com/highcharts.js"></script>
	<script src="http://code.highcharts.com/modules/exporting.js"></script>
	<!-- Modal color-box -->
	<script src="js/jquery.colorbox-min.js"></script>

	<script src="http://code.jquery.com/ui/1.10.1/jquery-ui.js"></script>
	<!-- Bootstrap Core JavaScript -->
	<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
	<!-- Metis Menu Plugin JavaScript -->
	<script src="bower_components/metisMenu/dist/metisMenu.min.js"></script>
	<!-- Morris Charts JavaScript -->
	<!-- <script src="bower_components/raphael/raphael-min.js"></script> 
    <script src="bower_components/morrisjs/morris.min.js"></script>
    <script src="js/morris-data.js"></script>-->
	<script src="config/functionsJS.js"></script>
	<!-- Custom Theme JavaScript -->
	<script src="dist/js/sb-admin-2.js"></script>
	<!--  <script src="http://code.jquery.com/jquery-latest.js"></script>-->
</body>
</html>