<!-----------  Importaciones -------------------->
<%@page import="model.Usuario"%>
<%@page import="model.Impresora"%>
<%@page import="controller.Usuarios.AsignarImpresoras"%>
<!------------ Definicion de variables---------->
<%! 
	//Variables generales
	private String mensaje=null;
	private String tipoMensaje=null;
	private String controlador="AsignarImpresoras";
	
	//Variables de preparacion del formulario
	private Usuario[] usuarios=null;
	private Usuario user=null;
	private Impresora[] impresoras=null;
	private Impresora[] impActivas=null;
 	
	private String titulo="Asignar impresoras";
%>
<!-----------  Asignacion  --------------------->
<%
//Inicializa los valores del formulario
AsignarImpresoras.preparaPagina(request, response);
//Prepacion del formulario
HttpSession sesion = request.getSession();
usuarios= (Usuario[])sesion.getAttribute("usuarios");

//User actual he impresoras
user=(Usuario)request.getSession().getAttribute("user");
request.getSession().removeAttribute("user");
impresoras=(Impresora[])request.getSession().getAttribute("impresoras");
request.getSession().removeAttribute("impresoras");
impActivas=(Impresora[])request.getSession().getAttribute("impActivas");
request.getSession().removeAttribute("impActivas");

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
			<div class="panel-heading">Permisos</div>
			<div class="panel-body">
				<form name="forma" method="post" action="<%=controlador %>"
					class="form-horizontal">

					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Usuario</label>
						<div class="col-lg-8">
							<select name="user" id="user" class="form-control"
								required="required">
								<option value="">Seleccione</option>
								<%
			                if(usuarios!=null)
			                {
			                	for(int i=0;i<usuarios.length;i++)
								{
									String select="";
									if(user!=null)
									{
										if(user.getId_usuario()==usuarios[i].getId_usuario())
										{
											select="selected";
										}
										else
										{
											select="";
										}
									}
									
								%>
								<option value="<%=usuarios[i].getId_usuario() %>" <%=select%>><%=usuarios[i].getNombre1()+" "+usuarios[i].getApellido1() %></option>
								<%
								}
			                }						
			                %>
							</select>
						</div>
					</div>

					<div class="text-center">
						<input type="submit" class="btn btn-success btn-xs" value="Buscar"
							onclick="asignarAccion('buscar');" />
					</div>
					<br>

					<%
			     if(impresoras!=null)
			     {
			     %>
					<div id="MostrarPermisos" class="center-block"
						style="width: 50% !important; text-align: center">
						<table class="table table-hover general-table">
							<tr>
								<td class="text-center"><b>Area</b></td>
								<td class="text-center"><b>Serial</b></td>
								<td class="text-center"><b>Permiso</b></td>
							</tr>
							<%
		               for(int i=0;i<impresoras.length;i++)
		               {
		            	%>
							<tr>
								<td class="text-center"><%=impresoras[i].getNombre_area() %></td>
								<td class="text-center"><%=impresoras[i].getSerial() %></td>
								<% 
		            		String check="";
		            		if(impActivas!=null)
		            		{	            			
		            			for(Impresora impTemp:impActivas)
		            			{
		            				if(impTemp.getId_impresora()==impresoras[i].getId_impresora())
				            		{ 
				            			check="checked"; 
				            		} 
		            			}	            			
		            		}		            		
		            		%>
								<td class="text-center"><input type="checkbox"
									value="<%=impresoras[i].getId_impresora() %>" name="permisos[]"
									<%=check %>></td>
							</tr>
							<%
		               }
		               %>
						</table>
						<div class="text-center">
							<input type="submit" class="btn btn-primary btn-sm"
								value="Guardar Cambios" onclick="asignarAccion('guardar');" />
						</div>
					</div>
					<%
			     }
			     request.getSession().removeAttribute("perMod");
			     %>
					<input type="hidden" name="accion" id="accion" value="buscar" />
					<!-- Le dice al Servlet que va a hacer -->
				</form>
			</div>
			<!-- Panel Body -->
		</div>
	</div>
</div>
