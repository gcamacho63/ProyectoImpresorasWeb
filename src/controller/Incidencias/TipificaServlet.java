package controller.Incidencias;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Inicio.Login;
import model.ConexionDB;
import model.Tipificacion;

/**
 * Servlet implementation class TipificaServlet
 */
@WebServlet("/TipificaServlet")
public class TipificaServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	
	private String carpeta=Login.Encripta("client_incidencias");
	private String archivo=Login.Encripta("admin_tipificaciones.jsp");
	private String pagina="index.jsp?sec="+carpeta+"&mod="+archivo+"";
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession sesion = request.getSession();
		String mensaje = null;
		String tipoMensaje = null;		
		ConexionDB.conectarDB();
		String action = request.getParameter("accion");
		if(action!=null)
		{
			String idTipificacion =  request.getParameter("idTipificacion");
			if(action.equals("editar"))
			{
				Tipificacion[] tipEditar = Tipificacion.ConsultarTipificaciones("id_tipificacion = '"+idTipificacion+"'");
				sesion.setAttribute("tipEditar", tipEditar);
				response.sendRedirect(pagina);
				mensaje=null;
				tipoMensaje=null;
			}
			else if(action.equals("activar"))
			{
				if(ConexionDB.Update("inc_tipificacion", "estado=0", "id_tipificacion = '"+idTipificacion+"'"))
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
				if(ConexionDB.Update("inc_tipificacion", "estado=1", "id_tipificacion = '"+idTipificacion+"'"))
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
			Tipificacion[] tip=Tipificacion.ConsultarTipificaciones("1 ORDER BY estado,id_tipificacion DESC");
			sesion.setAttribute("tip", tip);
			if(!action.equals("editar"))
			{
				request.getSession().setAttribute("mensaje", mensaje);
				request.getSession().setAttribute("tipoMensaje", tipoMensaje);
				response.sendRedirect(pagina);
			}			
		}	
		else
		{
			Tipificacion[] tip=Tipificacion.ConsultarTipificaciones("1 ORDER BY estado,id_tipificacion DESC");
			sesion.setAttribute("tip", tip);	             
			request.getSession().setAttribute("mensaje", mensaje);
			request.getSession().setAttribute("tipoMensaje", tipoMensaje);
			response.sendRedirect(pagina);
		}	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession sesion = request.getSession();
		String nombre = request.getParameter("nombre");
		String descripcion = request.getParameter("descripcion");
		String action = request.getParameter("accion");
		ConexionDB.conectarDB();
		String mensaje="";
		String tipoMensaje="";
		if(action.equals("crear"))
		{		
			if(ConexionDB.Insert("inc_tipificacion", "nombre_tipificacion,descripcion","'"+nombre+"','"+descripcion+"'"))
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
			String idTipificacion =  request.getParameter("id_elemento");
			if(ConexionDB.Update("inc_tipificacion", "nombre_tipificacion= '"+nombre+"',descripcion ='"+descripcion+"'","id_tipificacion = '"+idTipificacion+"'"))
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
		Tipificacion[] tip=Tipificacion.ConsultarTipificaciones("1 ORDER BY estado,id_tipificacion DESC");
		sesion.setAttribute("tip", tip);
		request.getSession().setAttribute("mensaje", mensaje);
		request.getSession().setAttribute("tipoMensaje", tipoMensaje);
		response.sendRedirect(pagina);
	}
}
