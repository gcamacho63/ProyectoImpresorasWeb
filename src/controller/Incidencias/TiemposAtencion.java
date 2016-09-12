package controller.Incidencias;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Inicio.Login;
import model.ModulosGrupos;
import model.TiempoAtencion;

/**
 * Servlet implementation class TiemposAtencion
 */
@WebServlet("/TiemposAtencion")
public class TiemposAtencion extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private String tabla="gen_modulos";
	private String campoId="id_modulo";
	private String carpeta=Login.Encripta("client_incicencias");
	private String archivo=Login.Encripta("tiempos_atencion.jsp");
	private String pagina="index.jsp?sec="+carpeta+"&mod="+archivo+"";
	private String mensaje = "";
	private String tipoMensaje = "";
	private String alerta="";
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

	}
	
	public static void preparaPagina(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HttpSession sesion = request.getSession();
		TiempoAtencion[] tiempo_activo= TiempoAtencion.Consultar("1 ORDER BY id_tiempo ASC LIMIT 1");
		sesion.setAttribute("tiempo_activo", tiempo_activo);
		TiempoAtencion[] tiemposHistorial= TiempoAtencion.Consultar("1 AND id_tiempo !=(select MAX(id_tiempo) FROM inc_tiempos_atencion)");
		sesion.setAttribute("tiemposHistorial", tiemposHistorial);
		//inicializaListado(request);
	}
}
