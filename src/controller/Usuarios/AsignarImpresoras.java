package controller.Usuarios;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Inicio.Login;
import model.ConexionDB;
import model.Impresora;
import model.Modulo;
import model.ModulosGrupos;
import model.Usuario;
import model.General.PermisosModulos;

/**
 * Servlet implementation class AsignarImpresoras
 */
@WebServlet("/AsignarImpresoras")
public class AsignarImpresoras extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private String tabla="gen_modulos";
	private String campoId="id_modulo";
	private String carpeta=Login.Encripta("client_usuarios");
	private String archivo=Login.Encripta("asignar_impresoras.jsp");
	private String pagina="index.jsp?sec="+carpeta+"&mod="+archivo+"";
	private String mensaje = "";
	private String tipoMensaje = "";
	private String alerta="";
	
	private Usuario userObj=null;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession sesion = request.getSession();
		String action = request.getParameter("accion");
		String user = request.getParameter("user");
		
		ConexionDB.conectarDB();
		//-------------------------Buscar Permisos--------------------------- 
		if(action.equals("buscar"))
		{										 
			if(user!=null)
			{
				Usuario[] userArray = Usuario.Consultar("id_usuario = '"+user+"'");
				if(userArray!=null)
				{
					userObj= userArray[0];
				}
			}
			prepara2(user,request);
			response.sendRedirect(pagina);
		}
		//-----------------------------Guardar Cambios-------------------
		else if(action.equals("guardar"))
		{
			String[] permisos = request.getParameterValues("permisos[]");
			//Borra los permisos actuales sobre el grupo de herramientas
			ConexionDB.Delete("user_impresoras_usuarios","usuario ='"+user+"'");
			if(permisos!=null)
			{
				//Ingresa los nuevos Permisos
				mensaje="Cambios guardados correctamente";
				tipoMensaje = "success";
				for(String imp: permisos)
				{
					if(!(ConexionDB.Insert("user_impresoras_usuarios","usuario,impresora", user+","+imp)))
					{
						mensaje="Fallo en la operacion";
						tipoMensaje = "danger";
					}
				}
			}			
            prepara2(user,request);
            request.getSession().setAttribute("mensaje", mensaje);
			request.getSession().setAttribute("tipoMensaje", tipoMensaje);
			response.sendRedirect(pagina);
		}			
	}
	public void prepara2(String user,HttpServletRequest request)
	{
		HttpSession sesion = request.getSession();
		Impresora [] impresoras = Impresora.Consultar("imp.estado = '0'", "");
		Impresora [] impActivas =Impresora.Consultar("imp.estado = '0' AND impUser.usuario = '"+user+"'", "RIGHT JOIN user_impresoras_usuarios impUser ON imp.id_impresora = impUser.impresora");
		sesion.setAttribute("user", userObj);
		sesion.setAttribute("impresoras", impresoras);
		sesion.setAttribute("impActivas", impActivas);
	}	
	public static void preparaPagina(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		HttpSession sesion = request.getSession();
		Usuario[] usuarios= Usuario.Consultar("us.estado = '0' AND rol_usuario='3'");
		sesion.setAttribute("usuarios", usuarios);
	}
}
