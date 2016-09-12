<!-----------  Importaciones -------------------->
<%@page import="model.Incidencia"%>
<%@page import="model.Usuario"%>
<%@page import="model.Estado"%>
<%@page import="controller.Inicio.InicioAdmin"%>
<!------------ Definicion de variables---------->
<%! 
    //Variables generales
	private String mensaje=null;
	private String tipoMensaje=null;
	private Incidencia[] incVencidas=null; 
	private Incidencia[] incPorVencer=null;
	private Incidencia[] incRegistradas=null; 
	private Incidencia[] incActivas=null;
	private Incidencia objetoEditar=null;
	private Usuario userLog=null;
	boolean valida=false;
	
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

userLog=(Usuario)request.getSession().getAttribute("userLog");
int rol= userLog.getRol();
InicioAdmin.preparaPagina(request, response);

//Listado de grupos de incidencias
incVencidas=(Incidencia[])request.getSession().getAttribute("incVencidas");
request.getSession().removeAttribute("incVencidas");
incPorVencer=(Incidencia[])request.getSession().getAttribute("incPorVencer");
request.getSession().removeAttribute("incPorVencer");
incRegistradas=(Incidencia[])request.getSession().getAttribute("incRegistradas");
request.getSession().removeAttribute("incRegistradas");
incActivas=(Incidencia[])request.getSession().getAttribute("incActivas");
request.getSession().removeAttribute("incActivas");
%>
<script src="bower_components/jquery/dist/jquery.min.js"></script>
<script>
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
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-body">
				<div id="myCarousel" class="carousel slide" data-ride="carousel">
					<!-- Indicators -->
					<ol class="carousel-indicators">
						<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
						<li data-target="#myCarousel" data-slide-to="1"></li>
						<li data-target="#myCarousel" data-slide-to="2"></li>
					</ol>

					<!-- Wrapper for slides -->
					<div class="carousel-inner" role="listbox">
						<div class="item active">
							<center>
								<img src="img/emp/emp1.png" alt="Chania" width="460"
									height="345">
							</center>
						</div>

						<div class="item">
							<center>
								<img src="img/emp/emp2.png" alt="Chania" width="460"
									height="345">
							</center>
						</div>

						<div class="item">
							<center>
								<img src="img/emp/emp3.png" alt="Flower" width="460"
									height="345">
							</center>
						</div>
					</div>

					<!-- Left and right controls -->
					<a class="left carousel-control" href="#myCarousel" role="button"
						data-slide="prev"> <span
						class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#myCarousel" role="button"
						data-slide="next"> <span
						class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
			</div>
			<% 
if(rol!=3)
{
%>
			<div class="panel-body">
				<%
   	if(incVencidas==null&&incPorVencer==null&&incRegistradas==null&&incActivas==null)
   	{
   	%>
				<div class="panel-body">
					<h1 align="center">No tienes Incidencias pendientes</h1>
				</div>
				<% 
   	}
   	else//Si hay incidencias Pendientes
   	{
   		if(incVencidas!=null)
   		{
   		%>
				<div class="col-lg-12">
					<div class="panel panel-red">
						<div class="panel-heading" align="center">Incidentes
							Vencidos</div>
						<div class="panel-body" style="overflow-x: scroll">
							<table class="table table-hover table-bordered">
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
									<td class="text-center"><b>Estado Actual</b></td>
									<td class="text-center"><b>Detalles</b></td>
									<td class="text-center"><b>Administrar</b></td>
								</tr>
								<%						
						for(Incidencia inc:incVencidas)
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
					%>
							</table>
						</div>
					</div>
				</div>
				<%	
    }
	%>

				<%
    if(incPorVencer!=null)
    {
    %>
				<div class="col-lg-12">
					<div class="panel panel-danger">
						<div class="panel-heading" align="center">Incidentes Por
							Vencer</div>
						<div class="panel-body" style="overflow-x: scroll">
							<table class="table table-hover table-bordered">
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
									<td class="text-center"><b>Estado Actual</b></td>
									<td class="text-center"><b>Detalles</b></td>
									<td class="text-center"><b>Administrar</b></td>
								</tr>
								<%						
						for(Incidencia inc:incPorVencer)
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
					%>
							</table>
						</div>
					</div>
				</div>
				<%	
 	}
	%>

				<%
 	if(incRegistradas!=null)
 	{
 	%>
				<div class="col-lg-12">
					<div class="panel panel-green">
						<div class="panel-heading" align="center">Incidentes
							Registrados</div>
						<div class="panel-body" style="overflow-x: scroll">
							<table class="table table-hover table-bordered">
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
									<td class="text-center"><b>Estado Actual</b></td>
									<td class="text-center"><b>Detalles</b></td>
									<td class="text-center"><b>Administrar</b></td>
								</tr>
								<%						
						for(Incidencia inc:incRegistradas)
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
					%>
							</table>
						</div>
					</div>
				</div>
				<%	
    }
	%>

				<%
     if(incActivas!=null)
     {
     %>
				<div class="col-lg-12">
					<div class="panel panel-yellow">
						<div class="panel-heading" align="center">Incidentes Activos
						</div>
						<div class="panel-body" style="overflow-x: scroll">
							<table class="table table-hover table-bordered">
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
									<td class="text-center"><b>Estado Actual</b></td>
									<td class="text-center"><b>Detalles</b></td>
									<td class="text-center"><b>Administrar</b></td>
								</tr>
								<%						
						for(Incidencia inc:incActivas)
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
					%>
							</table>
						</div>
					</div>
				</div>
				<%	
      }
    }//Fin datos si hay incidencias Administradores
%>
			</div>
			<!-- Panel Body -->
			<% 
}//Fin Si es perfil administrador
else if(rol==3)
{
    if(incActivas!=null)
    {
    %>
			<div class="panel-body">
				<div class="col-lg-12">
					<div class="panel panel-yellow">
						<div class="panel-heading" align="center">Incidentes Activos
						</div>
						<div class="panel-body" style="overflow-x: scroll">
							<table class="table table-hover table-bordered">
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
									<td class="text-center"><b>Estado Actual</b></td>
									<td class="text-center"><b>Detalles</b></td>
								</tr>
								<%						
						for(Incidencia inc:incActivas)
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
									<td class="text-center"><%=inc.getNombre_estado() %></td>
									<td class="text-center"><a class="detalle"
										href="modules/client_reportes/detalles.jsp?id_incidencia=<%=inc.getId_incidencia() %>">Ver</a>
									</td>
								</tr>
								<%	
						}									
					%>
							</table>
						</div>
					</div>
				</div>
			</div>
			<%	
     }
    else
    {
	%>
			<div class="panel-body">
				<h1 align="center">No tienes Incidencias pendientes</h1>
			</div>
			<% 
    }
}
%>
		</div>
		<!-- default -->
	</div>
</div>
<!-- row -->
