<!-----------  Importaciones -------------------->
<%@page import="model.Impresora"%>
<%@page import="model.Area"%>
<%@page import="model.ModeloImpresora"%>
<%@page import="model.Impresora"%>
<%@page import="model.Ciudad"%>
<%@page import="controller.Impresoras.ImpresorasServlet"%>
<!------------ Definicion de variables---------->
<%! 
    //Variables generales
	private String mensaje=null;
	private String tipoMensaje=null;
	private Impresora[] listadoDeObjetos=null; 
	private Impresora[] editarArray=null;
	private Impresora objetoEditar=null;
	private String controlador="ImpresorasServlet";
	
	//Variables de preparacion del formulario
	private Ciudad[] ciudades=null;
	private ModeloImpresora[] modelosImpresoras=null;
	private Area[] areas=null;
	
	//Campos del Formulario
    private String serial="";
    private int area;
	private int modelo;
    private int ciudad;
    private int idElemento=0;

	//Titulo
	private String titulo="";
%>

<!-----------  Asignacion  --------------------->
<%
//Inicializa los valores del formulario
ImpresorasServlet.preparaPagina(request, response);

//Prepacion del formulario
HttpSession sesion = request.getSession();
ciudades= (Ciudad[])sesion.getAttribute("ciudades");
modelosImpresoras= (ModeloImpresora[])sesion.getAttribute("modelosImpresora");
areas= (Area[])sesion.getAttribute("areas");

//Inicializa el objeto a editar
editarArray=(Impresora[])request.getSession().getAttribute("editarArray");
request.getSession().removeAttribute("editarArray");
if(editarArray!=null)
{
	objetoEditar= editarArray[0];
	
	serial=objetoEditar.getSerial();
	area=objetoEditar.getArea();
	modelo=objetoEditar.getModelo();
	ciudad=objetoEditar.getCiudad();
	idElemento=objetoEditar.getId_impresora();
	//grupoActual=objetoEditar.getGrupo();
	titulo="Editar Impresora";
}
else
{
	serial="";
	area=0;
	modelo=0;
	ciudad=0;
	idElemento=0;
	titulo="Crear Impresora";
}

//Listado de elementos existentes
listadoDeObjetos=(Impresora[])request.getSession().getAttribute("listadoDeObjetos");
request.getSession().removeAttribute("listadoDeObjetos");

//Muestra alerta de retorno del Servlet
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
				<center>
					<h3>Creación de impresoras</h3>
				</center>
			</div>
			<div class="panel-body">
				<form name="forma" method="post" action="<%=controlador %>"
					class="form-horizontal">
					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Serial</label>
						<div class="col-lg-8">
							<input type="text" required="required" id="nombre_modelo"
								name="serial" value="<%=serial%>" class="form-control">
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Area</label>
						<div class="col-lg-8">
							<select name="area" id="area" class="form-control"
								required="required">
								<option value="">Seleccione</option>
								<%		
		                if(areas!=null)
		                {
		                	for(int i=0;i<areas.length;i++)
							{
								String select="";
								if(objetoEditar!=null)
								{
									if(area==areas[i].getIdArea())
									{
										select="selected";
									}
									else
									{
										select="";
									}
								}
							%>
								<option value="<%=areas[i].getIdArea() %>" <%=select%>><%=areas[i].getNombreArea() %></option>
								<%
							}				                	
		                }
		                %>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Modelo</label>
						<div class="col-lg-8">
							<select name="modelo" id="modelo" class="form-control"
								required="required">
								<option value="">Seleccione</option>
								<%		
		                if(modelosImpresoras!=null)
		                {
		                	for(int i=0;i<modelosImpresoras.length;i++)
							{
								String select="";
								if(objetoEditar!=null)
								{
									if(modelo==modelosImpresoras[i].getId_modelo())
									{
										select="selected";
									}
									else
									{
										select="";
									}
								}
							%>
								<option value="<%=modelosImpresoras[i].getId_modelo() %>"
									<%=select%>><%=modelosImpresoras[i].getNombre() %></option>
								<%
							}				                	
		                }
		                %>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Ciudad</label>
						<div class="col-lg-8">
							<select name="ciudad" id="ciudad" class="form-control"
								required="required">
								<option value="">Seleccione</option>
								<%		
		                if(ciudades!=null)
		                {
		                	for(int i=0;i<ciudades.length;i++)
							{
								String select="";
								if(objetoEditar!=null)
								{
									if(ciudad==ciudades[i].getId_ciudad())
									{
										select="selected";
									}
									else
									{
										select="";
									}
								}
							%>
								<option value="<%=ciudades[i].getId_ciudad() %>" <%=select%>><%=ciudades[i].getNombre_ciudad() %></option>
								<%
							}				                	
		                }
		                %>
							</select>
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
			<!-- Panel body -->
		</div>
	</div>
</div>
<!------------------- LISTADO ----------------->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<center>
					<h3>Administración de impresoras</h3>
				</center>
			</div>
			<div class="panel-body">
				<div>
					<table class="table table-hover table-bordered">
						<tr>
							<td class="text-center"><b>Serial</b></td>
							<td class="text-center"><b>Area</b></td>
							<td class="text-center"><b>Modelo</b></td>
							<td class="text-center"><b>Ciudad</b></td>
							<td class="text-center"><b>Estado</b></td>
							<td class="text-center"><b>Acciones</b></td>
						</tr>
						<%
		           if(listadoDeObjetos!=null)
		           {
		        	 for(int i=0;i < listadoDeObjetos.length ;i++ )
		        	 {
		        		 int idElemento1=listadoDeObjetos[i].getId_impresora();	        		 
		        	%>
						<tr>
							<td class="text-center"><%=listadoDeObjetos[i].getSerial() %></td>
							<td class="text-center"><%=listadoDeObjetos[i].getNombre_area() %></td>
							<td class="text-center"><%=listadoDeObjetos[i].getNombre_modelo() %></td>
							<td class="text-center"><%=listadoDeObjetos[i].getNombre_ciudad() %></td>

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
