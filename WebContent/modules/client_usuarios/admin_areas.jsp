<!-----------  Importaciones -------------------->
<%@page import="model.Area"%>
<%@page import="controller.Usuarios.AreasServlet"%>
<!------------ Definicion de variables---------->
<%! 
	private String mensaje=null;
	private String tipoMensaje=null;
	private Area[] listadoDeObjetos=null; 
	private Area[] editarArray=null;
	private Area objetoEditar=null;
	
	//Servlet
	String controlador="AreasServlet";
	String vacio="";
	
	//Campos del Formulario
	private String nombre="";
	private String descripcion="";
	private int idElemento=0;
	private String titulo="";
%>
<!-----------  Asignacion  --------------------->
<%
AreasServlet.preparaPagina(request, response);
editarArray=(Area[])request.getSession().getAttribute("editarArray");
request.getSession().removeAttribute("editarArray");
if(editarArray!=null)
{
	objetoEditar= editarArray[0];
	nombre=objetoEditar.getNombreArea();
	descripcion=objetoEditar.getDescripcion();
	idElemento=objetoEditar.getIdArea();
	titulo="Editar Areas";
}
else
{
	nombre="";
	descripcion="";
	idElemento=0;
	titulo="Crear Areas";
}

//Listado de elementos existentes
listadoDeObjetos=(Area[])request.getSession().getAttribute("listadoDeObjetos");
request.getSession().removeAttribute("listadoDeObjetos");

//--
vacio = (String)request.getSession().getAttribute("vacio");
request.getSession().removeAttribute("vacio");

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

<!-- Scripts -->
<script>
	function asignarAccion(action)
	{
		$("#accion").val(action);
	}
</script>
<!--------------------  Formulario de inicio ---------------------->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<%=titulo %>
			</div>
			<div class="panel-body">
				<form name="forma" method="post" action="<%=controlador %>"
					class="form-horizontal">
					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Nombre</label>
						<div class="col-lg-8">
							<input type="text" required="required" id="nombre" name="nombre"
								value="<%=nombre %>" class="form-control">
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Descripcion</label>
						<div class="col-lg-8">
							<textarea class="form-control" required="required"
								name="descripcion" id="descripcion"><%=descripcion %></textarea>
						</div>
					</div>

					<div class="text-center">
						<% 
			     	  if(editarArray==null)
			     	  {
			     	  %>
						<input type="submit" class="btn btn-success" value="Crear"
							name="crear" onclick="asignarAccion('crear');" />
						<%
			     	  }
			     	  else
			     	  {
			     	  %>
						<input type="submit" class="btn btn-primary" value="Editar"
							name="actualizar" onclick="asignarAccion('actualizar');" />
						<%  
			     	  }
			     	  %>
					</div>

					<input type="hidden" id="accion" name="accion" /> <input
						type="hidden" name="id_elemento" id="id_elemento"
						value="<%=idElemento %>">
					<!--Aqui se almacena el ID del elemento que se este modificando-->
				</form>
			</div>
			<!-- Panel Body -->
		</div>
	</div>
</div>
<!------------------- LISTADO ----------------->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Areas</div>
			<div class="panel-body">
				<div>
					<table class="table table-hover table-bordered">
						<tr>
							<td class="text-center"><b>Nombre</b></td>
							<td class="text-center"><b>Descripcion</b></td>
							<td class="text-center"><b>Estado</b></td>
							<td class="text-center"><b>Acciones</b></td>
						</tr>
						<%
		           if(listadoDeObjetos!=null)
		           {
		        	 for(int i=0;i < listadoDeObjetos.length ;i++ )
		        	 {
		        		 int idElemento1=listadoDeObjetos[i].getIdArea();
		        		 
		        	%>
						<tr>
							<td class="text-center"><%=listadoDeObjetos[i].getNombreArea() %></td>
							<td class="text-center"><%=listadoDeObjetos[i].getDescripcion() %></td>
							<%
		               String estado="";
		               String color="";
		               if(listadoDeObjetos[i].getEstado()==0)
		               {
		            	   estado="Activo";
		            	   color="green";
		               }
		               else
		               {
		            	   estado="Inactivo";
		            	   color="red";
		               }
		               %>
							<td class="text-center"><font color="<%=color %>"><%=estado %></font></td>
							<td class="text-center"><a
								href="<%=controlador %>?accion=editar&idElemento=<%=idElemento1 %>"><input
									type="button" value="Editar" class="btn btn-info btn-xs" /></a> <%
		               if(listadoDeObjetos[i].getEstado()==0)
		               {
					   %> <a
								href="<%=controlador %>?accion=desactivar&idElemento=<%=idElemento1 %>"><input
									type="button" name="desactivar" id="desactivar"
									value="Desactivar" class="btn btn-danger btn-xs" /></a> <%
		               }
		               else
		               {
		            	%> <a
								href="<%=controlador %>?accion=activar&idElemento=<%=idElemento1 %>"><input
									type="button" name="activar" id="activar" value="Activar"
									class="btn btn-success btn-xs" /></a> <%
		               }
		               %></td>
						</tr>
						<% 
		        	 }
		           }
		           %>
					</table>
				</div>
			</div>
			<!-- Panel body -->
		</div>
	</div>
</div>