<jsp:include page="/config/stylesApp.jsp" flush="true" /><!-- Importar Estilos -->
<%@page import="model.EstadosIncidencia"%>
<%@page import="model.Incidencia"%>
<%!
private EstadosIncidencia[] listEstadosIncidencias;
private Incidencia[] incidenciasTemp;
private Incidencia incidencia;
%>
<%
listEstadosIncidencias = EstadosIncidencia.Consultar("incidencia='"+request.getParameter("id_incidencia")+"'");
incidenciasTemp=Incidencia.Consultar("id_incidencias='"+request.getParameter("id_incidencia")+"'");
if(incidenciasTemp!=null)
{
	incidencia=incidenciasTemp[0];
}
%>
<div class="panel panel-default">
	<div class="panel-heading">
		<span class="tools pull-right"> <i class="fa fa-times"></i>
		</span> <br> <strong>Detalles</strong> <br>
	</div>
	<div class="panel-body">
		<table class="table table-hover table-bordered">
			<thead>
				<tr>
					<td class="text-danger" align="center" colspan="9">INCIDENCIA
						NO. <%=request.getParameter("id_incidencia") %></td>
				</tr>
				<tr>
					<td align="center"><b>Socilitante</b></td>
					<td align="center"><%=incidencia.getNombre_solicitante() %></td>
					<td align="center"><b>Encargado</b></td>
					<td align="center"><%=incidencia.getNombre_encargado() %></td>
				</tr>
				<tr>
					<td align="center"><b>Fecha de solicitud</b></td>
					<td align="center"><%=incidencia.getFecha_guardado() %></td>
					<td align="center"><b>Fecha maxima de atencion</b></td>
					<td align="center"><%=incidencia.getFecha_maxima() %></td>
				</tr>
				<tr>
					<td align="center"><b>Tipificacion</b></td>
					<td align="center"><%=incidencia.getNombre_tipificacion() %></td>
					<td align="center"><b>Impresora</b></td>
					<td align="center"><%=incidencia.getSerial_imp() %></td>
				</tr>
				<tr>
					<td align="center"><b>Area</b></td>
					<td align="center"><%=incidencia.getNombre_area() %></td>
					<td align="center"><b>Estado Actual</b></td>
					<td align="center"><%=incidencia.getNombre_estado() %></td>
				</tr>
				<tr>
					<td align="center" colspan="4"><b>Descripcion</b></td>
				</tr>
				<tr>
					<td align="center" colspan="4"><%=incidencia.getDescripcion() %>
					</td>
				</tr>
			</thead>
			<tbody>

			</tbody>
		</table>
		<table class="table table-hover table-bordered">
			<thead>
				<tr>
					<td class="text-danger" align="center" colspan="9">ESTADOS</td>
				</tr>
				<tr>
					<td align="center"><b>ESTADO</b></td>
					<td align="center"><b>FECHA</b></td>
					<td align="center"><b>COMENTARIO</b></td>
				</tr>
			</thead>
			<tbody>
				<% 
			  	if(listEstadosIncidencias!=null)
			  	{
			  		for(EstadosIncidencia est:listEstadosIncidencias)
			  		{
			  		%>
							<tr>
								<td align="center"><%=est.getNombreEstado() %></td>
								<td align="center"><%=est.getFechaGuardado() %></td>
								<td align="center"><%=est.getComentario() %></td>
							</tr>
							<%
			  		}
			  	}
			  	%>
			</tbody>
		</table>
	</div>
</div>
<jsp:include page="/config/scriptsApp.jsp" flush="true" /><!-- Importar Scripts -->