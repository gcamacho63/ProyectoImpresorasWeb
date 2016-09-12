<!-----------  Importaciones -------------------->
<%@page import="model.TiempoAtencion"%>
<%@page import="controller.Incidencias.TiemposAtencion"%>
<!------------ Definicion de variables---------->
<%! 
	//Variables generales
	private String mensaje=null;
	private String tipoMensaje=null;
	private String controlador="TiemposAtencion";
	
	//Variables de preparacion del formulario
	private TiempoAtencion[] tiempo_activo=null;
	private TiempoAtencion tiempo=null;
%>
<!-----------  Asignacion  --------------------->
<%
//Inicializa los valores del formulario
TiemposAtencion.preparaPagina(request, response);

//Prepacion del formulario
HttpSession sesion = request.getSession();
tiempo_activo= (TiempoAtencion[])sesion.getAttribute("tiempo_activo");
if(tiempo_activo!=null)
{
	tiempo= tiempo_activo[0];
}

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
<script src="bower_components/jquery/dist/jquery.min.js"></script>
<script>
	function asignarAccion(action)
	{
		$("#accion").val(action);
	}
	function activa(valor)
	{
		$('#cambiar').slideToggle();
	}
	$(document).ready(function() 
	{
	    generarModal("detalle","1200","700");
	});
</script>
<!--------------------  Formulario de inicio ---------------------->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				Tiempos de atencion
				<span class="tools pull-right"> 
					<a class="detalle" href="modules/client_incidencias/historial_tiempos.jsp">
						<input type="submit" class="btn btn-primary btn-xs" value="HISTORIAL DE TIEMPOS DE ATENCION" name="crear" onclick="asignarAccion('crear');" />
					</a>
				</span>
			</div>
			<div class="panel-body">
				<%
				if(tiempo!=null)
				{
				%>
				<table class="table table-hover table-bordered">
					<tr>
						<td class="text-danger" colspan="5">
							<center><b>Configuracion Actual</b></center>
						</td>
					</tr>
					<tr>
						<td class="text-center">
							<b>Hora inicio de operacion</b>
						</td>
						<td class="text-center">
							<b>Hora fin de operacion</b>
						</td>
						<td class="text-center">
							<b>Tiempo de atencion (Horas)</b>
						</td>
						<td class="text-center">
							<b>Dia de inicio<br>operacion</b>
						</td>
						<td class="text-center">
							<b>Dia de fin<br>operacion</b>
						</td>
					</tr>
					<tr>
						<td class="text-center">						    
							<%=tiempo.getHora_inicio() %>
						</td>
						<td class="text-center">
							<%=tiempo.getHora_fin() %>
						</td>
						<td class="text-center">
							<%=tiempo.getTiempo_atencion() %>
						</td>
						<td class="text-center">
							<%
							String diaInicio="";
						    switch(tiempo.getDia_inicio())
						    {
						    	case 1: diaInicio="Lunes"; break;
						    	case 2: diaInicio="Martes"; break;
						    	case 3: diaInicio="Miercoles"; break;
						    	case 4: diaInicio="Jueves"; break;
						    	case 5: diaInicio="Viernes"; break;
						    	case 6: diaInicio="Sabado"; break;
						    	case 7: diaInicio="Domingo"; break;
						    }
						    %>
							<%=diaInicio %>
						</td>
						<td class="text-center">
							<%
							String diaFin="";
						    switch(tiempo.getDia_fin())
						    {
						    	case 1: diaFin="Lunes"; break;
						    	case 2: diaFin="Martes"; break;
						    	case 3: diaFin="Miercoles"; break;
						    	case 4: diaFin="Jueves"; break;
						    	case 5: diaFin="Viernes"; break;
						    	case 6: diaFin="Sabado"; break;
						    	case 7: diaFin="Domingo"; break;
						    }
						    %>
							<%=diaFin %>
						</td>
					</tr>
				</table>
				<%
				}
				else
				{
				%>
					Sin configuracion
				<%
				}
				%>
				
				<form name="forma" method="post" action="<=controlador %>" class="form-horizontal">				
					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Cambiar</label>
						<div class="col-lg-8">
							<input type="checkbox" onclick="activa(this.checked)" value="Ok"
								id="cambiacont" name="cambiacont">
						</div>
					</div>
				<!--<div id="cambiar" style="display:none">
						<div class="form-group">
							<label class="col-lg-2 col-sm-2 control-label" for="asunto">Nombre</label>
							<div class="col-lg-8">
								<input type="text" required="required" id="nombre" name="nombre"
									value="<=nombre %>" class="form-control">
							</div>
						</div>
	
						<div class="form-group">
							<label class="col-lg-2 col-sm-2 control-label" for="asunto">Descripcion</label>
							<div class="col-lg-8">
								<textarea class="form-control" required="required"
									name="descripcion" id="descripcion"><=descripcion %></textarea>
							</div>
						</div>
	
						<div class="form-group">
							<label class="col-lg-2 col-sm-2 control-label" for="asunto">Grupo
								de Herramientas</label>
							<div class="col-lg-8">
								<select name="grupo" id="grupo" class="form-control"
									required="required">
									<option value="">Seleccione</option>
									
								</select>
							</div>
						</div>
	
						<div class="form-group">
							<label class="col-lg-2 col-sm-2 control-label" for="asunto">Archivo</label>
							<div class="col-lg-8">
								<input type="text" required="required" id="archivo" name="archivo" value="<=archivo%>" class="form-control">
							</div>
						</div>
	
						<div class="form-group">
							<label class="col-lg-2 col-sm-2 control-label" for="asunto">Controlador</label>
							<div class="col-lg-8">
								<input type="text" required="required" id="controlador" name="controlador" value="<=servlet %>" class="form-control">
							</div>
						</div>
	
						<div class="text-center">
							<input type="submit" class="btn btn-success" value="Guardar" name="crear" onclick="asignarAccion('crear');" />
						</div>
					</div>
					<input type="hidden" id="accion" name="accion" /> 
					<input type="hidden" name="id_elemento" id="id_elemento" value="<=idElemento %>">
					Aqui se almacena el ID del elemento que se este modificando-->
				</form>
			</div>
			<!-- Panel Body -->
		</div>
	</div>
</div>