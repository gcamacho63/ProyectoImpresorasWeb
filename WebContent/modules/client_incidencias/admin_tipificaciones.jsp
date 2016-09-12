<!-----------  Importaciones -------------------->
<%@page import="model.Tipificacion"%>
<!------------ Definicion de variables---------->
<%! 
	private String mensaje=null;
	private String tipoMensaje=null;
	private Tipificacion[] tip=null; 
	private Tipificacion[] tipEditarArray=null;
	private Tipificacion editar=null;
	
	//Campos del Formulario
	String nombre="";
	String descripcion="";
	int idEditar=0;
	String titulo="";
%>
<!-----------  Asignacion  --------------------->
<%
tipEditarArray=tip=(Tipificacion[])request.getSession().getAttribute("tipEditar");
request.getSession().removeAttribute("tipEditar");
request.getSession().removeAttribute("tipEditar");
if(tipEditarArray!=null)
{
	editar= tipEditarArray[0];
	nombre=editar.getNombre();
	descripcion=editar.getDescripcion();
	idEditar=editar.getId_tipificacion();
	titulo="Editar tipificacion";
}
else
{
	nombre="";
	descripcion="";
	idEditar=0;
	titulo="Crear tipificacion";
}

//Listado de elementos existentes
tip=(Tipificacion[])request.getSession().getAttribute("tip");
request.getSession().removeAttribute("tip");

//Valida si el objeto del listado esta activo, de lo contrario dispara nuevamente
//al controlador para actualizarlo
if(tip==null)
{
	%>
<script>
		window.location.href = 'TipificaServlet';
	</script>
<%
}
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
				<form name="forma" method="post" action="TipificaServlet"
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
			     	  if(tipEditarArray==null)
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
						value="<%=idEditar %>">
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
			<div class="panel-heading">Tipificaciones</div>
			<div class="panel-body">

				<!-- <div class="col-lg-10">
			     <div class="form-group input-group">
                      <input type="text" class="form-control" placeholder="Campo para busqueda en la tabla">
                      <span class="input-group-btn">
                          <button class="btn btn-default" type="button"><i class="fa fa-search"></i>
                          </button>
                      </span>
                  </div>
			    </div> -->

				<div>
					<table class="table table-hover table-bordered">
						<tr>
							<td class="text-center"><b>Nombre</b></td>
							<td class="text-center"><b>Descripcion</b></td>
							<td class="text-center"><b>Estado</b></td>
							<td class="text-center"><b>Acciones</b></td>
						</tr>
						<%
		           if(tip!=null)
		           {
		        	 for(int i=0;i < tip.length ;i++ )
		        	 {
		        	%>
						<tr>
							<td class="text-center"><%=tip[i].getNombre() %></td>
							<td class="text-center"><%=tip[i].getDescripcion() %></td>
							<%
		               String estado="";
		               String color="";
		               if(tip[i].getEstado()==0)
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
								href="TipificaServlet?accion=editar&idTipificacion=<%=tip[i].getId_tipificacion() %>"><input
									type="button" value="Editar" class="btn btn-info btn-xs" /></a> <%
		               if(tip[i].getEstado()==0)
		               {
					   %> <a
								href="TipificaServlet?accion=desactivar&idTipificacion=<%=tip[i].getId_tipificacion() %>"><input
									type="button" name="desactivar" id="desactivar"
									value="Desactivar" class="btn btn-danger btn-xs" /></a> <%
		               }
		               else
		               {
		            	%> <a
								href="TipificaServlet?accion=activar&idTipificacion=<%=tip[i].getId_tipificacion() %>"><input
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
