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
<div class="panel panel-default">
	<div class="panel-heading">
		<span class="tools pull-right"> <i class="fa fa-times"></i>
		</span> <br> <strong>Subir Imagen de perfil</strong> <br>
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
		<form name="forma" method="post" action="<%= request.getContextPath()%>/PerfilServlet" class="form-horizontal" enctype="multipart/form-data">
			<div class="center-block">
				<table class="table  table-hover general-table" width="100%">
					<tr>
						<td class="text-right" width="40%"><br> <b>Imagen</b></td>
						<td class="text-left"> 
						<div class="form-group">
					      <div class="col-lg-8">
					      <br>
					       <input type="file" required="required" id="imagen" accept="image/gif, image/jpeg, image/png" name="imagen"   value="">
					      </div>
					     </div>
						</td>
					</tr>
				</table>
				<div class="text-center">
					<input type="submit" class="btn btn-primary" value="Subir" name="subir" />
				</div>
			</div>
			<input type="hidden" name="id_elemento" id="id_elemento"
				value="">
			<!--Aqui se almacena el ID del elemento que se este modificando-->
		</form>		
	</div>
</div>
<jsp:include page="/config/scriptsApp.jsp" flush="true" /><!-- Importar Scripts -->