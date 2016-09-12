package controller.Impresoras;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Inicio.Login;
import model.ConexionDB;
import model.ModeloImpresora;

/**
 * Servlet implementation class ModelosServlet
 */
@WebServlet("/ModelosServlet")
public class ModelosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private String tabla="imp_modelos";
	private String campoId="id_modelo";
	private String carpeta=Login.Encripta("client_impresoras");
	private String archivo=Login.Encripta("admin_modelos.jsp");
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
				ModeloImpresora[] editarArray = ModeloImpresora.Consultar(campoId+" = '"+idElemento+"'");
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
		
		String nombre_modelo = request.getParameter("nombre_modelo");
		String descripcion = request.getParameter("descripcion");		
	
		//------------------------		
		String action = request.getParameter("accion");
				
		ConexionDB.conectarDB();
		if(action.equals("crear"))
		{		
			if(ConexionDB.Insert(tabla, "nombre_modelo,descripcion","'"+nombre_modelo+"','"+descripcion+"'"))
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
		else if(action.equals("actualizar"))
		{
			String idElemento =  request.getParameter("id_elemento");
			if(ConexionDB.Update(tabla, "nombre_modelo= '"+nombre_modelo+"',descripcion ='"+descripcion+"'" ,campoId+" = '"+idElemento+"'"))
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
		ModeloImpresora[] listadoDeObjetos= ModeloImpresora.Consultar("1 ORDER BY estado ASC");
		if(listadoDeObjetos!=null)
		{
			sesion.setAttribute("listadoDeObjetos", listadoDeObjetos);
		}
	}
	public static void preparaPagina(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		/*HttpSession sesion = request.getSession();
		ModeloImpresora[] gruposTodos= ModeloImpresora.Consultar("estado = 0");
		sesion.setAttribute("gruposTodos", gruposTodos);*/
		inicializaListado(request);
	}
}