package controller.Incidencias;

import java.io.IOException;
import java.net.InetAddress;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.ConexionDB;
import model.Estado;
import model.Impresora;
import model.Incidencia;
import model.Tipificacion;
import model.Usuario;

/**
 * Servlet implementation class AdministrarIncidencias
 */
@WebServlet("/AdministrarIncidencias")
public class AdministrarIncidencias extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession sesion = request.getSession();
		String mensaje = null;
		String tipoMensaje = null;
		String alerta="";
		
		String idElemento =  request.getParameter("id_elemento");
		String estado	  =request.getParameter("estado");
		String comentario =request.getParameter("descripcion");
		if(idElemento!=null)
		{
			if(ConexionDB.Insert("inc_estados_incidencias", "incidencia,estado,comentario","'"+idElemento+"','"+estado+"','"+comentario+"'"))
			{
				if(ConexionDB.Update("inc_incidencias", "estadoActual='"+estado+"'", "id_incidencias = '"+idElemento+"'"))
				{
					mensaje="Cambio guardado";
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
				mensaje="Error en la operacion";
				tipoMensaje="danger";
			}							
			alerta="&mensaje="+mensaje+"&tipoMensaje="+tipoMensaje;
		}
		request.getSession().setAttribute("mensaje", mensaje);
		request.getSession().setAttribute("tipoMensaje", tipoMensaje);
		response.sendRedirect("modules/client_incidencias/editar_incidencia.jsp?id_incidencia="+idElemento);
	}
	
	public static void inicializaListado(HttpServletRequest request,String clausula)
	{
		HttpSession sesion = request.getSession();
		Incidencia[] listadoDeObjetos= Incidencia.Consultar(clausula);
		if(listadoDeObjetos!=null)
		{
			sesion.setAttribute("listadoDeObjetos", listadoDeObjetos);
		}
	}
	public static void preparaPagina(HttpServletRequest request, HttpServletResponse response,String condicion,String id,String estado) throws IOException
	{
		String clausula="";
		if(condicion.equals("1"))
		{
			clausula="id_incidencias= '"+id+"'";
		}
		else if(condicion.equals("2"))
		{
			clausula="estadoActual = '1'";
		}
		else if(condicion.equals("3"))
		{
			clausula="estadoActual != '30'";
		}
		else if(condicion.equals("4"))
		{
			clausula="1";
		}
		else if(condicion.equals("5"))
		{
			clausula="estadoActual = '"+estado+"'";
		}
		Estado[] estados=Estado.ConsultarEstados("1");
		request.getSession().setAttribute("estados", estados);
		inicializaListado(request,clausula);
	}
	public static Estado[] consultaEstados(int estado)
	{
		Estado estados[]=null;
		if(estado!=0)
		{
			if(estado>=1&&estado<10)
			{
				estados=Estado.ConsultarEstados("id_estado >"+estado+" and id_estado <11 order by id_estado;");
			}
			else if(estado>=10&&estado<20)
			{
				estados=Estado.ConsultarEstados("id_estado>"+estado+" and id_estado<21 order by id_estado;");
			}
			else if(estado>=20&&estado<30)
			{
				estados=Estado.ConsultarEstados("id_estado>"+estado+" and id_estado<31 order by id_estado;");
			}			
		}
		return estados;
	}
}