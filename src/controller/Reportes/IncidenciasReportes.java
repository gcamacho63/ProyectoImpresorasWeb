package controller.Reportes;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Inicio.Login;
import model.ConexionDB;
import model.Incidencia;
import model.Tipificacion;

/**
 * Servlet implementation class IncidenciasReportes
 */
@WebServlet("/IncidenciasReportes")
public class IncidenciasReportes extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	private String carpeta=Login.Encripta("client_reportes");
	private String archivo=Login.Encripta("incidencias_reporte.jsp");
	private String pagina="index.jsp?sec="+carpeta+"&mod="+archivo+"";
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession sesion = request.getSession();
		String tipo = request.getParameter("tipo");
		Incidencia listIncidencias[]=null;
		String getAdd="";
		ConexionDB.conectarDB();
		if(tipo!=null)
		{	
			String fechaini=request.getParameter("fechaini");
			String fechafin=request.getParameter("fechafin");
			String tipificacion = request.getParameter("tipificacion");
			String anio=request.getParameter("anio");
			String clausula="";			
			if(tipo.equals("1"))//Tipificacion y fechas
			{
				clausula="tipificacion ='"+tipificacion+"' AND fecha_guardado BETWEEN CAST('"+fechaini+"' AS DATE) AND CAST('"+fechafin+"' AS DATE);";	
				getAdd="&tip="+tipificacion+"&f1="+fechaini+"&f2="+fechafin;
			}
			else if(tipo.equals("2"))//Fechas
			{
				clausula="fecha_guardado BETWEEN CAST('"+fechaini+"' AS DATE) AND CAST('"+fechafin+"' AS DATE) ORDER BY tipificacion;";	
				getAdd="&f1="+fechaini+"&f2="+fechafin;
			}
			else if(tipo.equals("3"))//Reporte Anual
			{
				clausula="anio = '"+anio+"';";	
				getAdd="&anio="+anio;
			}
			listIncidencias=Incidencia.Consultar(clausula);			
			sesion.setAttribute("listIncidencias", listIncidencias);
		}
		response.sendRedirect(pagina+"&filtro="+tipo+getAdd);
	}

	public static void preparaPagina(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HttpSession sesion = request.getSession();
		Tipificacion[] listadoDeObjetos= Tipificacion.ConsultarTipificaciones("1");
		if(listadoDeObjetos!=null)
		{
			sesion.setAttribute("listadoDeTipificaciones", listadoDeObjetos);
		}
		Object [][] anios =ConexionDB.Consulta("anio", "inc_incidencias", "1 ORDER BY anio");
		if(anios!=null)
		{
			sesion.setAttribute("anios", anios);
		}
	}
}
