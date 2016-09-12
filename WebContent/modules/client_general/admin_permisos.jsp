<script>
function asignarAccion(action)
{
	$("#accion").val(action);
}
</script>
<%@page import="model.Rol"%>
<%@page import="model.ModulosGrupos"%>
<%@page import="model.General.PermisosModulos"%>
<%@page import="controller.General.Permisos "%>
<%!
private Rol[] roles=null;
private ModulosGrupos[] grupos=null;
private PermisosModulos[] perMod=null;
private String rolActual;
private String  grupoActual;
private int rolInt;
private int grupoInt;
private String alerta;
%>
<%
Permisos.preparaPagina(request, response);
roles= (Rol[])request.getSession().getAttribute("roles");
grupos =(ModulosGrupos[]) request.getSession().getAttribute("ModulosGrupos");
perMod =(PermisosModulos[]) request.getSession().getAttribute("perMod");
rolActual=request.getParameter("rol");
grupoActual = request.getParameter("gruoup");
alerta = (String)request.getSession().getAttribute("alerta");
request.getSession().removeAttribute("alerta");
if(rolActual!=null)
{
	rolInt = Integer.parseInt(rolActual);
}
if(grupoActual!=null)
{
	grupoInt = Integer.parseInt(grupoActual);
}
%>
<%
if(alerta!=null)
{
%>
<div class="alert alert-<%=alerta%>" id="divAlert">
	Cambios guardados correctamente. <span class="tools pull-right">
		<a href="#"
		onclick="document.getElementById('divAlert').style.display='none';"><i
			class="fa fa-times"></i></a>
	</span>

</div>
<%
}
%>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Permisos</div>
			<div class="panel-body">
				<form name="forma" method="post" action="Permisos"
					class="form-horizontal">

					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Rol</label>
						<div class="col-lg-8">
							<select name="rol" id="rol" class="form-control"
								required="required">
								<option value="">Seleccione</option>
								<%		                
							for(int i=0;i<roles.length;i++)
							{
								String select="";
								if(rolActual!=null)
								{
									if(rolInt==roles[i].getIdRol())
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
			                %>
							</select>
						</div>
					</div>

					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Grupo
							de <br>Herramientas
						</label>
						<div class="col-lg-8">
							<select name="grupo" id="grupo" class="form-control"
								required="required">
								<option value="">Seleccione</option>
								<%		                
							for(int i=0;i<grupos.length;i++)
							{
								String select="";
								if(grupoActual!=null)
								{
									if(grupoInt==grupos[i].getId_grupo())
									{
										select="selected";
									}
									else
									{
										select="";
									}
								}
							%>
								<option value="<%=grupos[i].getId_grupo() %>" <%=select%>><%=grupos[i].getNombre() %></option>
								<%
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
			     if(perMod!=null)
			     {
			     %>
					<div id="MostrarPermisos" class="center-block"
						style="width: 50% !important; text-align: center">
						<table class="table table-hover general-table">
							<tr>
								<td class="text-center"><b>Modulo</b></td>
								<td class="text-center"><b>Permiso</b></td>
							</tr>
							<%
		               for(int i=0;i<perMod.length;i++)
		               {
		            	%>
							<tr>
								<td class="text-center"><%=perMod[i].getNombreModulo() %></td>
								<% String check; if(perMod[i].isPermiso()){ check="checked"; } else { check=""; } %>
								<td class="text-center"><input type="checkbox"
									value="<%=perMod[i].getIdModulo() %>" name="permisos[]"
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
