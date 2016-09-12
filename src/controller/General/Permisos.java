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
import model.ModulosGrupos;
import model.Rol;
import model.General.PermisosModulos;

/**
 * Servlet implementation class Permisos
 */
@WebServlet("/Permisos")
public class Permisos extends HttpServlet 
{
	private static final long serialVersionUID = 1L;     
	private String carpeta=Login.Encripta("client_general");
	private String archivo=Login.Encripta("admin_permisos.jsp");
	private String pagina="index.jsp?sec="+carpeta+"&mod="+archivo+"";
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
			
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession sesion = request.getSession();
		String action = request.getParameter("accion");
		String rol = request.getParameter("rol");
		int idRol = Integer.parseInt(rol);
		String Grupo = request.getParameter("grupo");
		int idGrupo = Integer.parseInt(Grupo);
		ConexionDB.conectarDB();
		boolean validaPermiso=false;
		Object[][] mod= ConexionDB.Consulta("id_modulo,nombre", "gen_modulos", "grupo = "+idGrupo);
		PermisosModulos[] perModulos= new PermisosModulos[mod.length];
		//-------------------------Buscar Permisos--------------------------- 
		if(action.equals("buscar"))
		{										 
			for(int i=0;i<mod.length;i++)
			{
				Object [][] permiso = ConexionDB.Consulta("*","gen_modulos_permisos","id_rol = '"+idRol+"' AND id_modulo = '"+mod[i][0]+"'");
				
				if(permiso!=null)
				{
					validaPermiso=true;
				}
				else
				{
					validaPermiso=false;
				}
				perModulos[i] = new PermisosModulos((int)mod[i][0],(String)mod[i][1],idRol,validaPermiso);
			}
			sesion.setAttribute("perMod", perModulos);
			response.sendRedirect(pagina+"&rol="+idRol+"&gruoup="+idGrupo);
		}
		//-----------------------------Guardar Cambios-------------------
		else if(action.equals("guardar"))
		{
			String[] permisos = request.getParameterValues("permisos[]");
			//Borra los permisos actuales sobre el grupo de herramientas
			for(int i=0;i<mod.length;i++)
			{
				ConexionDB.Delete("gen_modulos_permisos","id_rol= '"+idRol+"' AND id_modulo= '"+mod[i][0]+"'");
			}
			if(permisos!=null)
			{
				//Ingresa los nuevos Permisos
				for(String modulo: permisos)
				{
					ConexionDB.Insert("gen_modulos_permisos","id_rol,id_modulo", idRol+","+modulo);
				}
			}	
            sesion.setAttribute("alerta", "success");
			
            //Consulta las modificaciones para cargar a la pagina nuevamente
            for(int i=0;i<mod.length;i++)
			{
				Object [][] permiso = ConexionDB.Consulta("*","gen_modulos_permisos","id_rol = '"+idRol+"' AND id_modulo = '"+mod[i][0]+"'");
				
				if(permiso!=null)
				{
					validaPermiso=true;
				}
				else
				{
					validaPermiso=false;
				}
				perModulos[i] = new PermisosModulos((int)mod[i][0],(String)mod[i][1],idRol,validaPermiso);
			}
			sesion.setAttribute("perMod", perModulos);
            response.sendRedirect(pagina+"&rol="+idRol+"&gruoup="+idGrupo);
		}				
	}
	public static void preparaPagina(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		//inicializaListado(request);
		//response.sendRedirect(pagina);
		HttpSession sesion = request.getSession();
		ConexionDB.conectarDB();
		Rol[] roles=Rol.ConsultarRoles("1");
		sesion.setAttribute("roles", roles);
		ModulosGrupos[] grupos=ModulosGrupos.ConsultarGrupos("1");
		sesion.setAttribute("ModulosGrupos", grupos);
	}
}
