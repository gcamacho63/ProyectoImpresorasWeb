<!-----------  Importaciones -------------------->
<%@page import="model.Incidencia"%>
<%@page import="model.Estado"%>
<%@page import="controller.Incidencias.AdministrarIncidencias"%>
<!------------ Definicion de variables---------->
<%! 
    //Variables generales
	private String mensaje=null;
	private String tipoMensaje=null;
	private Incidencia[] listadoDeObjetos=null; 
	private Incidencia[] editarArray=null;
	private Incidencia objetoEditar=null;
	
	//Variables locales
	String condicion;
	String id;
	private Estado[] estados;
	
	//Servlet
	String controlador="AdministrarIncidencias";

%>
<!-----------  Asignacion  --------------------->
<%
HttpSession sesion = request.getSession();
//Elementos de preparacion del Formulario
condicion= request.getParameter("condicion");
id=request.getParameter("caso");
estados=(Estado[])request.getSession().getAttribute("estados");
if(condicion==null)
{
	condicion="2";
}
String est=request.getParameter("estado");
AdministrarIncidencias.preparaPagina(request, response,condicion,id,est);
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
function asignarCondicion(condicion)
{
	if(condicion=="1")
	{
		$("#caso").attr('required','required');
		$("#estado").removeAttr('required');
	}
	else if(condicion=="5")
	{
		$("#estado").attr('required','required');
		$("#caso").removeAttr('required');
	}
	else
	{
		$("#caso").removeAttr('required');
		$("#estado").removeAttr('required');
	}
	$("#condicion").val(condicion);
}
$(document).ready(function() 
{
	//Actualiza la pagina despues de cerrar el Modal
	$(".editar").colorbox({ 
		overlayClose:false, iframe:true, innerWidth:650, innerHeight:300, scrolling:true,
		onClosed:function(){ location.reload(true); }
		});
	generarModal("editar","1000","600");
	generarModal("detalle","1000","600");
    
});
</script>
<!--------------------  Formulario de inicio ---------------------->
<div class="row">
	<div class="col-lg-15">
		<div class="panel panel-default">
			<div class="panel-heading">
				<strong><center>ADMINISTRAR INCIDENCIAS</center></strong>
			</div>
			<div class="panel-body">
				<form name="forma" method="post" action="" class="form-horizontal">
					<br>
					<div class="col-lg-3">
						<div class="form-group input-group">
							<input type="text" class="form-control" name="caso"
								onkeypress="return solonumeros(event);" id="caso"
								placeholder="No.de Caso"> <span class="input-group-btn">
								<button class="btn btn-default" type="submit"
									onclick="asignarCondicion('1')">
									<i class="fa fa-search"></i>
								</button>
							</span>
						</div>
					</div>

					<div class="col-lg-3">
						<div class="form-group input-group" style="margin-left: 5px">
							<select name="estado" id="estado" class="form-control"
								required="required">
								<option value="">Filtrar por estado</option>
								<%		
			                if(estados!=null)
			                {
			                	for(int i=0;i<estados.length;i++)
								{
								%>
								<option value="<%=estados[i].getId_estado() %>"><%=estados[i].getNombre() %></option>
								<%
								}				                	
			                }
			                %>
							</select> <span class="input-group-btn">
								<button class="btn btn-default" type="submit"
									onclick="asignarCondicion('5')">
									<i class="fa fa-search"></i>
								</button>
							</span>
						</div>
					</div>

					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input
						type="submit" name="registradas" id="registradas"
						value="Ver registradas" onclick="asignarCondicion('2')"
						class="btn btn-success btn-xs" /> &nbsp;&nbsp;&nbsp;&nbsp;<input
						type="submit" name="activas" id="activas" value="Ver Activas"
						onclick="asignarCondicion('3')" class="btn btn-primary btn-xs" />
					&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="todas"
						id="todas" value="Ver Todas" onclick="asignarCondicion('4')"
						class="btn btn-info btn-xs" /> <br>
					<br>
					<br>
					<div>
						<table class="table table-hover table-bordered">
							<tr>
								<td colspan="12" class="text-danger">
									<% 
							String title="Incidencias Registradas";
							if(condicion!=null)
							{
								if(condicion.equals("1"))
								{
									if(listadoDeObjetos!=null)
									{
										title="Incidencia No."+listadoDeObjetos[0].getId_incidencia() ;
									}	
									else
									{
										title="No hay resultados";
									}
								}
								else if(condicion.equals("2"))
								{
									title="Incidencias Registradas";
								}
								else if(condicion.equals("3"))
								{
									title="Incidencias Activas";
								}
								else if(condicion.equals("4"))
								{
									title="Incidencias";
								}
								else if(condicion.equals("5"))
								{
									if(listadoDeObjetos!=null)
									{
										title="Incidencias en estado "+listadoDeObjetos[0].getNombre_estado();	
									}
									else
									{
										title="No hay resultados";
									}
									
								}
							}
							%> <b><center><%=title %></center> </b>
								</td>
							</tr>
							<% 
						if(listadoDeObjetos!=null)
						{
						%>
							<tr>
								<td class="text-center"><b>No Caso</b></td>
								<td class="text-center"><b>Impresora</b></td>
								<td class="text-center"><b>Solicitante</b></td>
								<td class="text-center"><b>Encargado</b></td>
								<td class="text-center"><b>Fecha De Incio</b></td>
								<td class="text-center"><b>Fecha Maxima<br> De
										Revision
								</b></td>
								<td class="text-center"><b>Area</b></td>
								<td class="text-center"><b>Prioridad</b></td>
								<!--  <td class="text-center"><b>Descripcion</b></td>-->
								<td class="text-center"><b>Estado Actual</b></td>
								<td class="text-center"><b>Detalles</b></td>
								<td class="text-center"><b>Administrar</b></td>
							</tr>
							<%						
							for(Incidencia inc:listadoDeObjetos)
							{
							%>
							<tr>
								<td class="text-center"><%=inc.getId_incidencia() %></td>
								<td class="text-center"><%=inc.getSerial_imp() %></td>
								<td class="text-center"><%=inc.getNombre_solicitante() %></td>
								<td class="text-center"><%=inc.getNombre_encargado() %></td>
								<td class="text-center"><%=inc.getFecha_guardado() %></td>
								<td class="text-center"><%=inc.getFecha_maxima() %></td>
								<td class="text-center"><%=inc.getNombre_area() %></td>
								<td class="text-center"><%=inc.getPrioridad() %></td>
								<!-- <td class="text-center"><%=inc.getDescripcion() %></td>-->
								<td class="text-center"><%=inc.getNombre_estado() %></td>
								<td class="text-center"><a class="detalle"
									href="modules/client_reportes/detalles.jsp?id_incidencia=<%=inc.getId_incidencia() %>">Ver</a>
								</td>
								<td class="text-center"><a class="editar"
									href="modules/client_incidencias/editar_incidencia.jsp?id_incidencia=<%=inc.getId_incidencia() %>">Editar</a>
								</td>
							</tr>
							<%	
							}
						}
						%>
						</table>
					</div>
					<input type="hidden" name="condicion" id="condicion" />
				</form>
			</div>
			<!-- Panel body -->
		</div>
	</div>
</div>
