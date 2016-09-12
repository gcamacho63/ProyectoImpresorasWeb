<%@page import="controller.Inicio.Login"%>
<div id="wrapper">
	<!-------------------------------- NAVEGACION INICIAL------------------------>
	<nav class="navbar navbar-default navbar-static-top" role="navigation"
		style="margin-bottom: 0">
		<!--BARRA SUPERIOR-->
		<jsp:include page="appBarraSuperior.jsp" flush="true" />
		<!----------------------------------Final Barra superior-------------------------------------->

		<!------------------------------MENU PRINCIPAL--------------------------------------->
		<div class="navbar-default sidebar" role="navigation">
			<jsp:include page="appmenu.jsp" flush="true" />
			<!-- /.sidebar-collapse -->
		</div>
		<!------------------------------ Final MENU PRINCIPAL--------------------------------------->
	</nav>
	<!----------------------------------Final NAV-------------------------------------->

	<!--Divs Morris--->
	<div style="display: none">
		<div id="morris-area-chart"></div>
		<div id="morris-bar-chart"></div>
		<div id="morris-donut-chart"></div>
	</div>

	<div id="page-wrapper">
		<br>
		<!------------------------ESPACIO DE TRABAJO----------------------------------->
		<div id="espacioDeTrabajo">
			<%!
                private String seccion;
                private String modulo;
                private String destino;
                %>
			<%
                    seccion=request.getParameter("sec");
                    modulo=request.getParameter("mod");
                    
                    if(seccion!=null)
                    {
                    	seccion=Login.Desencripta(seccion);
                        modulo=Login.Desencripta(modulo);
                        destino="modules/"+seccion+"/"+modulo;
                    	if(Login.validaPermisos(modulo,request))
                    	{
                    	%>
						<jsp:include page="<%=destino%>" flush="true" />
						<%	
                    	}
                    	else
                    	{
                    	%>
			<jsp:include page="sinPermisos.jsp" flush="true" />
			<%	
                    	}                 
                    }
                    else
                    {
                    %>
			<jsp:include page="inicio.jsp" flush="true" />
			<%
                    }
                %>
		</div>
		<!------------------------Final espacio de trabajo----------------------------------->
	</div>
	<!-- /#page-wrapper -->
</div>
<!-- /#wrapper -->
