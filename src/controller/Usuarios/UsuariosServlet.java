package controller.Usuarios;

import java.io.File;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


//Read more: http://javarevisited.blogspot.com/2013/07/ile-upload-example-in-servlet-and-jsp-java-web-tutorial-example.html#ixzz4IxSEWAsC

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.text.html.HTMLDocument.Iterator;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import controller.Inicio.Login;

//import com.sun.xml.internal.bind.v2.schemagen.xmlschema.List;

import model.Area;
import model.Ciudad;
import model.ConexionDB;
import model.Modulo;
import model.ModulosGrupos;
import model.Rol;
import model.Usuario;

/**
 * Servlet implementation class UsuariosServlet
 */
@WebServlet("/UsuariosServlet")
public class UsuariosServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private String tabla="user_usuarios";
	private String campoId="id_usuario";
	private String carpeta=Login.Encripta("client_usuarios");
	private String archivo=Login.Encripta("admin_usuarios.jsp");
	private String pagina="index.jsp?sec="+carpeta+"&mod="+archivo+"";
	private String mensaje = "";
	private String tipoMensaje = "";
	
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
				Usuario[] editarArray = Usuario.Consultar(campoId+" = '"+idElemento+"'");
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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		String usuario=request.getParameter("usuario");
		String contrasenia=request.getParameter("contra");
		String rol=request.getParameter("rol");
		String nombre1=request.getParameter("nombre1");
		String nombre2=request.getParameter("nombre2");
		String ape1=request.getParameter("ape1");
		String ape2=request.getParameter("ape2");
		String cargo=request.getParameter("cargo");;
		String area=request.getParameter("area");
		String ciudad=request.getParameter("ciudad");
		String correo=request.getParameter("correo");
		String ext=request.getParameter("ext");
		String ext2=request.getParameter("ext2");
		
		//------------------------		
		String action = request.getParameter("accion");
						
		ConexionDB.conectarDB();
		if(action.equals("crear"))
		{					
			Object [][] valida =ConexionDB.Consulta("*", tabla, "usuario = '"+usuario+"'");
			if(valida==null)
			{
				String campos="usuario,contrasenia,rol_usuario,nombre1,nombre2,apellido1,apellido2,cargo,area,";
				campos+="ciudad,correo,extension";
				String cadena="'"+usuario+"',MD5('"+contrasenia+"'),'"+rol+"','"+nombre1+"','"+nombre2+"','"+ape1+"','"+ape2+"',";
				cadena+="'"+cargo+"','"+area+"','"+ciudad+"','"+correo+"','"+ext+"'";
				if(ConexionDB.Insert(tabla, campos,cadena))
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
				mensaje="El usuario ya esta registrado";
				tipoMensaje="danger";
			}
			
			if(ServletFileUpload.isMultipartContent(request))
			{
				System.out.println("Con archivo");
				try 
	            {
	                List<FileItem> multiparts = new ServletFileUpload(
	                                         new DiskFileItemFactory()).parseRequest((RequestContext) request);
	              
	                for(FileItem item : multiparts){
	                    if(!item.isFormField()){
	                        String name = new File(item.getName()).getName();
	                        item.write( new File("" + File.separator + name));
	                    }
	                }
	           
	               //File uploaded successfully
	               request.setAttribute("message", "File Uploaded Successfully");
	            } catch (Exception ex) 
	            {
	               request.setAttribute("message", "File Upload Failed due to " + ex);
	            }          
	         
	        }
			else
			{
	            System.out.println("Sin archivo");
	        }				
		}	
		else if(action.equals("actualizar"))
		{
			String idElemento =  request.getParameter("id_elemento");
			String cadena="usuario='"+usuario+"',rol_usuario='"+rol+"',nombre1='"+nombre1+"',nombre2='"+nombre2+"',apellido1='"+ape1+"',apellido2='"+ape2+"',cargo='"+cargo+"',area='"+area+"',";
			cadena +="ciudad='"+ciudad+"',correo='"+correo+"',extension='"+ext+"'";
			String cambiacont=request.getParameter("cambiacont");
			if(cambiacont!=null)
			{
				cadena+=",contrasenia=MD5('"+contrasenia+"')";
			}
			cadena +="";
			if(ConexionDB.Update(tabla,cadena,campoId+" = '"+idElemento+"'"))
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
		Usuario[] listadoDeObjetos= Usuario.Consultar("1 ORDER BY us.estado,id_usuario DESC");
		if(listadoDeObjetos!=null)
		{
			sesion.setAttribute("listadoDeObjetos", listadoDeObjetos);
		}
	}
	public static void preparaPagina(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HttpSession sesion = request.getSession();
		Area[] areas= Area.Consultar("estado = 0");
		Ciudad[] ciudades=Ciudad.Consultar("1");
		Rol[] roles = Rol.ConsultarRoles("1");
		sesion.setAttribute("areas", areas);
		sesion.setAttribute("ciudades", ciudades);
		sesion.setAttribute("roles", roles);
		inicializaListado(request);
	}
}