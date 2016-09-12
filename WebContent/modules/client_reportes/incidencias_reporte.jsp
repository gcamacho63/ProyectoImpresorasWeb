<!-----------  Importaciones -------------------->
<%@page import="model.Tipificacion"%>
<%@page import="model.Incidencia"%>
<%@page import="controller.Reportes.IncidenciasReportes"%>
<%@page import="java.util.ArrayList"%>
<!------------ Definicion de variables---------->
<%! 	
	//Servlet
	String controlador="IncidenciasReportes";
		
	private Tipificacion [] listadoTip;
	private Incidencia[] listIncidencias;
	private String filtro;
	private Object[][] anios;
	String anioAct;
%>
<!-----------  Asignacion  --------------------->
<%
//Inicializa datos del formulario
IncidenciasReportes.preparaPagina(request, response);
anioAct=request.getParameter("anio");

//Locales
listadoTip=(Tipificacion [])request.getSession().getAttribute("listadoDeTipificaciones");
request.getSession().removeAttribute("listadoDeTipificaciones");
listIncidencias=(Incidencia[])request.getSession().getAttribute("listIncidencias");
anios=(Object[][])request.getSession().getAttribute("anios");
//request.getSession().removeAttribute("listIncidencias");
filtro=request.getParameter("filtro");
//---------
%>
<!-- Scripts -->
<script src="bower_components/jquery/dist/jquery.min.js"></script>
<script>
$(document).ready(function() 
{
	campoFecha("fechaini");
    campoFecha("fechafin");
    generarModal("detalle","1000","600");
});
function asignarAccion(action)
{
	$("#accion").val(action);
}
function cambiaForm(valor)
{
	if(valor==1)
	{
		$("#formTipificacion").css('display','block');
		$("#formFechas").css('display','block');
		$("#formAnual").css('display','none');
		$("#tipificacion").attr('required','required');
		$("#fechaini").attr('required','required');
		$("#fechafin").attr('required','required');
		$("#anio").removeAttr('required');
	}
	else if(valor==2)
	{
		$("#formTipificacion").css('display','none');
		$("#formFechas").css('display','block');
		$("#formAnual").css('display','none');
		$("#fechaini").attr('required','required');
		$("#fechafin").attr('required','required');
		$("#tipificacion").removeAttr('required');
		$("#anio").removeAttr('required');
	}
	else if(valor==3)
	{
		$("#formTipificacion").css('display','none');
		$("#formFechas").css('display','none');
		$("#formAnual").css('display','block');
		$("#tipificacion").removeAttr('required');
		$("#fechaini").removeAttr('required');
		$("#fechafin").removeAttr('required');
		$("#anio").attr('required','required');
	}
}
</script>
<!--------------------  Formulario de inicio ---------------------->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">Reporte de incidencias</div>
			<div class="panel-body">
				<form name="forma" method="post" action="<%=controlador %>"
					class="form-horizontal">
					<div class="form-group">
						<label class="col-lg-2 col-sm-2 control-label" for="asunto">Filtro</label>
						<div class="col-lg-8">
							<select name="tipo" id="tipo" class="form-control"
								required="required" onchange="cambiaForm(this.value)">
								<option value="">Seleccione</option>
								<option value="1"
									<%if(request.getParameter("filtro")!=null&&request.getParameter("filtro").equals("1")){%>
									selected="selected" <%}%>>Tipificacion</option>
								<option value="2"
									<%if(request.getParameter("filtro")!=null&&request.getParameter("filtro").equals("2")){%>
									selected="selected" <%}%>>Fechas</option>
								<option value="3"
									<%if(request.getParameter("filtro")!=null&&request.getParameter("filtro").equals("3")){%>
									selected="selected" <%}%>>Reporte Anual</option>
							</select>
						</div>
					</div>
					<br>
					<%
				      String dispTip="none";
				      if(request.getParameter("tip")!=null)
				      {
				    	  dispTip="block";
				      }
				      %>
					<div id="formTipificacion"
						style="display:<%=dispTip %>;text-align:center"
						class="center-block">
						<div class="form-group">
							<label class="col-lg-2 col-sm-2 control-label" for="asunto">Tipificaciones</label>
							<div class="col-lg-8">
								<select name="tipificacion" id="tipificacion"
									class="form-control">
									<option value="">Seleccione</option>
									<%		
					                if(listadoTip!=null)
					                {
					                	for(int i=0;i<listadoTip.length;i++)
										{
											String select="";
											if(request.getParameter("tip")!=null)
											{
												int tipAct=Integer.parseInt(request.getParameter("tip"));
												if(tipAct==listadoTip[i].getId_tipificacion())
												{
													select="selected";
												}
												else
												{
													select="";
												}
											}
										%>
									<option value="<%=listadoTip[i].getId_tipificacion() %>"
										<%=select%>><%=listadoTip[i].getNombre() %></option>
									<%
										}				                	
					                }
					                %>
								</select>
							</div>
						</div>
					</div>
					<!-- Div form tip -->
					<% 
					  String valf1="";
					  String valf2="";
					  String dispFech="none";
					  if(request.getParameter("f1")!=null&&request.getParameter("f2")!=null)
					  {
						  valf1=request.getParameter("f1");
						  valf2=request.getParameter("f2");
						  dispFech="block";
					  }
					  %>
					<div id="formFechas"
						style="display:<%=dispFech %>;text-align:center"
						class="center-block">
						<div class="form-group">
							<label class="col-lg-2 col-sm-2 control-label" for="asunto">Desde</label>
							<div class="col-lg-3">
								<input type="text" id="fechaini" name="fechaini"
									class="form-control" value="<%=valf1 %>"></input>
							</div>
							<label class="col-lg-2 col-sm-2 control-label" for="asunto">Hasta</label>
							<div class="col-lg-3">
								<input type="text" id="fechafin" name="fechafin"
									class="form-control" value="<%=valf2 %>"></input>
							</div>
						</div>
						<br>
					</div>
					<!-- Div form fechas -->
					<%
				      String dispAnio="none";
				      if(request.getParameter("anio")!=null)
				      {
				    	  dispAnio="block";
				      }
				      %>
					<div id="formAnual" style="display:<%=dispAnio %>;text-align:center">
						<div class="form-group">
							<label class="col-lg-2 col-sm-2 control-label" for="asunto">Año</label>
							<div class="col-lg-8">
								<select name="anio" id="anio" class="form-control">
									<option value="">Seleccione</option>
									<%		
					                if(anios!=null)
					                {					                
					                	for(int i=1;i<anios.length;i++)
										{
											String select="";
											if(i==1)
											{
												if(request.getParameter("anio")!=null)
												{												
													String str= anios[0][0].toString();
													if(anioAct.equals(str))
													{
														select="selected";
													}
													else
													{
														select="";
													}
												}
												%>
												<option value="<%=anios[0][0] %>" <%=select%>><%=anios[0][0] %></option>
												<% 	
											}											
											if(!anios[i][0].equals(anios[i-1][0]))
											{
												if(request.getParameter("anio")!=null)
												{
													String str= anios[i][0].toString();
													if(anioAct.equals(str))
													{
														select="selected";
													}
													else
													{
														select="";
													}
												}
												%>
												<option value="<%=anios[i][0] %>" <%=select%>><%=anios[i][0] %></option>
												<%
											}											
										}				                	
					                }
					                %>
								</select>
							</div>
						</div>
					</div>
					<!-- Div form Anual -->

					<div class="text-center">
						<input type="submit" class="btn btn-primary btn-sm"
							value="Generar" />
					</div>
					<% 
					//-----------------------REPORTE------------------------------//
				    if(filtro!=null)
				    {
				    	if(listIncidencias!=null)
				    	{
				    		if(filtro.equals("1")||filtro.equals("2"))
				    		{
				    		%>
							<!-- Div scroll style="overflow:scroll" -->
							<div class="panel-body" style="overflow-x:scroll">
								<table class="table table-hover table-bordered">
									<thead>
										<tr>
											<td class="text-danger" align="center" colspan="10">INCIDENCIAS</td>
										</tr>
										<tr>
											<td align="center"><b>NO.CASO</b></td>
											<td align="center"><b>IMPRESORA</b></td>
											<td align="center"><b>SOLICITANTE</b></td>
											<td align="center"><b>ENCARGADO</b></td>
											<td align="center"><b>TIPIFICACION</b></td>
											<td align="center"><b>FECHA<BR>INICIO
											</b></td>
											<td align="center"><b>FECHA <BR> VENCIMIENTO
											</b></td>
											<td align="center"><b>AREA</b></td>
											<td align="center"><b>ESTADO</b></td>
											<td align="center"><b>DETALLES</b></td>
										</tr>
									</thead>
									<tbody>
									  <% 
									  for(Incidencia inc:listIncidencias)
									  {
									  %>
										<tr>
											<td align="center">No.<%=inc.getId_incidencia() %>
											</td>
											<td align="center"><%=inc.getSerial_imp() %></td>
											<td align="center"><%=inc.getNombre_solicitante() %></td>
											<td align="center"><%=inc.getNombre_encargado() %></td>
											<td align="center"><%=inc.getNombre_tipificacion() %></td>
											<td align="center"><%=inc.getFecha_guardado() %></td>
											<td align="center"><%=inc.getFecha_maxima() %></td>
											<td align="center"><%=inc.getNombre_area() %></td>
											<td align="center"><%=inc.getNombre_estado() %></td>
											<td align="center"><a class="detalle" href="modules/client_reportes/detalles.jsp?id_incidencia=<%=inc.getId_incidencia() %>">Ver</a>
											</td>
										</tr>
										<%
									  }
									  %>
									</tbody>
								</table>
							</div>
							<%	
				    		}
				    		if(filtro.equals("2"))
				    		{
				    			String [][] tablaGrafica=null;
				    			//Codigo de Grafica
				    			if(listIncidencias.length!=1)
				    			{
				    				int posiciones=1;
					    			for(int i=1;i<listIncidencias.length;i++)
									{			
										if(listIncidencias[i].getId_tipificacion()!=listIncidencias[i-1].getId_tipificacion())
										{
											posiciones++;
										}
									}
					    			tablaGrafica = new String[posiciones][2];
					    			posiciones=1;
					    			int aux=0;
					    			int cont=1;
					    			for(int i=1;i<listIncidencias.length;i++)
									{			
										if(listIncidencias[i].getId_tipificacion()!=listIncidencias[i-1].getId_tipificacion())
										{
											
											tablaGrafica[posiciones-1][0]=listIncidencias[i-1].getNombre_tipificacion() ;
					    					tablaGrafica[posiciones-1][1]=cont+"";
					    					posiciones++;
					    					cont=1;
										}									
										else
										{
											cont++;	
										}	
										if(i==listIncidencias.length-1)
										{
											tablaGrafica[posiciones-1][0]=listIncidencias[i-1].getNombre_tipificacion() ;
					    					tablaGrafica[posiciones-1][1]=cont+"";
										}
									}
				    			}
				    			else
				    			{
				    				tablaGrafica = new String[1][2];
				    				tablaGrafica[0][0]=listIncidencias[0].getNombre_tipificacion()+"";
			    					tablaGrafica[0][1]="1";
				    			}				    			
				    		%>
							<br>
							<div id="datosPorTipificacion">
								<div>
									<table class="table table-bordered" style="width: 100%">
										<thead>
											<tr>
												<td class="text-danger" align="center" colspan="2">CANTIDAD DE INCIDENTES POR TIPIFICACION</td>
											</tr>
											<tr>
												<td align="center"><b>TIPIFICACION</b></td>
												<td align="center"><b>CANTIDAD</b></td>
											</tr>
										</thead>
										<tbody>
											<%
											for(int i=0;i<tablaGrafica.length;i++)
											{
											%>
											<tr>
												<td align="center"><%=tablaGrafica[i][0]%></td>
												<td align="center"><%=tablaGrafica[i][1]%></td>
											</tr>
											<%	
											}
											%>
										</tbody>
									</table>
								</div>
								<br>
								<br>
								<div id="grafTip"></div>
								<script>
								$(function () {
								    $('#grafTip').highcharts({
								        chart: {
								            plotBackgroundColor: null,
								            plotBorderWidth: null,
								            plotShadow: false,
								            type: 'pie'
								        },
								        title: {
								            text: 'Porcentaje por tipificacion'
								        },
								        tooltip: {
								            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
								        },
								        plotOptions: {
								            pie: {
								                allowPointSelect: true,
								                cursor: 'pointer',
								                dataLabels: {
								                    enabled: true,
								                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
								                    style: {
								                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
								                    }
								                }
								            }
								        },
								        series: [{
								            name: 'Brands',
								            colorByPoint: true,
								            data: 
								            [
								             <%
								             for(int i=0;i<tablaGrafica.length;i++)
								             {
								            	 int dato=Integer.parseInt(tablaGrafica[i][1]);
								             %>
								             	{
								                  name: '<%=tablaGrafica[i][0]%>',
								                  y: <%=dato%>
								               	},
								             <%
								             }
								             %>							               
								            ]
								        }]
								    });
								});
								</script>
							</div>
							<%	
				    		}	
				    		else if(filtro.equals("3"))
				    		{
				    			//Codigo de Grafica
				    			String [][] tablaGrafica=null;
				    			if(listIncidencias.length!=1)
				    			{
				    				int posiciones=1;				    			
					    			for(int i=1;i<listIncidencias.length;i++)
									{			
										if(listIncidencias[i].getMes()!=listIncidencias[i-1].getMes())
										{
											posiciones++;
										}
									}
					    			tablaGrafica = new String[posiciones][2];
					    			posiciones=1;
					    			int aux=0;
					    			int cont=1;
					    			for(int i=1;i<listIncidencias.length;i++)
									{			
										if(listIncidencias[i].getMes()!=listIncidencias[i-1].getMes())
										{										
											tablaGrafica[posiciones-1][0]=listIncidencias[i-1].getMes()+"";
					    					tablaGrafica[posiciones-1][1]=cont+"";
					    					posiciones++;
					    					cont=1;
										}									
										else
										{
											cont++;	
										}	
										if(i==listIncidencias.length-1)
										{
											tablaGrafica[posiciones-1][0]=listIncidencias[i].getMes()+"" ;
					    					tablaGrafica[posiciones-1][1]=cont+"";
										}
									}
				    			}
				    			else
				    			{
				    				tablaGrafica = new String[1][2];
				    				tablaGrafica[0][0]=listIncidencias[0].getMes()+"";
			    					tablaGrafica[0][1]="1";
				    			}
						    	%>
									<br>
									<br>
									<div id="datosPorAnio">
										<div id="grafAnual"></div>
										<script>
										$(function () {
										    $('#grafAnual').highcharts({
										    	chart: {
				
										            type: 'column'
										        },
										    	title: {
										            text: 'REPORTE INCIDENCIAS <%=anioAct%>',
										            x: -20 //center
										        },
										        subtitle: {
										            text: '',
										            x: -20
										        },
										        xAxis: {
										            categories: 
										            	[
															<%
															for(int i=0;i<tablaGrafica.length;i++)
															{
																int dato=Integer.parseInt(tablaGrafica[i][0]);
																String mes="";
																switch(dato)
																{
																	case 1: mes="Enero";break;
																	case 2: mes="Febrero";break;
																	case 3: mes="Marzo";break;
																	case 4: mes="Abril";break;
																	case 5: mes="Mayo";break;
																	case 6: mes="Junio";break;
																	case 7: mes="Julio";break;
																	case 8: mes="Agosto";break;
																	case 9: mes="Septiembre";break;
																	case 10: mes="Octubre";break;
																	case 11: mes="Noviembre";break;
																	case 12: mes="Diciembre";break;														
																}
															%>	
															'<%=mes%>',
															<%
															}
															%>
										                ]
										        },
										        yAxis: {
										            title: {
										                text: 'Cantidad'
										            },
										            plotLines: [{
										                value: 0,
										                width: 1,
										                color: '#808080'
										            }]
										        },
										        tooltip: {
										            valueSuffix: ''
										        },
										        legend: {
										            layout: 'vertical',
										            align: 'right',
										            verticalAlign: 'middle',
										            borderWidth: 0
										        },
										        series: 
										        [
													{
											            name: 'Incidencias',
											            data: 
											            	[
															<%
															for(int i=0;i<tablaGrafica.length;i++)
															{
																int dato=Integer.parseInt(tablaGrafica[i][1]);															
															%>	
															<%=dato%>,
															<%
															}
															%>
											            	]
											        },
										        ]
										    });
										});
										</script>
										<div>
											<table class="table table-bordered" style="width: 100%">
												<thead>
													<tr>
														<td class="text-danger" align="center" colspan="3">REPORTE
															ANUAL</td>
													</tr>
													<tr>
														<td align="center"><b>AÑO</b></td>
														<td align="center"><b>MES</b></td>
														<td align="center"><b>CANTIDAD</b></td>
													</tr>
												</thead>
												<tbody>
													<%
															for(int i=0;i<tablaGrafica.length;i++)
															{
															%>
													<tr>
														<td align="center"><%=anioAct%></td>
														<td align="center">
															<%
																	int dato=Integer.parseInt(tablaGrafica[i][0]);
																	String mes="";
																	switch(dato)
																	{
																		case 1: mes="Enero";break;
																		case 2: mes="Febrero";break;
																		case 3: mes="Marzo";break;
																		case 4: mes="Abril";break;
																		case 5: mes="Mayo";break;
																		case 6: mes="Junio";break;
																		case 7: mes="Julio";break;
																		case 8: mes="Agosto";break;
																		case 9: mes="Septiembre";break;
																		case 10: mes="Octubre";break;
																		case 11: mes="Noviembre";break;
																		case 12: mes="Diciembre";break;														
																	}
																	%> <%=mes%>
														</td>
														<td align="center"><%=tablaGrafica[i][1]%></td>
													</tr>
													<%	
													}
													%>
												</tbody>
											</table>
										</div>
										<br>
										<br>
										
									</div>
								<%	
					    		}
				    	}
				    	else
			    		{
			    		%>
						<br>
						<br>
						<center>
							<b>No hay registros</b>
						</center>
						<%	
			    		}//is_array list Incidencias					    			    	
				    }//Filtro null
				    %>
					<div id="graf" style="min-width: 310px; height: 400px; margin: 0 auto; display: none"></div>
					<script>
						//graf1();
					</script>
				</form>
			</div>
			<!-- Panel Body -->
		</div>
	</div>
</div>