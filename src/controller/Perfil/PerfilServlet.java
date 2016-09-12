package controller.Perfil;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

import controller.Inicio.Login;

import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import model.Area;
import model.Ciudad;
import model.ConexionDB;
import model.Usuario;

/**
 * Servlet implementation class PerfilServlet
 */
@WebServlet("/PerfilServlet")
public class PerfilServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
    
	private String tabla="user_usuarios";
	private String campoId="id_usuario";
	private String carpeta=Login.Encripta("client_perfil");
	private String archivo=Login.Encripta("admin_perfil.jsp");
	private String pagina="index.jsp?sec="+carpeta+"&mod="+archivo+"";
	private String mensaje = "";
	private String tipoMensaje = "";
	private String alerta="";
	
	private String dirUploadFiles; //directorio donde se guardara los archivos
	
	//Para generar cadena aleatoria
	static final String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	static SecureRandom rnd = new SecureRandom();

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException 
	{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
	
		// 1. obtengo el directorio donde guardare los archivos, desde un parametro de
		// contexto en el archivo web.xml
		dirUploadFiles = getServletContext().getRealPath( getServletContext().getInitParameter( "dirUploadFiles" ) );
	
		// 2. Si la peticion es de tipo multi-part,
		// static boolean isMultipartContent() devuelve true/false
		if(ServletFileUpload.isMultipartContent( request ) )
		{
			 // 3. crear el arhivo factory
			 // DiskFileItemfactory es una implementacion de FileItemfactory
			 // esta implementacion crea una instacia de FileItem que guarda su
			 // contenido ya sea en la memoria, para elementos pequeños,
			 // o en un archivo temporal en el disco, para los
			 // elementos de mayor tamaño
			 FileItemFactory factory = new DiskFileItemFactory();	
			 // 4. crear el servlet upload
			 // es un API de alto nivel para procesar subida de archivos
			 // Por defecto la instancia de ServletFileUpload tiene los siguientes valores:
			 // * Size threshold = 10,240 bytes. Si el tamaño del archivo está por debajo del umbral,
			 //   se almacenará en memoria. En otro caso se almacenara en un archivo temporal en disco.
			 // * Tamaño Maximo del cuerpo de la request HTTP = -1.
			 //   El servidor aceptará cuerpos de request de cualquier tamaño.
			 // * Repository = Directorio que el sistema usa para archivos temporales.
			 //   Se puede recuperar llamando a System.getProperty("java.io.tmpdir").
			 ServletFileUpload upload = new ServletFileUpload( factory );
			 /* 5. declaro listUploadFiles
			  * Contendrá una lista de items de archivo que son instancias de FileItem
			  *	Un item de archivo puede contener un archivo para upload o un
			  * campo del formulario con la estructura simple nombre-valor
			  * (ejemplo: <input name="text_field" type="text" />)
			  *
			  * Podemos cambiar las opciones mediante setSizeThreshold() y setRespository()
				de la clase DiskFileItemFactory y el
				método setSizeMax() de la clase ServletFileUpload, por ejemplo:
		
					 DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory();
					 diskFileItemFactory.setSizeThreshold(40960); // bytes
		
					 File repositoryPath = new File("/temp");
					 diskFileItemFactory.setRepository(repositoryPath);
		
					 ServletFileUpload servletFileUpload = new ServletFileUpload(diskFileItemFactory);
					 servletFileUpload.setSizeMax(81920); // bytes		
			  *
			  */
			 // limito a 300 Kb el humbral del tamaño del archivo a subir
			 // Long.parseLong( getServletContext().getInitParameter( "maxFileSize" ) )
			 upload.setSizeMax(3000000); // 1024 x 300 = 307200 bytes = 300 Kb
		
			 List listUploadFiles = null;
			 FileItem item = null;
		
			 try
			 {
				 // 6. adquiere la lista de FileItem asociados a la peticion
				 listUploadFiles = upload.parseRequest(new ServletRequestContext(request));
		
				 /* 7. Iterar para obtener todos los FileItem
				  * vamos a trabajar con generalidad
				  * programaremos como si quisieramos leer todos los
				  * campos sean 'simples' o 'file'. Por ello iteramos
				  * sobre todos los FileItem que recibimos:
				  * Los parámetros simples los diferenciaremos de los parámetros 'file'
				  * por medio del método isFormField()
				  */
				 Iterator it = listUploadFiles.iterator();
				 while( it.hasNext() )
				 {
					 item = ( FileItem ) it.next();
					 // 8. evaluamos si el campo es de tipo file, para subir al servidor
					 if( !item.isFormField() )
					 {
						 //9. verificamos si el archivo es > 0
						 if( item.getSize() > 0 )
						 {
							 // 10. obtener el nombre del archivo
							 String nombre   = item.getName();                 
							 // 11. obtener el tipo de archivo
							 // e. .jpg = "image/jpeg", .txt = "text/plain"
							 String tipo     = item.getContentType();
							 // 12. obtener el tamaño del archivo
							 long tamanio    = item.getSize();
							 // 13. obtener la extension
							 String extension = nombre.substring( nombre.lastIndexOf( "." ) );
				  
							 out.println( "Nombre: " + nombre + "<br>");
							 out.println( "Tipo: " + tipo + "<br>");
							 out.println( "Extension: " + extension + "<br>");
							 // 14. determinar si el caracter slash es de linux, o windows
							 //String slashType = ( nombre.lastIndexOf( "\\" ) > 0 ) ?  "\\" : "/"; // Windows o Linux
							 // 15. obtener la ultima posicion del slash en el nombre del archivo
							 //int startIndex = nombre.lastIndexOf( slashType );
							 // 16. obtener el nombre del archivo ignorando la ruta completa
							 //String myArchivo = nombre.substring( startIndex + 1, nombre.length() );
							 // 17. Guardo archivo del cliente en servidor, con un nombre 'fijo' y la
							 // extensión que me manda el cliente,
							 // Create new File object
							 String nameFile=creaPass()+"_"+nombre;
							 File archivo = new File(dirUploadFiles,nameFile );						 
				  
							 // 18. Write the uploaded file to the system
							 item.write( archivo );
							 if(archivo.exists())
							 {
								 Usuario user=(Usuario) request.getSession().getAttribute("userLog");
								 int id=user.getId_usuario();
								 String imgAnterior= user.getFoto();								 							 
								 if(ConexionDB.Update(tabla, "imagen_perfil='"+nameFile+"'","id_usuario= '"+id+"'"))
								 {
									 mensaje="Imagen actualizada";
									 tipoMensaje="success";
									 File fileAnterior = new File(dirUploadFiles, imgAnterior);	
									 if(fileAnterior.exists())
									 {
										fileAnterior.delete();
									 }
								 }
								 else
								 {
									 mensaje="No se pudo actualizar la imagen";
									 tipoMensaje="danger";
								 }
							 }
							 else
							 {								 
								 // nunca se llega a ejecutar
								 //out.println( "FALLO AL GUARDAR. NO EXISTE " + dirUploadFiles + "</p>");
							 }		
						 }
					 }
				 }	
			 }
			 catch( FileUploadException e )
			 {
				 e.printStackTrace(); 
				 mensaje="No se pudo actualizar la imagen";
				 tipoMensaje="danger";
			 }
			 catch (Exception e)
			 {
				 // poner respuesta = false; si existe alguna problema
				 e.printStackTrace();
				 mensaje="No se pudo actualizar la imagen";
				 tipoMensaje="danger";
			 } 
		}
		request.getSession().setAttribute("mensaje", mensaje);
		request.getSession().setAttribute("tipoMensaje", tipoMensaje);
		response.sendRedirect("modules/client_perfil/subir_imagen.jsp");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String contrasenia=request.getParameter("contra");
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
		if(action!=null)
		{
			if(action.equals("actualizar"))
			{
				String idElemento =  request.getParameter("id_elemento");
				String cadena="nombre1='"+nombre1+"',nombre2='"+nombre2+"',apellido1='"+ape1+"',apellido2='"+ape2+"',cargo='"+cargo+"',area='"+area+"',";
				cadena +="ciudad='"+ciudad+"',correo='"+correo+"',extension='"+ext+"'";
				String cambiacont=request.getParameter("cambiacont");
				if(cambiacont!=null)
				{
					cadena+=",contrasenia=MD5('"+contrasenia+"')";
				}
				cadena +="";
				if(ConexionDB.Update(tabla,cadena,campoId+" = '"+idElemento+"'"))
				{
					mensaje="Perfil actualizado";
					tipoMensaje="success";
				}
				else
				{
					mensaje="Error en la operacion";
					tipoMensaje="danger";
				}
			}
			request.getSession().setAttribute("mensaje", mensaje);
			request.getSession().setAttribute("tipoMensaje", tipoMensaje);
			response.sendRedirect(pagina);
		}		
		else if(ServletFileUpload.isMultipartContent(request))
		{		
			processRequest(request, response);					
        }			
	}
	
	public static void preparaPagina(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HttpSession sesion = request.getSession();
		Area[] areas= Area.Consultar("estado = 0");
		Ciudad[] ciudades=Ciudad.Consultar("1");
		sesion.setAttribute("areas", areas);
		sesion.setAttribute("ciudades", ciudades);
	}
	public String creaPass()
	{
		StringBuilder sb = new StringBuilder(5 );
		   for( int i = 0; i < 5; i++ ) 
		      sb.append( AB.charAt( rnd.nextInt(AB.length()) ) );
		   return sb.toString();
	}
}
