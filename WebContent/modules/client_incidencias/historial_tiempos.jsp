<jsp:include page="/config/stylesApp.jsp" flush="true" /><!-- Importar Estilos -->
<!-----------  Importaciones -------------------->
<%@page import="model.TiempoAtencion"%>
<%@page import="controller.Incidencias.TiemposAtencion"%>
<!------------ Definicion de variables---------->
<%! 
	//Variables generales
	private String mensaje=null;
	private String tipoMensaje=null;
	private String controlador="TiemposAtencion";
	
	//Variables de preparacion del formulario
	private TiempoAtencion[] tiemposHistorial=null;
%>
<!-----------  Asignacion  --------------------->
<%
//Inicializa los valores del formulario
TiemposAtencion.preparaPagina(request, response);

//Prepacion del formulario
HttpSession sesion = request.getSession();
tiemposHistorial= (TiempoAtencion[])sesion.getAttribute("tiemposHistorial");
%>
<div class="panel panel-default">
	<div class="panel-heading">
		<span class="tools pull-right"> <i class="fa fa-times"></i>
		</span> <br> <strong>Historial de tiempos de atencion</strong> <br>
	</div>
	<div class="panel-body">
		<%
		if(tiemposHistorial!=null)
		{
		%>
		<table class="table table-hover table-bordered">
			<tr>
				<td class="text-danger" colspan="6">
					<center><b>HISTORIAL DE TIEMPOS</b></center>
				</td>
			</tr>
			<tr>
				<td class="text-center">
					<b>Hora inicio de operacion</b>
				</td>
				<td class="text-center">
					<b>Hora fin de operacion</b>
				</td>
				<td class="text-center">
					<b>Tiempo de atencion (Horas)</b>
				</td>
				<td class="text-center">
					<b>Dia de inicio<br>operacion</b>
				</td>
				<td class="text-center">
					<b>Dia de fin<br>operacion</b>
				</td>
				<td class="text-center">
					<b>Fecha guardado</b>
				</td>
			</tr>			
			<%
			for(TiempoAtencion tiempo:tiemposHistorial)
			{
			%>
			<tr>
				<td class="text-center">						    
					<%=tiempo.getHora_inicio() %>
				</td>
				<td class="text-center">
					<%=tiempo.getHora_fin() %>
				</td>
				<td class="text-center">
					<%=tiempo.getTiempo_atencion() %>
				</td>
				<td class="text-center">
					<%
					String diaInicio="";
				    switch(tiempo.getDia_inicio())
				    {
				    	case 1: diaInicio="Lunes"; break;
				    	case 2: diaInicio="Martes"; break;
				    	case 3: diaInicio="Miercoles"; break;
				    	case 4: diaInicio="Jueves"; break;
				    	case 5: diaInicio="Viernes"; break;
				    	case 6: diaInicio="Sabado"; break;
				    	case 7: diaInicio="Domingo"; break;
				    }
				    %>
					<%=diaInicio %>
				</td>
				<td class="text-center">
					<%
					String diaFin="";
				    switch(tiempo.getDia_fin())
				    {
				    	case 1: diaFin="Lunes"; break;
				    	case 2: diaFin="Martes"; break;
				    	case 3: diaFin="Miercoles"; break;
				    	case 4: diaFin="Jueves"; break;
				    	case 5: diaFin="Viernes"; break;
				    	case 6: diaFin="Sabado"; break;
				    	case 7: diaFin="Domingo"; break;
				    }
				    %>
					<%=diaFin %>
				</td>
			</tr>
			<% 	
			}
			%>			  
		</table>
		<% 
		}
		else
		{
		%>
			No hay registros
		<% 
		}
		%>
		
	</div>
</div>
<jsp:include page="/config/scriptsApp.jsp" flush="true" /><!-- Importar Scripts -->