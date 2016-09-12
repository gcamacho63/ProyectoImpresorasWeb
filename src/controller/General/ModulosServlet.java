package controller.General;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Inicio.Login;
import model.ConexionDB;
import model.Modulo;
import model.ModulosGrupos;


/**
 * Servlet implementation class ModulosServlet
 */
@WebServlet("/ModulosServlet")
public class ModulosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private String tabla="gen_modulos";
	private String campoId="id_modulo";
	private String carpeta=Login.Encripta("client_general");
	private String archivo=Login.Encripta("admin_modulos.jsp");
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
				Modulo[] editarArray = Modulo.Consultar(campoId+" = '"+idElemento+"'");
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
			sesion.setAttribute("mensaje", mensaje);
			sesion.setAttribute("tipoMensaje", tipoMensaje);
			response.sendRedirect(pagina);			
		}	
		else
		{
			
		}		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		//Campos recibidos del formulario
		HttpSession sesion = request.getSession();
		String nombre = request.getParameter("nombre");
		String descripcion = request.getParameter("descripcion");
		String grupo=request.getParameter("grupo");
		String archivo= request.getParameter("archivo");
		String controlador = request.getParameter("controlador");
		//------------------------		
		String action = request.getParameter("accion");
				
		ConexionDB.conectarDB();
		if(action.equals("crear"))
		{		
			if(ConexionDB.Insert(tabla, "nombre,descripcion,grupo,archivo,controlador","'"+nombre+"','"+descripcion+"',"+grupo+",'"+archivo+"','"+controlador+"'"))
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
			if(ConexionDB.Update(tabla, "nombre= '"+nombre+"',descripcion ='"+descripcion+"',grupo ='"+grupo+"',archivo ='"+archivo+"',controlador ='"+controlador+"'" ,campoId+" = '"+idElemento+"'"))
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
		sesion.setAttribute("mensaje", mensaje);
		sesion.setAttribute("tipoMensaje", tipoMensaje);
		response.sendRedirect(pagina);
	}
	
	//Metodo que inicializa el listado de objetos para el JSP
	public static void inicializaListado(HttpServletRequest request)
	{
		HttpSession sesion = request.getSession();
		Modulo[] listadoDeObjetos= Modulo.Consultar("1 ORDER BY m.estado,grupo DESC");
		if(listadoDeObjetos!=null)
		{
			sesion.setAttribute("listadoDeObjetos", listadoDeObjetos);
		}
	}
	public static void preparaPagina(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HttpSession sesion = request.getSession();
		ModulosGrupos[] gruposTodos= ModulosGrupos.ConsultarGrupos("estado = 0");
		sesion.setAttribute("gruposTodos", gruposTodos);
		inicializaListado(request);
	}
}
