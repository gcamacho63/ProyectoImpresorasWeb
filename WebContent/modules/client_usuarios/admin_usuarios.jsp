<!-----------  Importaciones -------------------->
<%@page import="model.Usuario"%>
<%@page import="model.Area"%>
<%@page import="model.Rol"%>
<%@page import="model.Ciudad"%>
<%@page import="controller.Usuarios.UsuariosServlet"%>
<!------------ Definicion de variables---------->
<%! 
	//Variables generales
	private String mensaje=null;
	private String tipoMensaje=null;
	private Usuario[] listadoDeObjetos=null; 
	private Usuario[] editarArray=null;
	private Usuario objetoEditar=null;
	private String controlador="UsuariosServlet";
	private int idElemento=0;
	
	//Variables de preparacion del formulario
	private Area[] areas=null;
	private Ciudad[] ciudades=null; 
	private Rol[] roles=null;
	
	//Campos del Formulario
	private String usuario="";
	private int rolActual=0;
	private String rol="";
	private String nombre1="";
	private String nombre2="";
	private String ape1="";
	private String ape2="";
	private String cargo="";
	private int areaActual=0;
	private String area="";
	private int ciuActual=0;
	private String ciudad="";
	private String correo="";
	private String ext="";
	private String imagen="";
	//
	private String titulo="";
%>
<!-----------  Asignacion  --------------------->
<%
//Inicializa los valores del formulario
UsuariosServlet.preparaPagina(request, response);

//Prepacion del formulario
HttpSession sesion = request.getSession();
ciudades= (Ciudad[])sesion.getAttribute("ciudades");
areas= (Area[])sesion.getAttribute("areas");
roles=(Rol[])sesion.getAttribute("roles");

//Inicializa el objeto a editar
editarArray=(Usuario[])request.getSession().getAttribute("editarArray");
request.getSession().removeAttribute("editarArray");
if(editarArray!=null)
{
	objetoEditar= editarArray[0];
	
	idElemento=objetoEditar.getId_usuario();
	usuario=objetoEditar.getUsuario();
	rolActual=objetoEditar.getRol();
	rol=objetoEditar.getNombreRol();
	nombre1=objetoEditar.getNombre1() ;
	nombre2=objetoEditar.getNombre2() ;
	ape1=objetoEditar.getApellido1() ;
	ape2=objetoEditar.getApellido2() ;
	cargo=objetoEditar.getCargo() ;
	areaActual=objetoEditar.getArea() ;
	area=objetoEditar.getNombre_area() ;
	ciuActual=objetoEditar.getCiudad() ;
	ciudad=objetoEditar.getNombre_ciudad() ;
	correo=objetoEditar.getCorreo() ;
	ext=objetoEditar.getExtension() ;
	imagen=objetoEditar.getFoto() ;
	titulo="Editar Usuario";
}
else
{
	usuario="";
	nombre1="";
	nombre2="";
	ape1="";
	ape2="";
	cargo="";
	areaActual=0;
	area="";
	ciuActual=0;
	ciudad="";
	correo="";
	ext="";
	imagen="";
	titulo="Crear Usuario";
}

//Listado de elementos existentes
listadoDeObjetos=(Usuario[])request.getSession().getAttribute("listadoDeObjetos");
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
	function validarEmail() 
	{
	    var email=$('#correo').val();
		expr = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	    if ( !expr.test(email) )
	    {
	    	alert("Direccion de correo invalida");
	    	return false;
	    }  
	    var contra=$('#contra').val();
	    var contra1=$('#contra1').val();
	    if(contra!=contra1)
	    {
	    	alert("Las contraseñas no coinciden");
	    	return false;
	    }
	}
	function activa(valor)
	{
		$('#contra-div').slideToggle() 
		if(valor)
		{
			$('#contra').attr('required','required');
			$('#contra1').attr('required','required');
		}
		else
		{
			$('#contra').removeAttr('required');
			$('#contra1').removeAttr('required');
			$('#contra').val("");
			$('#contra1').val("");
		}
			
	}
