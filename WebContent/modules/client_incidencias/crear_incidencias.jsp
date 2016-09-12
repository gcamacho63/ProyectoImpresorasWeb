<!-----------  Importaciones -------------------->
<%@page import="model.Incidencia"%>
<%@page import="model.Impresora"%>
<%@page import="model.Tipificacion"%>
<%@page import="controller.Incidencias.CrearIncidencias"%>
<!------------ Definicion de variables---------->
<%! 
    //Variables generales
	private String mensaje=null;
	private String tipoMensaje=null;
	private Incidencia[] listadoDeObjetos=null; 
	private Incidencia[] editarArray=null;
	private Incidencia objetoEditar=null;
	
	//Servlet
	String controlador="CrearIncidencias";
	
	//Variable preparacion del formulario
	private Tipificacion[] tipificaciones=null;
	private Impresora[] impresoras=null;
	//private Tipificacion[] tipificaciones=null;
	
	
	//Campos del Formulario
	
	private String nombre_tipificacion="";
	private String descripcion="";
	private String prioridad="";
	private int idElemento=0;
	private String archivo;
	private String servlet;
	private String titulo="";
	
	private int grupoActual;
%>
<!-----------  Asignacion  --------------------->
<%
CrearIncidencias.preparaPagina(request, response);
HttpSession sesion = request.getSession();
//Elementos de preparacion del Formulario
impresoras= (Impresora[])sesion.getAttribute("impresoras");
tipificaciones= (Tipificacion[])sesion.getAttribute("tipificaciones");

//Listado de elementos existentes
listadoDeObjetos=(Incidencia[])request.getSession().getAttribute("listadoDeObjetos");
request.getSession().removeAttribute("listadoDeObjetos");

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
<script src="bower_components/jquery/dist/jquery.min.js"></script>
<script>
	function asignarAccion(action)
	{
		$("#accion").val(action);
	}
	$(document).ready(function() 
	{
	    generarModal("detalle","1000","600");
	});
</script>
<!--------------------  Formulario de inicio ---------------------->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<strong><center>CREAR INCIDENCIA</center></strong>
			</div>
			<div class="panel-body">
				<form name="forma" method="post" action="<%=controlador %>"
					class="form-horizontal">
					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Impresora</label>
						<div class="col-lg-8">
							<select name="impresora" id="impresora" class="form-control"
								required="required">
								<option value="">Seleccione</option>
								<%		
		                if(impresoras!=null)
		                {
		                	for(int i=0;i<impresoras.length;i++)
							{
							%>
								<option value="<%=impresoras[i].getId_impresora() %>"><%=impresoras[i].getNombre_area() %>
									-
									<%=impresoras[i].getSerial() %></option>
								<%
							}				                	
		                }
		                %>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Tipificacion</label>
						<div class="col-lg-8">
							<select name="tipificacion" id="tipificacion"
								class="form-control" required="required">
								<option value="">Seleccione</option>
								<%		
		                if(tipificaciones!=null)
		                {
		                	for(int i=0;i<tipificaciones.length;i++)
							{								
							%>
								<option value="<%=tipificaciones[i].getId_tipificacion() %>"><%=tipificaciones[i].getNombre() %></option>
								<%
							}				                	
		                }
		                %>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Prioridad</label>
						<div class="col-lg-8">
							<select name="prioridad" id="prioridad" class="form-control"
								required="required">
								<option value="">Seleccione</option>
								<option value="Baja">Baja</option>
								<option value="Media">Media</option>
								<option value="Importante">Importante</option>

							</select>
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Descripción
						</label>
						<div class="col-lg-8">
							<textarea class="form-control" name="descripcion"
								value="<%=descripcion %>" id="descripcion"></textarea>
						</div>
					</div>

					<div class="text-center">
						<% 
			     	  if(editarArray==null)
			     	  {
			     	  %>
						<input type="submit" class="btn btn-success" value="Guardar"
							name="guardar" onclick="asignarAccion('crear');" />
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

					<input type="hidden" name="accion" id="accion" /> <input
						type="hidden" name="id_elemento" id="id_elemento" value="">
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
			<div class="panel-heading">
				<strong><center>INCIDENCIAS</center></strong>
			</div>

			<div>
				<table border="0" cellpadding="0" cellspacing="0"
					class="table table-hover table-bordered">
					<tr>
						<td class="text-center"><b>No de Caso</b></td>
						<td class="text-center"><b>Impresora</b></td>
						<td class="text-center"><b>Area</b></td>
						<td class="text-center"><b>Tipificacion</b></td>
						<td class="text-center"><b>Prioridad</b></td>
						<td class="text-center"><b>Estado</b></td>
						<td class="text-center"><b>Detalles</b></td>

					</tr>
					<%
		           if(listadoDeObjetos!=null)
		           {
		        	 for(int i=0;i < listadoDeObjetos.length ;i++ )
		        	 {
		        		 int idElemento1=listadoDeObjetos[i].getId_incidencia();
		        		 
		        	%>
					<tr>
						<td class="text-center">No. <%=listadoDeObjetos[i].getId_incidencia() %></td>
						<td class="text-center"><%=listadoDeObjetos[i].getSerial_imp() %></td>
						<td class="text-center"><%=listadoDeObjetos[i].getNombre_area() %></td>
						<td class="text-center"><%=listadoDeObjetos[i].getNombre_tipificacion() %></td>
						<td class="text-center"><%=listadoDeObjetos[i].getPrioridad() %></td>
						<td class="text-center"><%=listadoDeObjetos[i].getNombre_estado() %></td>
						<td class="text-center"><a class="detalle"
							href="modules/client_reportes/detalles.jsp?id_incidencia=<%=listadoDeObjetos[i].getId_incidencia() %>">Ver</a>
						</td>
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
