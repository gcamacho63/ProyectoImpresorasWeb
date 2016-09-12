package controller.Impresoras;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Inicio.Login;
import model.Area;
import model.Ciudad;
import model.ConexionDB;
import model.Impresora;
import model.ModeloImpresora;

/**
 * Servlet implementation class ImpresorasServlet
 */
@WebServlet("/ImpresorasServlet")
public class ImpresorasServlet extends HttpServlet 
{
private static final long serialVersionUID = 1L;
	
	private String tabla="imp_impresoras";
	private String campoId="id_impresora";
	private String carpeta=Login.Encripta("client_impresoras");
	private String archivo=Login.Encripta("admin_impresoras.jsp");
	private String pagina="index.jsp?sec="+carpeta+"&mod="+archivo+"";
	private String mensaje = "";
	private String tipoMensaje = "";
	private String alerta="";
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		HttpSession sesion = request.getSession();								
		ConexionDB.conectarDB();
		String action = request.getParameter("accion");
		
		if(action!=null)
		{
			String idElemento =  request.getParameter("idElemento");
			if(action.equals("editar"))
			{
				Impresora[] editarArray = Impresora.Consultar(campoId+" = '"+idElemento+"'","");
				sesion.setAttribute("editarArray", editarArray);
				mensaje=null;
				tipoMensaje=null;
			}
			else if(action.equals("activar"))
			{
				if(ConexionDB.Update(tabla, "estado=0", campoId+" = '"+idElemento+"'"))
				{
					mensaje="Registro Activado";
					tipoMensaje="success";
				}
				else
				{
					mensaje="Error en la operacion";
					tipoMensaje="danger";
				}
			}
			else if(action.equals("desactivar"))
			{
				if(ConexionDB.Update(tabla, "estado=1", campoId+" = '"+idElemento+"'"))
				{
					mensaje="Registro Desactivado";
					tipoMensaje="success";
				}
				else
				{
					mensaje="Error en la operacion";
					tipoMensaje="danger";
				}
			}	
			inicializaListado(request);			
			request.getSession().setAttribute("mensaje", mensaje);
			request.getSession().setAttribute("tipoMensaje", tipoMensaje);
			response.sendRedirect(pagina);			
		}			
	}	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		//Campos recibidos del formulario
		
		String serial = request.getParameter("serial");		
		String area = request.getParameter("area");
		String modelo = request.getParameter("modelo");
		String ciudad = request.getParameter("ciudad");	
	
		//------------------------		
		String action = request.getParameter("accion");
				
		ConexionDB.conectarDB();
		if(action.equals("crear"))
		{		
			Impresora [] valida =Impresora.Consultar("serial= '"+serial+"'", "");
			if(valida==null)
			{
				if(ConexionDB.Insert(tabla, "serial,area,modelo,ciudad","'"+serial+"','"+area+"','"+modelo+"','"+ciudad+"'"))
				{
					mensaje="Registro guardado";
					tipoMensaje="success";
				}
				else
				{
					mensaje="Error en la operacion";
					tipoMensaje="danger";
				}
			}
			else
			{
				mensaje="Serial no disponible";
				tipoMensaje="danger";
			}
						
		}	
		else if(action.equals("actualizar"))
		{
			String idElemento =  request.getParameter("id_elemento");
			if(ConexionDB.Update(tabla, "serial= '"+serial+"',area ='"+area+"',modelo='"+modelo+"',ciudad ='"+ciudad+"'",campoId+" = '"+idElemento+"'"))
			{
				mensaje="Registro editado";
				tipoMensaje="success";
			}
			else
			{
				mensaje="Error en la operacion";
				tipoMensaje="danger";
			}
		}
		inicializaListado(request);
		request.getSession().setAttribute("mensaje", mensaje);
		request.getSession().setAttribute("tipoMensaje", tipoMensaje);
		response.sendRedirect(pagina);
	}
	
	//Metodo que inicializa el listado de objetos para el JSP
	public static void inicializaListado(HttpServletRequest request)
	{
		HttpSession sesion = request.getSession();
		Impresora[] listadoDeObjetos= Impresora.Consultar("1 ORDER BY imp.estado ASC","");
		if(listadoDeObjetos!=null)
		{
			sesion.setAttribute("listadoDeObjetos", listadoDeObjetos);
		}
	}
	public static void preparaPagina(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HttpSession sesion = request.getSession();
		inicializaListado(request);
		Ciudad[] ciudades=Ciudad.Consultar("1");
		sesion.setAttribute("ciudades", ciudades);
		ModeloImpresora[] modelosImpresora=ModeloImpresora.Consultar("estado = 0 ORDER BY nombre_modelo");
		sesion.setAttribute("modelosImpresora", modelosImpresora);
		Area[] areas= Area.Consultar("estado = 0 ORDER BY nombre_area");
		sesion.setAttribute("areas", areas);		
	}
}