</script>
<!--------------------  Formulario de inicio ---------------------->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading" align="center">
				<h4>
					<strong><%=titulo%></strong>
				</h4>
			</div>

			<div class="panel-body">
				<form name="forma" method="post" action="<%=controlador %>"
					class="form-horizontal">

					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Usuario</label>
						<div class="col-lg-8">
							<input type="text" required="required" id="usuario"
								name="usuario" value="<%=usuario %>" class="form-control">
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Rol</label>
						<div class="col-lg-8">
							<select name="rol" id="rol" class="form-control"
								required="required">
								<option value="">Seleccione</option>
								<%		
			                if(roles!=null)
			                {
			                	for(int i=0;i<roles.length;i++)
								{
									String select="";
									if(objetoEditar!=null)
									{
										if(rolActual==roles[i].getIdRol())
										{
											select="selected";
										}
										else
										{
											select="";
										}
									}
								%>
								<option value="<%=roles[i].getIdRol() %>" <%=select%>><%=roles[i].getNombre() %></option>
								<%
								}				                	
			                }
			                %>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Primer
							Nombre</label>
						<div class="col-lg-8">
							<input type="text" required="required" id="nombre1"
								name="nombre1" value="<%=nombre1 %>" class="form-control">
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Segundo
							Nombre</label>
						<div class="col-lg-8">
							<input type="text" id="nombre2" name="nombre2"
								value="<%=nombre2 %>" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Primer
							Apellido</label>
						<div class="col-lg-8">
							<input type="text" required="required" id="ape1" name="ape1"
								value="<%=ape1 %>" class="form-control">
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Segundo
							Apellido</label>
						<div class="col-lg-8">
							<input type="text" id="ape2" name="ape2" value="<%=ape2 %>"
								class="form-control">
						</div>
					</div>

					<% 
		     	  if(editarArray==null)
		     	  {
		     	  %>
					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Contraseña
						</label>
						<div class="col-lg-8">
							<input type="password" required="required" id="contra"
								name="contra" value="" class="form-control">
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Confirme
							Contraseña</label>
						<div class="col-lg-8">
							<input type="password" required="required" id="contra1"
								name="contra1" value="" class="form-control">
						</div>
					</div>
					<%
		     	  }
		     	  else
		     	  {
		     	  %>
					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Cambiar
							contraseña </label>
						<div class="col-lg-8">
							<input type="checkbox" onclick="activa(this.checked)" value="Ok"
								id="cambiacont" name="cambiacont">
						</div>
					</div>

					<div id="contra-div" style="display: none">
						<div class="form-group">
							<label class="col-lg-2 col-sm-2 control-label" for="asunto">Contraseña
							</label>
							<div class="col-lg-8">
								<input type="password" id="contra" name="contra" value=""
									class="form-control">
							</div>
						</div>

						<div class="form-group">
							<label class="col-lg-2 col-sm-2 control-label" for="asunto">Confirme
								Contraseña</label>
							<div class="col-lg-8">
								<input type="password" id="contra1" name="contra1" value=""
									class="form-control">
							</div>
						</div>
					</div>
					<%  
		     	  }
		     	  %>


					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Cargo</label>
						<div class="col-lg-8">
							<input type="text" required="required" id="cargo" name="cargo"
								value="<%=cargo %>" class="form-control">
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
										if(areaActual==areas[i].getIdArea())
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
										if(ciuActual==ciudades[i].getId_ciudad())
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

					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Correo
							electronico</label>
						<div class="col-lg-8">
							<input type="mail" required="required" id="correo" name="correo"
								value="<%=correo %>" class="form-control">
						</div>
					</div>


					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Extension</label>
						<div class="col-lg-8">
							<input type="text" required="required" id="ext"
								onkeypress="return solonumeros(event);" name="ext"
								value="<%=ext %>" class="form-control">
						</div>
					</div>

					<!--  <div class="form-group">
			      <label class="col-lg-2 col-sm-2 control-label" for="asunto">Cargar imagen Perfil</label>
			      <div class="col-lg-8">
			       <input type="file" id="imagen" accept="image/gif, image/jpeg, image/png" name="imagen"   value="">
			      </div>
			     </div>-->

					<div class="text-center">
						<% 
			     	  if(editarArray==null)
			     	  {
			     	  %>
						<input type="submit" class="btn btn-success" value="Crear"
							name="crear"
							onclick="asignarAccion('crear');return validarEmail(); " />
						<%
			     	  }
			     	  else
			     	  {
			     	  %>
						<input type="submit" class="btn btn-primary" value="Editar"
							name="actualizar"
							onclick="asignarAccion('actualizar');return validarEmail();" />
						<%  
			     	  }
			     	  %>
					</div>

					<input type="hidden" name="accion" id="accion" /> <input
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
			<div class="panel-heading">
				<h3>
					<center>Administrar usuarios</center>
				</h3>
			</div>
			<div class="panel-body">

				<div>
					<table border="0" cellpadding="0" cellspacing="0"
						class="table table-hover table-bordered">
						<tr>
							<td class="text-center"><b>Usuario</b></td>
							<td class="text-center"><b>Rol</b></td>
							<td class="text-center"><b>Nombres</b></td>
							<td class="text-center"><b>Apellidos</b></td>
							<td class="text-center"><b>Area</b></td>
							<td class="text-center"><b>Correo</b></td>
							<td class="text-center"><b>Extension</b></td>
							<td class="text-center"><b>Estado</b></td>
							<td class="text-center"><b>Acciones</b></td>
						</tr>
						<%
		           if(listadoDeObjetos!=null)
		           {
		        	 for(int i=0;i < listadoDeObjetos.length ;i++ )
		        	 {
		        		 int idElemento1=listadoDeObjetos[i].getId_usuario();	        		 
		        	%>
						<tr>
							<td class="text-center"><%=listadoDeObjetos[i].getUsuario() %></td>
							<td class="text-center"><%=listadoDeObjetos[i].getNombreRol() %></td>
							<td class="text-center"><%=listadoDeObjetos[i].getNombre1()+" "+listadoDeObjetos[i].getNombre2() %></td>
							<td class="text-center"><%=listadoDeObjetos[i].getApellido1()+" "+listadoDeObjetos[i].getApellido2() %></td>
							<td class="text-center"><%=listadoDeObjetos[i].getNombre_area() %></td>
							<td class="text-center"><%=listadoDeObjetos[i].getCorreo() %></td>
							<td class="text-center"><%=listadoDeObjetos[i].getExtension() %></td>
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