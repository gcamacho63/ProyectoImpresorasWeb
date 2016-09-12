<jsp:include page="/config/stylesApp.jsp" flush="true" /><!-- Importar Estilos -->
<%@page import="model.EstadosIncidencia"%>
<%@page import="model.Estado"%>
<%@page import="model.Incidencia"%>
<%@page import="controller.Incidencias.AdministrarIncidencias"%>
<%!
private EstadosIncidencia[] listEstadosIncidencias;
private Incidencia[] incidenciasTemp;
private Incidencia incidencia;

private String mensaje=null;
private String tipoMensaje=null;
%>
<%
listEstadosIncidencias = EstadosIncidencia.Consultar("incidencia='"+request.getParameter("id_incidencia")+"'");
incidenciasTemp=Incidencia.Consultar("id_incidencias='"+request.getParameter("id_incidencia")+"'");
if(incidenciasTemp!=null)
{
	incidencia=incidenciasTemp[0];
}
Estado[] estadosDisponibles=AdministrarIncidencias.consultaEstados(incidencia.getEstadoActual());
%>

<div class="panel panel-default">
	<div class="panel-heading">
		<span class="tools pull-right"> <i class="fa fa-times"></i>
		</span> <br> <strong>Editar Estado</strong> <br>
	</div>
	<%
	//Muestra alerta
	mensaje		=(String)request.getSession().getAttribute("mensaje");
	tipoMensaje =(String)request.getSession().getAttribute("tipoMensaje");
	request.getSession().removeAttribute("mensaje");
	request.getSession().removeAttribute("tipoMensaje");
	if(mensaje!=null)
	{
	%>
	<div class="alert alert-<%=tipoMensaje%>" id="divAlert">
		<%=mensaje %>
		<span class="tools pull-right"> <a href="#"
			onclick="document.getElementById('divAlert').style.display='none';"><i
				class="fa fa-times"></i></a>
		</span>
	</div>
	<%
	}
	%>
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
		<%
		 if(estadosDisponibles!=null)
		 {
		 %>
		<form name="forma" method="post" action="<%= request.getContextPath()%>/AdministrarIncidencias"
			class="form-horizontal">
			<br>
			<div class="center-block">
				<table class="table  table-hover general-table" width="100%">
					<tr>
						<td class="text-center" width="20%"><br> <b>Estado</b></td>
						<td class="text-left"><br>
							<div class="form-group">
								<div class="col-lg-6">
									<select name="estado" id="estado" class="form-control"
										required="required">
										<option value="">Seleccione</option>
										<%		
				                if(estadosDisponibles!=null)
				                {
				                	for(int i=0;i<estadosDisponibles.length;i++)
									{
									%>
										<option value="<%=estadosDisponibles[i].getId_estado() %>"><%=estadosDisponibles[i].getNombre() %></option>
										<%
									}				                	
				                }
				                %>
									</select>
								</div>
							</div></td>
					</tr>
					<tr>
						<td class="text-center"><br> <b>Comentario</b></td>
						<td class="text-center"><textarea class="form-control"
								required="required" name="descripcion" id="descripcion"></textarea>
						</td>
					</tr>
				</table>
				<div class="text-center">
					<input type="submit" class="btn btn-primary" value="Editar"
						name="actualizar" />
				</div>
			</div>
			<input type="hidden" name="id_elemento" id="id_elemento"
				value="<%=incidencia.getId_incidencia()%>">
			<!--Aqui se almacena el ID del elemento que se este modificando-->
		</form>
		<%  
		 }
		 else
		 {
		 %>
		<br>
		<p align="center">
			<b>La incidencia esta cerrada</b>
		</p>
		<% 
		 }
		 %>

	</div>
</div>

<jsp:include page="/config/scriptsApp.jsp" flush="true" /><!-- Importar Scripts -->